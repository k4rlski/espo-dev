# PWD Entity MySQL Optimization Plan
**Database:** `permtrak2_dev` (DEV)  
**Table:** `p_w_d`  
**Date:** November 3, 2025

---

## 🔴 CURRENT STATUS - CRITICAL

```
Current Usage:  7,949 bytes / 8,126 bytes (97.8%)
Remaining:      177 bytes
Status:         DANGEROUSLY CLOSE TO LIMIT
```

**Problem:** We need to restore 14 ENUM fields (28 bytes), but we're too close to the limit for safety.

---

## 📋 THE 14 ENUM FIELDS WE NEED TO RESTORE

These were commented out in `pwdx-espo-extract-and-convert.py`:

| # | Field Name (EspoCRM) | Database Column | Bytes Each | Purpose |
|---|---------------------|-----------------|------------|---------|
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

**Total space needed:** 14 fields × 2 bytes = **28 bytes**

---

## 🎯 OPTIMIZATION STRATEGY

### Phase 1: Reduce Oversized VARCHAR Fields (Immediate)

These VARCHARs are consuming excessive space and can be safely reduced:

| Field | Current | Proposed | Bytes Saved | Rationale |
|-------|---------|----------|-------------|-----------|
| **`name`** | VARCHAR(255) | VARCHAR(100) | **620** | Case numbers/titles rarely exceed 100 chars |
| `visatype` | VARCHAR(100) | VARCHAR(50) | **200** | Visa types are short codes (H-1B, L-1, etc.) |
| `coveredbyacwia` | VARCHAR(100) | VARCHAR(10) | **360** | Likely a Y/N or short code |
| `empsoccodes` | VARCHAR(60) | VARCHAR(30) | **120** | SOC codes are standardized, max ~15 chars |
| `onettitlecombo` | VARCHAR(60) | VARCHAR(50) | **40** | Slight reduction |
| `altforeignlanguage` | VARCHAR(60) | VARCHAR(40) | **80** | Language names are typically <30 chars |

**Total Potential Savings: 1,420 bytes**

After Phase 1:
```
New Usage:  6,529 bytes / 8,126 bytes (80.3%)
Remaining:  1,597 bytes
```

### Phase 2: Add 14 ENUM Fields Back

With 1,597 bytes available, we can safely add:
- 14 ENUM fields (28 bytes)
- Still have 1,569 bytes buffer (19.3%)

### Phase 3: Monitor TEXT Fields (Future)

Currently 60 TEXT fields (mediumtext) @ 9 bytes each = 540 bytes total. These are fine for now since they were converted during the row size crisis. Some candidates for future review:

- Short address fields (address1, address2)
- Short title fields (jobtitle, employerpocjobtitle)
- Code fields that might have max lengths

---

## 📝 IMPLEMENTATION STEPS

### Step 1: Backup Current State
```bash
# Backup PWD.json metadata
cp /home/falken/DEVOPS\ Dropbox/DEVOPS-KARL/CORE-v4/2-ESPOCRM/ESPO-AUTOMATION/espo-dev/entityDefs/PWD.json \
   /home/falken/DEVOPS\ Dropbox/DEVOPS-KARL/CORE-v4/2-ESPOCRM/ESPO-AUTOMATION/espo-dev/entityDefs/PWD.json.backup

# Backup database
ssh permtrak2@permtrak.com "mysqldump -h permtrak.com -u permtrak2_dev -p'xX-6x8-Wcx6y8-9hjJFe44VhA-Xx' permtrak2_dev p_w_d > /home/permtrak2/backups/p_w_d_pre_optimization_$(date +%Y%m%d_%H%M%S).sql"
```

### Step 2: Edit PWD.json - Reduce VARCHAR Lengths

Edit `/home/falken/DEVOPS Dropbox/DEVOPS-KARL/CORE-v4/2-ESPOCRM/ESPO-AUTOMATION/espo-dev/entityDefs/PWD.json`:

