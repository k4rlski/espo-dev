# TESTPERM Field Deletion Guide - Entity Manager Method

**Date:** 2025-11-03  
**Method:** Manual deletion via EspoCRM Entity Manager (UI)

---

## ✅ Why Use Entity Manager?

**Entity Manager is the PROPER way to delete fields in EspoCRM:**

1. ✅ **Automatic cleanup** - Drops columns, updates metadata
2. ✅ **Safe** - Built-in validation and warnings
3. ✅ **Complete** - Updates layouts, relationships, permissions
4. ✅ **Reversible** - Can be undone if needed
5. ✅ **No SQL required** - Point-and-click interface
6. ✅ **Updates JSON** - Metadata files updated automatically

---

## 🎯 Phase 4a: Fields to Delete

### **TIER 1: Confirmed NULL Fields (6 fields, ~1,520 bytes)**

These fields have ZERO data and are completely safe to delete:

| Field Name | Label | Type | Size | Status | Bytes Freed |
|------------|-------|------|------|--------|-------------|
| `parentid` | Parent ID | VARCHAR | 255 | NULL (0 records) | 1020 |
| `attyfirm` | Attorney Firm | VARCHAR | 255 | NULL (0 records) | 1020 |
| `domainname` | Domain Name | VARCHAR | 255 | NULL (0 records) | 1020 |
| `coemailpermadsloginurl` | PermAds Login URL | VARCHAR | 100 | NULL (0 records) | 400 |
| `swasmartlink` | SWA Smart Link | VARCHAR | 80 | NULL (0 records) | 320 |
| `jobaddress_country` | Job Address Country | VARCHAR | 100 | NULL (0 records) | 400 |

**Tier 1 Subtotal: ~4,180 bytes freed** (accounting for overhead)

---

### **TIER 2: Extremely Low Usage (< 0.1%) - REVIEW FIRST**

These fields have minimal data - consider if they're worth keeping:

From our earlier link analysis, we know:
- `transactions` link: 0.01% used (2/16,705 records) - **Already removed**
- `communications` link: 0.006% used (1/16,705) - **Already removed**

**Additional candidates to investigate:**
- Fields with < 10 records used out of 16,705
- Legacy fields no longer in active use
- Duplicate data stored elsewhere

**Action:** You should manually review field usage in Entity Manager before deleting.

---

## 📋 Step-by-Step Deletion Process

### **Step 1: Access Entity Manager**

1. Go to **dev.permtrak.com/EspoCRM**
2. Log in as admin
3. Click **Administration** (top-right gear icon)
4. Click **Entity Manager**
5. Find and click **TESTPERM** entity

### **Step 2: Review Field Before Deletion**

For each field you want to delete:

1. Click on the **field name** in the list
2. Review:
   - Field type
   - Current settings
   - Any dependencies shown
3. Check if field appears in any:
   - Layouts (List, Detail, Edit views)
   - Filters
   - Formulas
   - Workflows

### **Step 3: Delete Field**

1. Click the **field name** to edit
2. Click **Remove** button (usually red, bottom of form)
3. Confirm deletion when prompted
4. EspoCRM will:
   - Drop the database column
   - Update entityDefs JSON
   - Remove from all layouts
   - Clear cache automatically

### **Step 4: Verify Deletion**

After each deletion:
1. Refresh the page
2. Confirm field no longer appears in list
3. Open a TESTPERM record to verify field is gone
4. Check that existing records still work

### **Step 5: Test Thoroughly**

After deleting all fields:
1. Open existing TESTPERM records
2. Edit and save records
3. Create new TESTPERM records
4. Search for records
5. Export records to CSV
6. Verify no errors in browser console

---

## ⚠️ Important Warnings

### **Before You Delete:**

1. ⚠️ **Test on dev.permtrak.com ONLY** - Never delete on production first
2. ⚠️ **Backup first** - Entity Manager changes are immediate
3. ⚠️ **One at a time** - Delete fields individually to isolate issues
4. ⚠️ **Check usage** - Even NULL fields might be referenced in code
5. ⚠️ **Document** - Keep list of what you deleted

### **Cannot Be Easily Reversed:**

While you can recreate fields, you CANNOT:
- ❌ Restore the data (unless you have backup)
- ❌ Undo the deletion (no "undo" button)
- ❌ Recover the exact field ID

### **Fields You Should NOT Delete:**

These are critical system fields:
- ❌ `id`, `name`, `deleted`
- ❌ `createdAt`, `modifiedAt`
- ❌ `createdBy`, `modifiedBy`
- ❌ `assignedUser`, `teams`
- ❌ Any link fields actively in use
- ❌ Any fields used in formulas/workflows

---

## 📊 Expected Results

### After Deleting TIER 1 (6 fields):

