# EspoCRM Entity Manager & Layout Manager Best Practices
## How to Safely Use Entity Manager with Caching

**Date:** November 3, 2025  
**Context:** After TESTPERM optimization campaign, preparing for field management

---

## 🔴 CRITICAL: CACHING ISSUE DISCOVERED

### **The Problem:**
EspoCRM's caching system can interfere with Entity Manager and Layout Manager operations:

- ❌ **Cached metadata** prevents immediate field changes
- ❌ **Stale layouts** persist after modifications
- ❌ **Rebuild operations** may use cached data instead of fresh JSON
- ❌ **Field deletions** may not take effect immediately
- ❌ **Layout changes** may not display correctly

**This likely explains:**
- Why Entity Manager field deletion caused errors
- Why rebuilds reverted our optimizations
- Why some changes didn't "stick"

---

## ✅ RECOMMENDED WORKFLOW

### **Option A: Disable Cache During Field/Layout Editing (SAFEST)**

**When to use:** Making ANY Entity Manager or Layout Manager changes

**Steps:**
1. **Disable Cache:**
   - Go to: Administration → Settings → System tab
   - Uncheck "Use Cache" ☐
   - Click "Save"

2. **Make Your Changes:**
   - Use Entity Manager to add/edit/remove fields
   - Use Layout Manager to arrange fields
   - Test changes immediately

3. **Re-enable Cache:**
   - Check "Use Cache" ☑
   - Click "Save"
   - Clear cache: Administration → Clear Cache

**Pros:**
- ✅ Changes take effect immediately
- ✅ No stale metadata issues
- ✅ Safer for field operations

**Cons:**
- ⚠️ Slightly slower performance while disabled
- ⚠️ Must remember to re-enable

---

### **Option B: Manual Cache Clear After Every Change**

**When to use:** If you want to keep cache enabled

**Steps:**
1. Make change in Entity Manager/Layout Manager
2. **Immediately clear cache:** Administration → Clear Cache
3. **Or via CLI:** `php clear_cache.php`
4. Test the change

**Pros:**
- ✅ Cache stays enabled
- ✅ Good performance

**Cons:**
- ⚠️ Must clear cache after EVERY change
- ⚠️ Easy to forget
- ⚠️ May still have timing issues

---

## 🎯 SPECIFIC RECOMMENDATIONS FOR YOUR USE CASES

### **1. Moving Fields in PWD Screen**
**Best approach:** **Disable cache** temporarily

```
Workflow:
1. Disable cache in Settings
2. Go to Layout Manager → PWD → Detail
3. Drag fields to desired positions
4. Save layout
5. Test immediately (refresh PWD record)
6. Re-enable cache
7. Clear cache
```

**Why:** Layout changes need immediate feedback to verify positions

---

### **2. Removing Unused Fields from TESTPERM Detail Panel**
**Best approach:** **Disable cache** temporarily

```
Workflow:
1. Identify fields in right panel dock (unused fields)
2. Disable cache in Settings
3. Go to Layout Manager → TESTPERM → Detail
4. Remove fields from layout (don't delete from entity!)
5. Save layout
6. Test immediately
7. Re-enable cache
8. Clear cache
```

**Important:** 
- Removing from layout ≠ deleting from entity
- Layout removal = just hide from UI
- Entity deletion = remove field from database (risky!)

**Strategy:**
- First: Remove from layout (safe, reversible)
- Later: If confirmed unused, delete from entity (permanent)

---

### **3. Finding True Field Names for TESTPERM**
**How to identify fields sitting in the dock:**

```bash
# Get all fields in TESTPERM
ssh permtrak2@permtrak.com "cd /home/permtrak2/dev.permtrak.com/EspoCRM && \
php command.php app:run-script scripts/get-entity-fields.php --entity=TESTPERM"

# Or via JSON:
grep -o '"[^"]*": {' entityDefs/TESTPERM.json | sed 's/": {//' | sed 's/"//g' | sort
```

**Then compare with layout file:**
```bash
# Get fields actually used in detail layout
ssh permtrak2@permtrak.com "cat /home/permtrak2/dev.permtrak.com/EspoCRM/custom/Espo/Custom/Resources/layouts/TESTPERM/detail.json" | grep -o '"name": "[^"]*"' | sort | uniq
```

**Fields NOT in layout but in entity = candidates for removal from layout dock**

---

## 🔍 CHECKING CURRENT CACHE STATUS

### **Via Admin UI:**
- Administration → Settings → System tab
- Look for "Use Cache" checkbox

### **Via CLI:**
```bash
# Check if cache is enabled
cd /home/permtrak2/dev.permtrak.com/EspoCRM
php command.php config-get useCache

# Check cache directory size
du -sh data/cache/

# List cached files
ls -lh data/cache/application/
```

### **Via Config File:**
```bash
# Check data/config.php
grep -i cache /home/permtrak2/dev.permtrak.com/EspoCRM/data/config.php
```

---

## ⚠️ CACHE TYPES IN ESPOCRM

### **1. Application Cache (Main Cache)**
- **Location:** `data/cache/application/`
- **What it caches:** Metadata, entity defs, layouts, configs
- **Cleared by:** "Clear Cache" button or `php clear_cache.php`
- **Impact:** HIGH - affects Entity Manager

### **2. Template Cache**
- **Location:** `data/cache/templates/`
- **What it caches:** Smarty templates, UI components
- **Impact:** Medium - affects UI rendering

