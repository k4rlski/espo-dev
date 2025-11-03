# TESTPERM Phase 1 JSON Updates - Tiers 1 & 2

**Target:** Save ~11,200 bytes with 16 field optimizations  
**Current Row Size:** 64,456 bytes (793.2% capacity)  
**After Phase 1:** ~53,256 bytes (655% capacity)

---

## 📋 TIER 1: MASSIVE WINS (8 fields, ~7,200 bytes saved)

### 1. `processor` (ENUM field)
- **Type:** enum
- **Current:** VARCHAR(255) in DB
- **Max Used:** 3 chars
- **Target:** VARCHAR(15)
- **Savings:** 968 bytes

**JSON Update:**
```json
"processor": {
    "type": "enum",
    "maxLength": 15,
    "options": [
        "NA",
        "ACH",
        "CBR",
        ...
    ]
}
```

### 2. `entity` (ENUM field)
- **Type:** enum
- **Current:** VARCHAR(255) in DB
- **Max Used:** 3 chars
- **Target:** VARCHAR(15)
- **Savings:** 968 bytes

**JSON Update:**
```json
"entity": {
    "type": "enum",
    "maxLength": 15,
    "options": [
        "PA",
        "NA",
        "JKT"
    ]
}
```

### 3. `quotereport` (ENUM field)
- **Type:** enum
- **Current:** VARCHAR(255) in DB
- **Max Used:** 7 chars
- **Target:** VARCHAR(20)
- **Savings:** 940 bytes

**JSON Update:**
```json
"quotereport": {
    "type": "enum",
    "maxLength": 20,
    "options": [
        "---",
        "yes",
        "no"
    ]
}
```

### 4. `attycasenumber`
- **Type:** varchar
- **Current:** VARCHAR(255)
- **Max Used:** 17 chars
- **Target:** VARCHAR(30)
- **Savings:** 900 bytes

**JSON Update:**
```json
"attycasenumber": {
    "type": "varchar",
    "maxLength": 30,
    "options": [],
    "isCustom": true
}
```

### 5. `statacctgcreditnews`
- **Type:** varchar
- **Current:** VARCHAR(255)
- **Max Used:** 20 chars
- **Target:** VARCHAR(30)
- **Savings:** 900 bytes

**JSON Update:**
```json
"statacctgcreditnews": {
    "type": "varchar",
    "maxLength": 30,
    "options": [],
    "isCustom": true
}
```

### 6. `actionnotes`
- **Type:** varchar
- **Current:** VARCHAR(255)
- **Max Used:** 28 chars
- **Target:** VARCHAR(40)
- **Savings:** 860 bytes

**JSON Update:**
```json
"actionnotes": {
    "type": "varchar",
    "maxLength": 40,
    "options": [],
    "isCustom": true
}
```

### 7. `swasubacctuser`
- **Type:** varchar
- **Current:** VARCHAR(255)
- **Max Used:** 33 chars
- **Target:** VARCHAR(45)
- **Savings:** 840 bytes

**JSON Update:**
```json
"swasubacctuser": {
    "type": "varchar",
    "maxLength": 45,
    "options": [],
    "isCustom": true
}
```

### 8. `dboxemailthreadnews`
- **Type:** varchar
- **Current:** VARCHAR(255)
- **Max Used:** 21 chars
- **Target:** VARCHAR(50)
- **Savings:** 820 bytes

**JSON Update:**
```json
"dboxemailthreadnews": {
    "type": "varchar",
    "maxLength": 50,
    "options": [],
    "isCustom": true
}
```

---

## 🚀 TIER 2: BIG WINS (8 fields, ~4,000 bytes saved)

### 9. `jobaddress_street`
- **Type:** varchar
- **Current:** VARCHAR(255)
- **Max Used:** 57 chars
- **Target:** VARCHAR(70)
- **Savings:** 740 bytes

**JSON Update:**
```json
"jobaddress_street": {
    "type": "varchar",
    "maxLength": 70,
    "options": [],
    "isCustom": true
}
```

### 10. `urljsbp`
- **Type:** varchar
- **Current:** VARCHAR(255)
- **Max Used:** 112 chars
- **Target:** VARCHAR(125)
- **Savings:** 520 bytes

**JSON Update:**
```json
"urljsbp": {
    "type": "varchar",
    "maxLength": 125,
    "options": [],
    "isCustom": true
}
```

### 11. `adnumberlocal`
- **Type:** varchar
- **Current:** VARCHAR(150)
- **Max Used:** 13 chars
- **Target:** VARCHAR(30)
- **Savings:** 480 bytes

**JSON Update:**
```json
"adnumberlocal": {
    "type": "varchar",
    "maxLength": 30,
    "options": [],
    "isCustom": true
}
```

### 12. `codolpin`
- **Type:** varchar
- **Current:** VARCHAR(150)
- **Max Used:** 15 chars
- **Target:** VARCHAR(30)
- **Savings:** 480 bytes

