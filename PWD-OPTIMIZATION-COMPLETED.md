# PWD Entity MySQL Optimization - COMPLETED

**Date:** November 3, 2025  
**Status:** ✅ Phase 1 Complete - JSON Metadata Updated  
**Database:** Not yet deployed (needs rebuild on server)

---

## ✅ COMPLETED CHANGES

### Phase 1: VARCHAR Field Optimizations

All planned VARCHAR field length reductions have been successfully applied to `PWD.json`:

| Field | Before | After | Bytes Saved | Status |
|-------|--------|-------|-------------|--------|
| **`name`** | No maxLength/dbType | VARCHAR(100) with dbType | **620 bytes** | ✅ Complete |
| `visatype` | maxLength 100 (ENUM) | maxLength 50 with dbType | **200 bytes** | ✅ Complete |
| `coveredbyacwia` | maxLength 100 (ENUM) | maxLength 10 with dbType | **360 bytes** | ✅ Complete |
| `empsoccodes` | maxLength 60 | maxLength 30 with dbType | **120 bytes** | ✅ Complete |
| `onettitlecombo` | maxLength 60 | maxLength 50 with dbType | **40 bytes** | ✅ Complete |
| `altforeignlanguage` | maxLength 60 | maxLength 40 with dbType | **80 bytes** | ✅ Complete |

**Total Potential Savings: 1,420 bytes**

---

## 📝 CHANGES MADE TO PWD.json

### 1. `name` Field (Line 3-11)
```json
"name": {
    "type": "varchar",
    "maxLength": 100,
    "dbType": "varchar(100)",
    "len": 100,
    "required": true,
    "trim": true,
    "pattern": "$noBadCharacters"
}
```
**Change:** Added maxLength=100, dbType, and len attributes  
**Savings:** ~620 bytes per row (from default 255)

### 2. `empsoccodes` Field (Line 384-391)
```json
"empsoccodes": {
    "type": "varchar",
    "maxLength": 30,
    "dbType": "varchar(30)",
    "len": 30,
    "options": [],
    "isCustom": true
}
```
**Change:** Reduced from maxLength=60 to 30, added dbType and len  
**Savings:** ~120 bytes per row

### 3. `altforeignlanguage` Field (Line 569-576)
```json
"altforeignlanguage": {
    "type": "varchar",
    "maxLength": 40,
    "dbType": "varchar(40)",
    "len": 40,
    "options": [],
    "isCustom": true
}
```
**Change:** Reduced from maxLength=60 to 40, added dbType and len  
**Savings:** ~80 bytes per row

### 4. `onettitlecombo` Field (Line 680-687)
```json
"onettitlecombo": {
    "type": "varchar",
    "maxLength": 50,
    "dbType": "varchar(50)",
    "len": 50,
    "options": [],
    "isCustom": true
}
```
**Change:** Reduced from maxLength=60 to 50, added dbType and len  
**Savings:** ~40 bytes per row

### 5. `coveredbyacwia` Field (Line 853-870)
```json
"coveredbyacwia": {
    "type": "enum",
    "options": ["Yes", "No", "NA"],
    "default": "NA",
    "style": {
        "Yes": null,
        "No": null,
        "NA": null
    },
    "maxLength": 10,
    "dbType": "varchar(10)",
    "len": 10,
    "isCustom": true
}
```
**Change:** Reduced from maxLength=100 to 10, added dbType and len  
**Savings:** ~360 bytes per row

### 6. `visatype` Field (Line 871-886)
```json
"visatype": {
    "type": "enum",
    "options": ["PERM", "NA"],
    "style": {
        "PERM": null,
        "NA": null
    },
    "default": "NA",
    "maxLength": 50,
    "dbType": "varchar(50)",
    "len": 50,
    "isCustom": true
}
```
**Change:** Reduced from maxLength=100 to 50, added dbType and len  
**Savings:** ~200 bytes per row

---

## 📊 EXPECTED RESULTS

### Before Optimization
```
bytes_used:      7,949
limit_bytes:     8,126
bytes_remaining: 177
percent_used:    97.8%
Status:          DANGEROUSLY CLOSE TO LIMIT
```

### After Optimization (Projected)
```
bytes_used:      6,529 (estimated)
limit_bytes:     8,126
bytes_remaining: 1,597
percent_used:    80.3%
Status:          HEALTHY - 19.7% buffer available
```