### **3. ORM Metadata Cache**
- **What it caches:** Database schema, entity relationships
- **Impact:** HIGH - affects field operations
- **Cleared by:** Rebuild

### **4. Browser Cache**
- **Location:** User's browser
- **What it caches:** CSS, JS, images
- **Impact:** Low - cosmetic only
- **Cleared by:** Hard refresh (Ctrl+Shift+R)

---

## 🛠️ TROUBLESHOOTING CACHE ISSUES

### **Symptom: Field changes don't appear**
**Solution:**
1. Clear EspoCRM cache (Clear Cache button)
2. Hard refresh browser (Ctrl+Shift+R)
3. If still not working: Disable cache, make change again

### **Symptom: Layout changes don't stick**
**Solution:**
1. Disable cache
2. Make layout change
3. Save
4. Test immediately
5. Re-enable cache
6. Clear cache

### **Symptom: rebuild reverts optimizations**
**Solution:**
1. Ensure JSON metadata is synchronized with database BEFORE rebuild
2. Consider disabling cache before rebuild
3. Or avoid rebuild entirely (use direct SQL + JSON updates)

---

## 📋 SAFE FIELD REMOVAL WORKFLOW (TESTPERM EXAMPLE)

### **Phase 1: Identify Candidates (No Cache Impact)**
```bash
# List all TESTPERM fields
grep -o '"[^"]*": {' entityDefs/TESTPERM.json | sed 's/": {//' | sed 's/"//g' > all_fields.txt

# List fields in detail layout
ssh permtrak2@permtrak.com "cat /path/to/layouts/TESTPERM/detail.json" | \
  grep -o '"name": "[^"]*"' | sed 's/"name": "//;s/"//g' | sort | uniq > layout_fields.txt

# Find fields NOT in layout (candidates for removal from dock)
comm -23 <(sort all_fields.txt) <(sort layout_fields.txt)
```

### **Phase 2: Remove from Layout (Safe, Cache-Sensitive)**
```
1. DISABLE CACHE
2. Go to Layout Manager → TESTPERM → Detail
3. Find unused fields in right panel dock
4. Remove them from layout (just hide, don't delete entity)
5. Save
6. Test immediately
7. RE-ENABLE CACHE
8. Clear cache
```

### **Phase 3: Verify No Usage (No Cache Impact)**
```sql
-- Check if field has any data
SELECT COUNT(*) FROM t_e_s_t_p_e_r_m WHERE field_name IS NOT NULL AND field_name != '';

-- If 0, safe to consider for deletion
```

### **Phase 4: Delete from Entity (Permanent, Cache-Sensitive)**
```
1. DISABLE CACHE
2. Backup JSON: cp TESTPERM.json TESTPERM.json.backup
3. Use Entity Manager to delete field
4. OR manually: Remove from JSON + ALTER TABLE DROP COLUMN
5. Clear cache
6. Test thoroughly
7. RE-ENABLE CACHE
```

---

## ✅ RECOMMENDED SETTINGS FOR FIELD MANAGEMENT

### **During Active Development/Optimization:**
```
Use Cache: ☐ DISABLED
Use WebSocket: ☐ (your choice)
Maintenance Mode: ☐ (not needed)
Disable Cron: ☐ (not needed)
```

### **For Normal Production Use:**
```
Use Cache: ☑ ENABLED
Use WebSocket: ☑ (if needed)
Maintenance Mode: ☐
Disable Cron: ☐
```

---

## 🎯 ACTION ITEMS FOR YOU

### **Immediate:**
1. ✅ **Disable cache** in Settings (screenshot shows it's currently enabled)
2. ✅ Identify unused fields in TESTPERM detail panel
3. ✅ Remove unused fields from layout (hide, don't delete)
4. ✅ Test layout looks correct
5. ✅ Re-enable cache
6. ✅ Clear cache

### **For PWD Field Positioning:**
1. ✅ Disable cache
2. ✅ Use Layout Manager to arrange PWD fields
3. ✅ Save and test
4. ✅ Re-enable cache

### **Future:**
- ✅ Always disable cache when using Entity Manager
- ✅ Always clear cache after metadata changes
- ✅ Document which fields are in which layouts

---

## 📚 ADDITIONAL RESOURCES

### **Clear Cache Methods:**
```bash
# Method 1: Admin UI
Administration → Clear Cache

# Method 2: CLI
cd /home/permtrak2/dev.permtrak.com/EspoCRM
php clear_cache.php

# Method 3: Manual (nuclear option)
rm -rf data/cache/*
php rebuild.php  # Rebuild after manual cache deletion
```

### **Verify Cache is Cleared:**
```bash
# Check cache directory is empty
ls -la data/cache/application/
# Should show minimal files or empty

# Check a specific record loads fresh
# Open any TESTPERM record, should show latest field definitions
```

---

## ⚠️ WARNINGS

1. **Never use `rebuild --hard` with cache enabled** - May revert optimizations
2. **Never delete fields without disabling cache first** - May cause errors
3. **Always clear cache after direct JSON edits** - Prevent stale metadata
4. **Always test immediately after disabling cache** - Get accurate feedback

---

## STATUS

**Cache Currently:** ✅ Identified as enabled (per screenshot)  
**Recommendation:** ✅ Disable temporarily for field/layout work  
**Impact:** ⚠️ Likely caused previous Entity Manager issues  
**Solution:** ✅ Follow workflows above  

**Next:** Disable cache → Edit layouts → Re-enable cache

