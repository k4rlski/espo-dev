# Rebuild --hard Fix - CRITICAL

**Date:** November 3, 2025  
**Issue:** rebuild --hard was resetting all optimizations  
**Status:** ✅ FIXED

---

## 🔴 THE PROBLEM

When `php command.php rebuild --hard` was run, it reset ALL our optimizations:

```
BEFORE rebuild --hard:  86.5% (optimized)
AFTER rebuild --hard:  278.2% (BROKEN!)
```

**Root Cause:** EspoCRM's `rebuild --hard` reads JSON metadata and rebuilds database schema to match. If JSON doesn't specify field sizes, it defaults to VARCHAR(255).

**What we did wrong:**
- ✅ Optimized database columns via SQL
- ❌ Did NOT add `maxLength` to ENUM fields in JSON
- Result: rebuild --hard ignored our SQL optimizations

---

## ✅ THE SOLUTION

**Rule:** JSON metadata is the source of truth for EspoCRM.

For ENUM fields to survive `rebuild --hard`, they MUST have `maxLength` in JSON:

### Before (Broken):
```json
"statcase": {
    "type": "enum",
    "options": ["", "Pending", "Certified", "Denied", "Withdrawn"],
    "default": "",
    "isCustom": true
}
```
**Problem:** No maxLength → rebuild creates VARCHAR(255)

### After (Fixed):
```json
"statcase": {
    "type": "enum",
    "options": ["", "Pending", "Certified", "Denied", "Withdrawn"],
    "maxLength": 15,
    "default": "",
    "isCustom": true
}
```
**Solution:** maxLength specified → rebuild creates VARCHAR(15)

---

## 📋 WHAT WAS FIXED

Added `maxLength` to all 16 optimized fields in PWD.json:

### 14 New ENUM Fields
| Field | maxLength |
|-------|-----------|
| statcase | 15 |
| visaclass | 10 |
| typeofrep | 10 |
| statacwiachanged | 5 |
| profsportsleague | 5 |
| supervise_other_emp | 5 |
| secondeducation | 5 |
| requiredtraining | 5 |
| requiredexperience | 5 |
| alttraining | 5 |
| altexperience | 5 |
| travelrequired | 5 |
| wagesourcerequested | 20 |
| requirededucationlevel | 15 |

### 2 Existing ENUM Fields
| Field | maxLength |
|-------|-----------|
| coveredbyacwia | 20 |
| visatype | 50 |

---

## 🧪 TESTING PROOF

### Test Sequence:
1. ✅ Deployed updated PWD.json with maxLength values
2. ✅ Ran `php command.php rebuild`
3. ✅ Ran `php command.php rebuild --hard` (the ultimate test)
4. ✅ Verified row size: **Still at 86.5%!**

### Results:
```
Before rebuild --hard:  7,029 bytes (86.5%)
After rebuild --hard:   7,029 bytes (86.5%)
Status:                 OPTIMIZATIONS MAINTAINED ✓
```

**Conclusion:** rebuild --hard now SAFE!

---

## 📖 LESSONS LEARNED

### Rule #1: JSON is Source of Truth
- EspoCRM reads JSON metadata for schema
- `rebuild --hard` uses JSON to rebuild database
- SQL optimizations alone are NOT persistent

### Rule #2: Always Specify maxLength for ENUMs
- ENUM fields store as VARCHAR in MySQL
- Without maxLength in JSON → defaults to 255
- With maxLength in JSON → uses specified size

### Rule #3: Test with rebuild --hard
- Always test optimizations with `rebuild --hard`
- It's the ultimate proof of schema stability
- If it fails after rebuild --hard, fix the JSON

---

## 🛠️ CORRECT WORKFLOW FOR FIELD OPTIMIZATION

### ❌ WRONG (What We Did Initially):
1. Edit JSON (no maxLength for ENUMs)
2. Deploy JSON
3. Run rebuild (creates VARCHAR(255))
4. Manually ALTER TABLE to reduce sizes
5. ⚠️ rebuild --hard breaks everything!

### ✅ CORRECT (What We Should Do):
1. Edit JSON with proper maxLength/dbType/len
2. Deploy JSON to server
3. Run rebuild (creates correctly sized columns)
4. Verify with SQL queries
5. ✅ rebuild --hard maintains everything!

---

## 🎯 FOR FUTURE OPTIMIZATIONS (TESTPERM)

When optimizing TESTPERM, we MUST:

1. **Add maxLength to JSON FIRST**
   ```json
   "jobtitle": {
       "type": "varchar",
       "maxLength": 100,
       "dbType": "varchar(100)",
       "len": 100
   }
   ```

2. **Deploy JSON and rebuild**
   - Let EspoCRM create the schema
   - Don't manually ALTER TABLE

3. **Test with rebuild --hard**
   - Confirm optimizations survive
   - If they don't, fix the JSON

4. **Commit JSON to Git**
   - JSON is the permanent record
   - SQL scripts are temporary fixes

---

## ⚠️ WARNING FOR PRODUCTION

**Before deploying PWD optimizations to PROD:**

1. ✅ Ensure PWD.json has maxLength for all ENUMs
2. ✅ Test rebuild --hard on DEV (done!)
3. ✅ Deploy JSON to PROD first
4. ✅ Then run rebuild on PROD
5. ⚠️ Do NOT run manual SQL ALTER TABLE on PROD
6. ✅ Let rebuild handle schema changes

**Why:** If PROD gets manual SQL changes, next rebuild --hard will break it!

---

## 📊 COMPARISON: Before vs After Fix

| Scenario | Before Fix | After Fix |
|----------|-----------|-----------|
| Initial optimization | 86.5% | 86.5% |
| After rebuild | 86.5% | 86.5% |
| After rebuild --hard | 278.2% 🔴 | 86.5% ✅ |
| Future rebuilds | BROKEN | STABLE |
| Production safety | HIGH RISK | LOW RISK |

---

## ✅ STATUS

- **PWD.json:** ✅ Fixed (maxLength added to all 16 fields)
- **Deployed to DEV:** ✅ Yes
- **Tested rebuild --hard:** ✅ Passed
- **Committed to Git:** ✅ Yes
- **Ready for PROD:** ✅ Yes
- **TESTPERM strategy:** ✅ Learned - add maxLength in JSON first

---

## 🎓 KEY TAKEAWAY

**"Always make the JSON metadata match your intended database schema. SQL is temporary, JSON is permanent."**

If you optimize via SQL but don't update JSON:
- ✅ Works immediately
- ✅ Survives normal rebuild
- ❌ **BREAKS on rebuild --hard**
- ❌ Creates production risk

If you optimize JSON with proper maxLength:
- ✅ Works immediately
- ✅ Survives normal rebuild
- ✅ **Survives rebuild --hard**
- ✅ Safe for production

---

**Date Fixed:** November 3, 2025  
**Git Commit:** [To be updated with commit hash]  
**Risk Level:** ELIMINATED  
**Production Impact:** PREVENTED

🎉 **PWD is now rebuild --hard safe!**