```json
{
  "fields": {
    "name": {
      "type": "varchar",
      "maxLength": 100,  // CHANGED FROM 255
      "dbType": "varchar(100)",
      "len": 100,
      "required": true,
      "trim": true,
      "pattern": "$noBadCharacters"
    }
  }
}
```

**Fields to update:**
- `name`: maxLength 255 → 100, add `"dbType": "varchar(100)"`, `"len": 100`
- `visatype`: maxLength 100 → 50, add `"dbType": "varchar(50)"`, `"len": 50`
- `coveredbyacwia`: maxLength 100 → 10, add `"dbType": "varchar(10)"`, `"len": 10`
- `empsoccodes`: maxLength 60 → 30, add `"dbType": "varchar(30)"`, `"len": 30`
- `onettitlecombo`: maxLength 60 → 50, add `"dbType": "varchar(50)"`, `"len": 50`
- `altforeignlanguage`: maxLength 60 → 40, add `"dbType": "varchar(40)"`, `"len": 40`

### Step 3: Add 14 ENUM Fields to PWD.json

For each ENUM field, add definitions like:

```json
"statcase": {
  "type": "enum",
  "options": ["Pending", "Certified", "Withdrawn", "Denied"],
  "dbType": "enum('Pending','Certified','Withdrawn','Denied')",
  "default": "Pending",
  "isCustom": true
}
```

**IMPORTANT:** You'll need to define the exact ENUM options for each field based on DOL LCA data values.

### Step 4: Commit to Git

```bash
cd /home/permtrak2/dev.permtrak.com/EspoCRM/custom/Espo/Custom/Resources/metadata
git add entityDefs/PWD.json
git commit -m "PWD optimization: Reduce VARCHAR lengths and restore 14 ENUM fields

- Reduced name: 255→100 (saved 620 bytes)
- Reduced visatype: 100→50 (saved 200 bytes)
- Reduced coveredbyacwia: 100→10 (saved 360 bytes)
- Reduced empsoccodes: 60→30 (saved 120 bytes)
- Reduced onettitlecombo: 60→50 (saved 40 bytes)
- Reduced altforeignlanguage: 60→40 (saved 80 bytes)
Total saved: 1,420 bytes

- Restored 14 ENUM fields (28 bytes)

New capacity: 80.3% (1,569 bytes buffer)"
git push origin main
```

### Step 5: Deploy to DEV Server

```bash
# SSH to server
ssh permtrak2@permtrak.com

# Pull changes
cd /home/permtrak2/dev.permtrak.com/EspoCRM/custom/Espo/Custom/Resources/metadata
git pull origin main

# Clear cache and rebuild
cd /home/permtrak2/dev.permtrak.com/EspoCRM
php command.php clear-cache
php command.php rebuild
php command.php rebuild --hard
```

### Step 6: Verify

```bash
# Check row size
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

# Verify ENUM fields exist
mysql -h permtrak.com -u permtrak2_dev -p'xX-6x8-Wcx6y8-9hjJFe44VhA-Xx' permtrak2_dev -e "
SELECT COLUMN_NAME, DATA_TYPE, COLUMN_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'permtrak2_dev' 
  AND TABLE_NAME = 'p_w_d'
  AND DATA_TYPE = 'enum'
ORDER BY COLUMN_NAME;
" 2>&1 | grep -v "Warning"
```

### Step 7: Update pwdx-espo Extractor

Uncomment the 14 fields in `/home/falken/DEVOPS Dropbox/DEVOPS-KARL/CORE-v4/PWD-EXTRACTOR/pwdx-espo/pwdx-espo-extract-and-convert.py`:

```python
FIELD_MAPPING = {
    'case_number': 'casenumber',
    'case_status': 'statcase',  # UNCOMMENTED
    'received_date': 'datereceived',
    # ... etc for all 14 fields
}
```