**Improvement:**
- ✅ Reduced usage by 17.5 percentage points
- ✅ Increased safety buffer from 177 bytes (2.2%) to 1,597 bytes (19.7%)
- ✅ Room for future growth (e.g., adding back the 14 ENUM fields = 28 bytes)

---

## 🔄 BACKUP FILES CREATED

1. **`PWD.json.backup`** - Pre-existing backup (23K, Nov 3 03:59)
2. **`PWD.json.backup-20251103_052858`** - Backup created before today's edits (23K)
3. **`PWD.json`** - Current optimized version (24K)

---

## ⚠️ NEXT STEPS - DEPLOYMENT REQUIRED

The JSON metadata has been updated locally in:
```
/home/falken/DEVOPS Dropbox/DEVOPS-KARL/CORE-v4/2-ESPOCRM/ESPO-AUTOMATION/espo-dev/entityDefs/PWD.json
```

**To apply these changes to the DEV server:**

### Option A: Manual Deployment
1. Copy the updated `PWD.json` to the server:
   ```bash
   scp "PWD.json" permtrak2@permtrak.com:/home/permtrak2/dev.permtrak.com/EspoCRM/custom/Espo/Custom/Resources/metadata/entityDefs/
   ```

2. SSH to the server and rebuild:
   ```bash
   ssh permtrak2@permtrak.com
   cd /home/permtrak2/dev.permtrak.com/EspoCRM
   php command.php clear-cache
   php command.php rebuild
   ```

3. Verify the changes:
   ```bash
   mysql -h permtrak.com -u permtrak2_dev -p'xX-6x8-Wcx6y8-9hjJFe44VhA-Xx' permtrak2_dev -e "
   SELECT 
       SUM(CASE
           WHEN DATA_TYPE = 'varchar' THEN CHARACTER_MAXIMUM_LENGTH * 4
           WHEN DATA_TYPE IN ('text', 'mediumtext', 'longtext') THEN 9
           WHEN DATA_TYPE IN ('int', 'date', 'datetime', 'timestamp') THEN 4
           WHEN DATA_TYPE = 'tinyint' THEN 1
           WHEN DATA_TYPE = 'enum' THEN 2
           ELSE 0
       END) as bytes_used,
       8126 as limit_bytes,
       8126 - SUM(CASE
           WHEN DATA_TYPE = 'varchar' THEN CHARACTER_MAXIMUM_LENGTH * 4
           WHEN DATA_TYPE IN ('text', 'mediumtext', 'longtext') THEN 9
           WHEN DATA_TYPE IN ('int', 'date', 'datetime', 'timestamp') THEN 4
           WHEN DATA_TYPE = 'tinyint' THEN 1
           WHEN DATA_TYPE = 'enum' THEN 2
           ELSE 0
       END) as bytes_remaining,
       ROUND(SUM(CASE
           WHEN DATA_TYPE = 'varchar' THEN CHARACTER_MAXIMUM_LENGTH * 4
           WHEN DATA_TYPE IN ('text', 'mediumtext', 'longtext') THEN 9
           WHEN DATA_TYPE IN ('int', 'date', 'datetime', 'timestamp') THEN 4
           WHEN DATA_TYPE = 'tinyint' THEN 1
           WHEN DATA_TYPE = 'enum' THEN 2
           ELSE 0
       END) / 8126 * 100, 1) as percent_used
   FROM INFORMATION_SCHEMA.COLUMNS
   WHERE TABLE_SCHEMA = 'permtrak2_dev' AND TABLE_NAME = 'p_w_d';
   " 2>&1 | grep -v "Warning"
   ```

### Option B: Git-based Deployment (Recommended)
If you have Git initialized in the metadata directory:

1. Commit the changes:
   ```bash
   cd /home/falken/DEVOPS\ Dropbox/DEVOPS-KARL/CORE-v4/2-ESPOCRM/ESPO-AUTOMATION/espo-dev
   git add entityDefs/PWD.json
   git commit -m "PWD optimization: Reduce VARCHAR lengths (saved 1,420 bytes)

   - name: Added maxLength=100 with dbType (saved 620 bytes)
   - empsoccodes: 60→30 (saved 120 bytes)
   - altforeignlanguage: 60→40 (saved 80 bytes)
   - onettitlecombo: 60→50 (saved 40 bytes)
   - coveredbyacwia: 100→10 (saved 360 bytes)
   - visatype: 100→50 (saved 200 bytes)
   
   Total saved: 1,420 bytes
   New capacity: 80.3% (1,597 bytes buffer)"
   git push origin main
   ```

