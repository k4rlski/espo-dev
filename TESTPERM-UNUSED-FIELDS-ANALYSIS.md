# TESTPERM Unused Fields Analysis
## Fields Sitting in Right Panel Dock (Not in Detail Layout)

**Date:** November 3, 2025  
**Total Fields in Entity:** 257  
**Fields in Detail Layout:** 199  
**Unused Fields (in dock):** 58 unique fields

---

## UNUSED FIELDS BY CATEGORY

### **1. System/Core Fields (9 fields) - KEEP THESE**
These are EspoCRM system fields, needed for core functionality:

```
createdAt         - Record creation timestamp
createdBy         - User who created record
modifiedAt        - Last modification timestamp
modifiedBy        - User who modified record
assignedUser      - Record owner
teams             - Team assignments
```

**Recommendation:** ✅ **KEEP** - Core EspoCRM functionality

---

### **2. Link/Relationship Fields (8 fields) - Review Needed**
These are relationship fields to other entities:

```
account           - Link to Account entity
contactname       - Contact name (possibly from contact link)
local             - Link to Local entity
news              - Link to News entity
online            - Link to Online entity
radio             - Link to Radio entity
swa               - Link to SWA entity
trx               - Link to Transactions entity (deleted in Phase 4)
```

**Recommendation:** 
- ⚠️ **Review** - Check if these relationships are used
- 🗑️ **trx** - Can remove (we deleted this link in Phase 4)
- ✅ Keep active relationship links (account, swa, news, etc.)

---

### **3. Fields We Kept as TEXT (3 fields) - Already Handled**
These are the fields from "Phase 4 deletion" that we kept as TEXT:

```
domainname              - Kept as TEXT per user request
parentid                - Re-added as TEXT (Error 500 fix)
jobaddress_country      - Re-added as TEXT (Error 500 fix)
```

**Recommendation:** ✅ **KEEP** - Already converted to TEXT, no row size impact

---

### **4. Metadata/Style Definitions (1 entry)**
```
style               - JSON metadata, not an actual field
collection          - JSON metadata
indexes             - JSON metadata
```

**Recommendation:** ❌ **IGNORE** - These are JSON structure keys, not fields

---

### **5. Date/Business Fields (6 fields) - Review for Usage**
```
date                - Generic date field
datedue             - Due date
dateonlineexpire    - Online expiration date
datepay             - Payment date
```

**Recommendation:** 
- ⚠️ **Check usage** - See if these are actually used
- If NULL everywhere → Can remove from layout
- If used → Keep in layout

---

### **6. Other Business Fields (6 fields) - Review for Usage**
```
actionnotes         - Action notes (VARCHAR 40)
contactname         - Contact name (TEXT - Phase 5b)
coyearbusinessformed - Company year formed (VARCHAR 20)
name                - Case name (VARCHAR 150) **SENSITIVE - IN LAYOUT**
salaryrange         - Salary range info
```

**Wait!** `name` should be IN the layout - it's the main field!

**Recommendation:** 
- ⚠️ **name** - Check why it's showing as unused (might be script error)
- ⚠️ Other fields - Check if actively used

---

## 🎯 SAFE CANDIDATES FOR REMOVAL FROM LAYOUT

### **Definitely Remove (1 field):**
```
trx                 - Transactions link (deleted in Phase 4)
```

### **Probably Safe to Remove (if confirmed NULL):**
```
parentid            - 100% NULL (per Phase 4 analysis)
jobaddress_country  - Should be handled by address field components
```

### **Check Usage Before Removing:**
All other fields - need to verify they're actually unused via data analysis.

---

## 📊 RECOMMENDED WORKFLOW

### **Step 1: Disable Cache** ✅
```
Administration → Settings → System
☐ Uncheck "Use Cache"
Save
```

### **Step 2: Safe Layout Cleanup**
```
1. Go to Layout Manager → TESTPERM → Detail
2. Look at right panel dock
3. Remove ONLY these confirmed unused fields:
   - trx (deleted link)
   - (Others after data verification)
4. Save
5. Test a few records
```

### **Step 3: Verify Data Usage**
Before removing more fields, check which have data:

```sql
-- Run this for each field to check usage
SELECT 
    'fieldname' as field,
    COUNT(*) as total_records,
    COUNT(fieldname) as non_null_count,
    ROUND(COUNT(fieldname) / COUNT(*) * 100, 2) as percent_used
FROM t_e_s_t_p_e_r_m;
```

### **Step 4: Re-enable Cache** ✅
```
Administration → Settings → System
☑ Check "Use Cache"
Save
Clear Cache
```

---

## ⚠️ IMPORTANT NOTES

### **Removing from Layout ≠ Deleting Field**
- **Layout removal** = Hide from UI (safe, reversible)
- **Entity deletion** = Remove from database (permanent, risky)

### **Always Start with Layout Removal**
1. First: Remove from layout (test for a week)
2. Later: If confirmed unused, delete from entity
3. Never delete without thorough testing

### **System Fields Must Stay**
Never remove these from the entity (even if not in layout):
- createdAt, createdBy
- modifiedAt, modifiedBy
- assignedUser, teams
- id, deleted

---

## 🔍 SCRIPT TO CHECK FIELD USAGE

Create this script to check if fields have data:

```bash
#!/bin/bash
# check-field-usage.sh

FIELDS="actionnotes datedue dateonlineexpire datepay salaryrange coyearbusinessformed"

for field in $FIELDS; do
  echo "Checking $field..."
  ssh permtrak2@permtrak.com "mysql -h permtrak.com -u permtrak2_dev -p'xX-6x8-Wcx6y8-9hjJFe44VhA-Xx' permtrak2_dev -e \"
    SELECT 
      '$field' as field,
      COUNT(*) as total,
      COUNT($field) as used,
      ROUND(COUNT($field)/COUNT(*)*100,1) as pct
    FROM t_e_s_t_p_e_r_m;
  \" 2>&1 | grep -v Warning"
  echo ""
done
```

---

## 📋 NEXT STEPS

### **Immediate:**
1. ✅ **Disable cache** (in Settings screenshot you showed)
2. ✅ Remove `trx` from TESTPERM layout (confirmed deleted)
3. ✅ Test layout looks correct
4. ✅ Re-enable cache

### **For PWD:**
1. ✅ Disable cache
2. ✅ Use Layout Manager to arrange PWD fields
3. ✅ Test positioning
4. ✅ Re-enable cache

### **Future Optimization:**
1. Run usage scripts to identify truly unused fields
2. Remove unused fields from layout
3. Monitor for complaints
4. After 1-2 weeks, consider deleting unused fields from entity

---

## STATUS

**Cache:** ✅ Confirmed enabled (needs to be disabled for layout work)  
**Unused Fields:** ✅ 58 identified (many are system/metadata)  
**Safe to Remove:** ✅ At least 1 confirmed (trx)  
**Needs Verification:** ⚠️ ~50 fields need usage check  

**Next:** Disable cache → Remove trx from layout → Test

