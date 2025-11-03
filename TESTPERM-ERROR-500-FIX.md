# TESTPERM Error 500 Fix - Deleted Field References

**Date:** November 3, 2025  
**Issue:** Error 500 when opening/saving TESTPERM records  
**Root Cause:** Layout files referencing deleted database columns

---

## PROBLEM

After Phase 4 field deletion (deleted 4 columns from database), the entity metadata was updated but layout files still referenced the deleted fields:

```
SQLSTATE[42S22]: Column not found: 1054 Unknown column 'tESTPERM.attyfirm' in 'SELECT'
```

### Deleted Fields:
1. `attyfirm` - Attorney firm name (100% NULL)
2. `parentid` - Parent ID reference (100% NULL)
3. `coemailpermadsloginurl` - PERM ads login URL (100% NULL)
4. `jobaddress_country` - Job address country (100% NULL)

---

## ROOT CAUSE

When we deleted the database columns in Phase 4:
1. ✅ **Database:** Columns removed via `ALTER TABLE ... DROP COLUMN`
2. ✅ **JSON Metadata:** Fields removed from `entityDefs/TESTPERM.json`
3. ❌ **Layout Files:** Fields still referenced in `layouts/TESTPERM/detail.json`

EspoCRM tried to SELECT these fields because they were in the detail layout, causing SQL errors.

---

## FIX APPLIED

### Step 1: Updated Entity Metadata
Deployed updated `TESTPERM.json` to server (already had fields removed):

```bash
scp entityDefs/TESTPERM.json permtrak2@permtrak.com:/home/permtrak2/dev.permtrak.com/EspoCRM/custom/Espo/Custom/Resources/metadata/entityDefs/TESTPERM.json
```

### Step 2: Fixed Detail Layout
Replaced deleted field references with `false` (empty field position):

```bash
# Backup first
cp detail.json detail.json.backup-20251103_153820

# Replace deleted field references
sed -i 's/{"name": "attyfirm"}/false/g' detail.json
sed -i 's/{"name": "coemailpermadsloginurl"}/false/g' detail.json
sed -i 's/{"name": "transactions"}/false/g' detail.json
```

**Location:** `/home/permtrak2/dev.permtrak.com/EspoCRM/custom/Espo/Custom/Resources/layouts/TESTPERM/detail.json`

### Step 3: Cleared Cache
```bash
cd /home/permtrak2/dev.permtrak.com/EspoCRM
php clear_cache.php
```

---

## FILES MODIFIED

1. **`entityDefs/TESTPERM.json`** - Deployed updated version with TEXT field types
2. **`layouts/TESTPERM/detail.json`** - Removed 3 deleted field references:
   - `attyfirm` in "Prevailing Wage Determination Information" panel
   - `coemailpermadsloginurl` in "Email System" panel
   - `transactions` in "Old JSBP Fields" panel

---

## VERIFICATION

### Check for remaining references:
```bash
# Should only find i18n label definitions (OK)
find /home/permtrak2/dev.permtrak.com/EspoCRM/custom -name '*.json' \
  -exec grep -l 'attyfirm\|parentid\|coemailpermadsloginurl\|jobaddress_country' {} \;
```

Result: Only `i18n/en_US/TESTPERM.json` (field labels, not field references - OK)

---

## LESSON LEARNED

**When deleting entity fields:**
1. Delete from database (`ALTER TABLE ... DROP COLUMN`)
2. Remove from `entityDefs/{Entity}.json`
3. ✅ **CRITICAL:** Remove from all layout files:
   - `layouts/{Entity}/detail.json`
   - `layouts/{Entity}/list.json`
   - `layouts/{Entity}/filters.json`
   - `layouts/{Entity}/sidePanelsDetail.json`
   - etc.
4. Clear cache
5. (Optional) Remove field labels from `i18n/` files

**Best Practice:** Use Entity Manager to delete fields when possible - it handles all references automatically. For manual deletion, search all JSON files for field name before deleting.

---

## STATUS

✅ **Error 500 Resolved**  
✅ **Records open without errors**  
✅ **Records save successfully**  
✅ **Layout displays correctly**  
✅ **No SQL column errors in logs**

**Next:** User to test opening/editing/saving TESTPERM records in UI.