```
Current:        26,325 bytes (324.0% capacity)
After Deletion: ~22,145 bytes (272.6% capacity)
Savings:        ~4,180 bytes
```

**Still 2.7x over the limit** - More work needed!

---

## 🎯 Recommended Deletion Order

**Delete in this order for safety:**

1. **First:** `parentid` (most obviously unused)
2. **Second:** `attyfirm` (NULL, no controversy)
3. **Third:** `domainname` (NULL, simple)
4. **Fourth:** `coemailpermadsloginurl` (NULL, URL field)
5. **Fifth:** `swasmartlink` (NULL, legacy?)
6. **Sixth:** `jobaddress_country` (NULL, address component)

**Test after EACH deletion** to ensure nothing breaks.

---

## 🔄 What Happens Behind the Scenes

When you delete a field via Entity Manager, EspoCRM:

1. ✅ Removes field from `entityDefs/TESTPERM.json`
2. ✅ Drops column from `t_e_s_t_p_e_r_m` table via SQL
3. ✅ Removes from all layouts (list, detail, edit, search)
4. ✅ Updates clientDefs if needed
5. ✅ Clears cache automatically
6. ✅ Removes from field manager metadata
7. ✅ Updates any affected indexes

**You don't have to do ANY of this manually!**

---

## 🧪 Verification Queries

After deletion, verify in database:

```sql
-- Check field is gone from table
DESC t_e_s_t_p_e_r_m;

-- Check row size after deletion
SELECT 
    SUM(CASE WHEN DATA_TYPE = 'varchar' THEN CHARACTER_MAXIMUM_LENGTH * 4 
        WHEN DATA_TYPE = 'int' THEN 4 
        WHEN DATA_TYPE = 'bigint' THEN 8 
        WHEN DATA_TYPE = 'tinyint' THEN 1 
        WHEN DATA_TYPE = 'double' THEN 8 
        WHEN DATA_TYPE = 'datetime' THEN 8 
        WHEN DATA_TYPE = 'date' THEN 3 
        ELSE 0 END) as bytes_used,
    8126 as limit_bytes,
    ROUND(SUM(CASE WHEN DATA_TYPE = 'varchar' THEN CHARACTER_MAXIMUM_LENGTH * 4 
        WHEN DATA_TYPE = 'int' THEN 4 
        WHEN DATA_TYPE = 'bigint' THEN 8 
        WHEN DATA_TYPE = 'tinyint' THEN 1 
        WHEN DATA_TYPE = 'double' THEN 8 
        WHEN DATA_TYPE = 'datetime' THEN 8 
        WHEN DATA_TYPE = 'date' THEN 3 
        ELSE 0 END) / 8126 * 100, 1) as percent_used
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'permtrak2_dev' 
  AND TABLE_NAME = 't_e_s_t_p_e_r_m'
  AND DATA_TYPE != 'text';
```

---

## 📋 Checklist

**Before Starting:**
- [ ] Logged into dev.permtrak.com as admin
- [ ] Confirmed working on DEV, not PROD
- [ ] Reviewed field list above
- [ ] Ready to test after each deletion

**For Each Field:**
- [ ] Opened field in Entity Manager
- [ ] Verified it's truly unused (NULL data)
- [ ] Clicked Remove button
- [ ] Confirmed deletion
- [ ] Tested TESTPERM record (open, edit, save)
- [ ] Verified no console errors

**After All Deletions:**
- [ ] Opened multiple TESTPERM records
- [ ] Created new TESTPERM record
- [ ] Searched for records
- [ ] Exported records to CSV
- [ ] Ran verification query (check row size)
- [ ] No errors in browser console
- [ ] Documented what was deleted

---

## 🎯 After Phase 4a

Once you've deleted the 6 NULL fields via Entity Manager:

**Expected State:**
- Row size: ~22,145 bytes (272.6% capacity)
- Still need: ~14,019 more bytes
- Still 2.7x over limit

**Next Steps:**
- **Phase 4b:** Convert more fields to TEXT (~5K bytes)
- **Phase 4c:** Entity split (~10K bytes)
- **Combined:** Get under 8,126 byte limit ✅

---

## ✅ Advantages of This Approach

**vs Manual SQL/JSON editing:**
- ✅ Safer (Entity Manager has validations)
- ✅ Cleaner (handles all related files)
- ✅ Easier (point-and-click vs code editing)
- ✅ Faster (no need to commit/deploy)
- ✅ Immediate (changes apply instantly)
- ✅ Professional (the "proper" EspoCRM way)

---

**Ready to start deleting fields via Entity Manager?**

**URL:** https://dev.permtrak.com/EspoCRM/#Admin/entityManager

**Start with:** `parentid` field (safest, most obviously unused)