2. Pull on the server:
   ```bash
   ssh permtrak2@permtrak.com
   cd /home/permtrak2/dev.permtrak.com/EspoCRM/custom/Espo/Custom/Resources/metadata
   git pull origin main
   cd /home/permtrak2/dev.permtrak.com/EspoCRM
   php command.php clear-cache
   php command.php rebuild
   ```

---

## ⚠️ IMPORTANT CONSIDERATIONS

### 1. Data Truncation Risk
The `name` field was reduced from 255 to 100 characters. Before deploying, you should check if any existing data exceeds 100 characters:

```sql
SELECT 
    name,
    LENGTH(name) as name_length
FROM p_w_d 
WHERE LENGTH(name) > 100
ORDER BY LENGTH(name) DESC
LIMIT 10;
```

If any records exist with name > 100 chars, you may need to:
- Increase the maxLength to accommodate existing data
- Or manually truncate/edit those records before deploying

### 2. Testing on DEV First
- These changes have been tested for JSON validity ✅
- They have NOT been tested on a live database yet
- Deploy to DEV first, test thoroughly
- Only deploy to PROD after DEV validation

### 3. Rollback Plan
If issues occur after deployment:
1. The backup files are available in the same directory
2. Copy the backup back: `cp PWD.json.backup-20251103_052858 PWD.json`
3. Re-run `php command.php rebuild`

---

## 📈 PHASE 2: Add 14 ENUM Fields (FUTURE)

After this optimization is deployed and verified, you'll have enough space to add back the 14 ENUM fields that were commented out in the PWD extractor script:

| # | Field Name | Database Column | Bytes | Purpose |
|---|-----------|----------------|-------|---------|
| 1 | `case_status` | `statcase` | 2 | Case status dropdown |
| 2 | `visa_classification` | `visaclass` | 2 | Visa type (H-1B, etc.) |
| 3 | `attorney_type` | `typeofrep` | 2 | Attorney/Agent type |
| 4 | `acwia_status_changed` | `statacwiachanged` | 2 | ACWIA status flag |
| 5 | `prof_sports` | `profsportsleague` | 2 | Professional sports flag |
| 6 | `wage_source` | `wagesourcerequested` | 2 | Wage source dropdown |
| 7 | `supervise` | `supervise_other_emp` | 2 | Supervises others flag |
| 8 | `education_level` | `requirededucationlevel` | 2 | Education requirement |
| 9 | `second_education` | `secondeducation` | 2 | Alternate education flag |
| 10 | `training_required` | `requiredtraining` | 2 | Training required flag |
| 11 | `experience_required` | `requiredexperience` | 2 | Experience required flag |
| 12 | `alt_training` | `alttraining` | 2 | Alt training flag |
| 13 | `alt_experience` | `altexperience` | 2 | Alt experience flag |
| 14 | `travel_required` | `travelrequired` | 2 | Travel required flag |

**Total space needed:** 28 bytes  
**Available after Phase 1:** 1,597 bytes  
**Remaining after Phase 2:** 1,569 bytes (19.3% buffer)

---

## 📚 RELATED DOCUMENTATION

- **Original Plan:** `PWD-OPTIMIZATION-PLAN.md`
- **Optimization Tool:** `../espo-ctl/espo-optimize.py`
- **EspoCRM Guide:** `../espo-ctl/markdown/EspoCRM_Metadata_MySQL_Optimization_Guide.md`
- **Row Size Crisis History:** `../pwdx-espo/markdown/MYSQL-ROW-SIZE-CRISIS-RESOLVED.md` (if exists)

---

## ✅ VALIDATION CHECKLIST

Before deploying to production:

- [x] JSON syntax validated (no linter errors)
- [x] Backup files created
- [x] All 6 optimizations applied correctly
- [ ] Changes committed to Git
- [ ] Deployed to DEV server
- [ ] DEV rebuild successful
- [ ] Database row size verified (should show ~80% usage)
- [ ] No data truncation issues
- [ ] PWD entity functional testing passed
- [ ] Ready for PROD deployment

---

**Completed by:** AI Assistant (Cursor)  
**Review by:** User (DEVOPS-KARL)  
**Deployment:** Pending user action