**JSON Update:**
```json
"codolpin": {
    "type": "varchar",
    "maxLength": 30,
    "options": [],
    "isCustom": true
}
```

### 13. `comsa`
- **Type:** varchar
- **Current:** VARCHAR(150)
- **Max Used:** 2 chars
- **Target:** VARCHAR(30)
- **Savings:** 480 bytes

**JSON Update:**
```json
"comsa": {
    "type": "varchar",
    "maxLength": 30,
    "options": [],
    "isCustom": true
}
```

### 14. `name`
- **Type:** varchar
- **Current:** VARCHAR(255)
- **Max Used:** 132 chars
- **Target:** VARCHAR(145)
- **Savings:** 440 bytes

**JSON Update:**
```json
"name": {
    "type": "varchar",
    "maxLength": 145,
    "required": true,
    "trim": true,
    "pattern": "$noBadCharacters",
    "options": []
}
```

### 15. `urlweb`
- **Type:** varchar
- **Current:** VARCHAR(255)
- **Max Used:** 134 chars
- **Target:** VARCHAR(145)
- **Savings:** 440 bytes

**JSON Update:**
```json
"urlweb": {
    "type": "varchar",
    "maxLength": 145,
    "options": [],
    "isCustom": true
}
```

### 16. `autoprintewp`
- **Type:** varchar
- **Current:** VARCHAR(255)
- **Max Used:** 139 chars
- **Target:** VARCHAR(150)
- **Savings:** 420 bytes

**JSON Update:**
```json
"autoprintewp": {
    "type": "varchar",
    "maxLength": 150,
    "options": [],
    "isCustom": true
}
```

---

## 📊 Phase 1 Summary

| Metric | Value |
|--------|-------|
| **Fields Updated** | 16 |
| **Total Bytes Saved** | ~11,200 |
| **Before** | 64,456 bytes (793.2%) |
| **After** | 53,256 bytes (655.4%) |
| **Progress** | Still over limit, but 17% improvement |

---

## 🔧 Implementation Steps

1. **Backup current TESTPERM.json**
   ```bash
   cp entityDefs/TESTPERM.json entityDefs/TESTPERM.json.backup-phase1
   ```

2. **Edit TESTPERM.json** - Add `maxLength` to all 16 fields listed above

3. **Commit to Git**
   ```bash
   git add entityDefs/TESTPERM.json
   git commit -m "TESTPERM Phase 1: Optimize 16 VARCHAR fields (save 11,200 bytes)"
   git push
   ```

4. **Deploy to dev.permtrak.com**
   ```bash
   scp entityDefs/TESTPERM.json permtrak2@permtrak.com:/home/permtrak2/dev.permtrak.com/EspoCRM/custom/Espo/Custom/Resources/metadata/entityDefs/
   ```

5. **Run rebuild --hard on dev**
   ```bash
   ssh permtrak2@permtrak.com
   cd /home/permtrak2/dev.permtrak.com/EspoCRM
   php command.php rebuild --hard
   ```

6. **Verify byte savings**
   ```sql
   SELECT 
       SUM(
           CASE 
               WHEN DATA_TYPE = 'varchar' THEN CHARACTER_MAXIMUM_LENGTH * 4
               WHEN DATA_TYPE = 'int' THEN 4
               WHEN DATA_TYPE = 'bigint' THEN 8
               WHEN DATA_TYPE = 'tinyint' THEN 1
               WHEN DATA_TYPE = 'double' THEN 8
               WHEN DATA_TYPE = 'datetime' THEN 8
               WHEN DATA_TYPE = 'date' THEN 3
               WHEN DATA_TYPE = 'text' THEN 0
               ELSE 0
           END
       ) as bytes_used,
       8126 as limit_bytes
   FROM INFORMATION_SCHEMA.COLUMNS
   WHERE TABLE_SCHEMA = 'permtrak2_dev' 
     AND TABLE_NAME = 't_e_s_t_p_e_r_m'
     AND DATA_TYPE != 'text';
   ```

7. **Test record editing** - Open existing TESTPERM records, edit, and save

8. **If successful, proceed to Phase 2 (Tier 3 - another 39 fields)**

---

## ⚠️ Revert Plan

If issues occur:
```bash
# Revert JSON
cp entityDefs/TESTPERM.json.backup-phase1 entityDefs/TESTPERM.json

# Deploy reverted JSON
scp entityDefs/TESTPERM.json permtrak2@permtrak.com:/home/permtrak2/dev.permtrak.com/EspoCRM/custom/Espo/Custom/Resources/metadata/entityDefs/

# Rebuild
ssh permtrak2@permtrak.com "cd /home/permtrak2/dev.permtrak.com/EspoCRM && php command.php rebuild"
```

---

**Ready to apply these changes?**

