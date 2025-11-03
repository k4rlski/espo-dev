# TESTPERM Field Deletion Candidates Analysis

**Date:** November 3, 2025  
**Baseline Branch:** `testperm-working-baseline-error500-fixed`  
**Current Row Size:** 8,725 bytes (107.4% capacity, 599 bytes over limit)

---

## USER-REQUESTED FIELDS TO DELETE

### 1. `dateinvoicedlocal`
- **Type:** DATE (3 bytes)
- **Impact:** 3 bytes saved
- **Usage:** Has data in all 16,705 records
- **Recommendation:** ⚠️ **DO NOT DELETE** - Used in all records, minimal byte savings (DATE fields are only 3 bytes)

### 2. `adtextnews2`
- **Type:** TEXT (mediumtext)
- **Impact:** 0 bytes saved (TEXT doesn't count toward row size)
- **Recommendation:** ⚠️ **NO BENEFIT** - Already TEXT, deleting won't help row size

### 3. `quoterequestnotes`
- **Status:** ❌ **DOES NOT EXIST** in database or JSON
- **Note:** May have been deleted in previous phases

### 4. `communications`
- **Status:** ❌ **DOES NOT EXIST** in database or JSON  
- **Note:** Was deleted in Phase 4 (link field removal)

---

## RECOMMENDATION: Focus on Large VARCHAR Fields

The fields you mentioned won't help reduce row size. Instead, let's focus on:

### **Better Candidates: Large VARCHAR Fields**

We need to identify VARCHAR fields that are either:
1. 100% NULL (safe to delete or convert to TEXT)
2. Large but rarely used (convert to TEXT)
3. Duplicates or deprecated fields

**Next step:** Run analysis to find VARCHAR fields with:
- Size >= 150 characters
- NULL or minimal usage
- Can be safely converted to TEXT

---

## ANALYSIS IN PROGRESS

Finding the 20 largest VARCHAR fields currently contributing to row size...