### Step 8: Test Upload

```bash
cd /home/falken/DEVOPS\ Dropbox/DEVOPS-KARL/CORE-v4/PWD-EXTRACTOR/pwdx-espo
python3 pwdx-espo-extract-and-convert.py
```

---

## ⚠️ RISKS & CONSIDERATIONS

### Data Truncation Risk
- **`name` field:** Reducing from 255→100 will TRUNCATE any existing data >100 chars
- **Mitigation:** Check for existing data length before implementing:

```sql
SELECT MAX(LENGTH(name)) as max_name_length,
       COUNT(*) as records_over_100
FROM p_w_d 
WHERE LENGTH(name) > 100;
```

### ENUM Options Unknown
- We don't have the exact ENUM option lists for the 14 fields
- **Mitigation:** 
  - Analyze DOL data exports to identify all possible values
  - Use broad categories initially, refine later
  - Alternative: Use VARCHAR with smaller lengths instead of ENUM

### Rebuild Risk
- `rebuild --hard` may fail if data doesn't fit new constraints
- **Mitigation:** 
  - Always backup first
  - Test on DEV before PROD
  - Monitor error logs during rebuild

---

## 📊 EXPECTED RESULTS

### Before Optimization
```
bytes_used:      7,949
limit_bytes:     8,126
bytes_remaining: 177
percent_used:    97.8%
enum_fields:     0
```

### After Optimization
```
bytes_used:      6,557 (estimated)
limit_bytes:     8,126
bytes_remaining: 1,569
percent_used:    80.7%
enum_fields:     14
```

**Improvement:**
- ✅ Reduced usage by 17.1 percentage points
- ✅ Increased safety buffer from 177 bytes (2.2%) to 1,569 bytes (19.3%)
- ✅ Restored 14 ENUM fields for better UX
- ✅ Room for future growth

---

## 🔍 DATA VALIDATION QUERIES

Before implementing, run these to understand data:

```sql
-- Check name field lengths
SELECT 
    LENGTH(name) as name_length,
    COUNT(*) as count
FROM p_w_d
GROUP BY LENGTH(name)
ORDER BY LENGTH(name) DESC
LIMIT 10;

-- Check visatype values
SELECT DISTINCT visatype, LENGTH(visatype) as len
FROM p_w_d
WHERE visatype IS NOT NULL
ORDER BY len DESC;

-- Check coveredbyacwia values
SELECT DISTINCT coveredbyacwia, LENGTH(coveredbyacwia) as len
FROM p_w_d
WHERE coveredbyacwia IS NOT NULL;

-- Check empsoccodes lengths
SELECT MAX(LENGTH(empsoccodes)) as max_len
FROM p_w_d;
```

---

## 📚 REFERENCES

- MySQL InnoDB Row Size Limit: 8,126 bytes (utf8mb4)
- VARCHAR byte calculation: `length * 4` (utf8mb4)
- TEXT byte calculation: `9` bytes (pointer)
- ENUM byte calculation: `2` bytes (1-2 bytes depending on option count)
- Related docs:
  - `pwdx-espo/markdown/MYSQL-ROW-SIZE-CRISIS-RESOLVED.md`
  - `espo-ctl/markdown/EspoCRM_Metadata_MySQL_Optimization_Guide.md`

---

## ✅ NEXT ACTIONS

1. **IMMEDIATE:** Run data validation queries (see above)
2. **REVIEW:** Verify no critical data will be truncated
3. **DECIDE:** Confirm VARCHAR length reductions are acceptable
4. **IMPLEMENT:** Follow steps 1-8 above
5. **TEST:** Thoroughly test PWD entity functionality
6. **MONITOR:** Watch for any errors or issues

---

**Status:** READY FOR IMPLEMENTATION  
**Risk Level:** MEDIUM (data truncation possible)  
**Estimated Time:** 30-45 minutes  
**Rollback:** Restore from backup (Step 1)

