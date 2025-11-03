# TESTPERM Table Analysis

**Date:** November 3, 2025  
**Current State:** 796.6% capacity (64,728 / 8,126 bytes)  
**OVER LIMIT BY:** 56,602 bytes (almost 7x too large!)  
**Status:** 🔴 CRITICAL - CANNOT ADD ANY RECORDS

---

## 📊 CURRENT STATE BREAKDOWN

### Column Distribution
- **Total Columns:** 235
- **VARCHAR Fields:** 131 (56% of columns)
- **TEXT Fields:** 47 mediumtext (20%)
- **DATE Fields:** 32 (14%)
- **INT/DATETIME/TINYINT:** 5 (2%)
- **Other:** 20 (8% - links, etc.)

### Byte Usage Analysis

| Type | Count | Bytes Used | % of Total |
|------|-------|------------|------------|
| **VARCHAR(255)** | 44 | 44,880 | 69% |
| **VARCHAR(100)** | 23 | 9,200 | 14% |
| **VARCHAR(150)** | 7 | 4,200 | 6% |
| **VARCHAR(60)** | 7 | 1,680 | 3% |
| **VARCHAR(40)** | 8 | 1,280 | 2% |
| **VARCHAR(120)** | 2 | 960 | 1% |
| **Other VARCHARs** | 40 | 2,796 | 4% |
| **TEXT (mediumtext)** | 47 | 423 | 1% |
| **Other types** | -- | ~500 | 1% |
| **TOTAL** | 235 | **64,728** | **100%** |

---

## 🔥 CRITICAL FINDINGS

### Problem #1: Massive VARCHAR(255) Waste
**44 fields at VARCHAR(255) = 44,880 bytes**

These fields include:
- **URLs:** `urlweb`, `urljsbp`, `urlonline`, `urlswa`, `urlqbpaylink`, `urltrxmercury`, `urlgmailadconfirm` (7 fields)
- **Dropbox fields:** `dboxemailthreadcase`, `dboxemailthreadnews`, `dboxemailthreadswa`, `dboxewpstart/end`, `dboxjsbpstart/end`, etc. (14 fields)
- **Autoprint fields:** `autoprintewp`, `autoprintjsbp`, `autoprintonline`, `autoprintswa` (4 fields)
- **Text fields:** `jobtitle`, `jobexperience`, `jobeducation`, `attyfirm`, `attycasenumber` (5 fields)
- **Other:** `name`, `entity`, `domainname`, `processor`, `quotereport`, etc. (14 fields)

**Optimization Potential:**
- Most of these likely don't need 255 characters
- URLs could be 100-150
- Dropbox IDs are probably < 50
- Autoprint flags might be enums or booleans
- Names/titles likely < 100

**If we reduce average to 75:** 44 × (255-75) × 4 = **31,680 bytes saved**

### Problem #2: VARCHAR(100) Fields
**23 fields at VARCHAR(100) = 9,200 bytes**

Fields include:
- Email addresses: `contactemail`, `coemailcontactstandard`, `coemailpermads`, etc. (6 fields)
- Addresses: `coaddress`, `cocity`, `cocounty`, `jobaddress_city`, `jobsiteaddress`, etc. (6 fields)  
- Other: `adnumbernews`, `attyassistant`, `cofein`, `conaics`, etc. (11 fields)

**Optimization Potential:**
- Email addresses: 100 → 75 (email standard)
- Cities: 100 → 50
- Addresses: Keep at 100 or 150
- IDs/numbers: 100 → 30-50

**If we reduce average to 60:** 23 × (100-60) × 4 = **3,680 bytes saved**

### Problem #3: VARCHAR(150) Fields
**7 fields at VARCHAR(150) = 4,200 bytes**

Fields: `adnumberlocal`, `codolpin`, `comsa`, `jobnaics`, `swacomment`, `yournamefirst`, `yournamelast`

**Optimization Potential:**
- Names: 150 → 50
- Comments: Keep at 150 or reduce to 100
- Codes/IDs: 150 → 30-50

**If we reduce average to 75:** 7 × (150-75) × 4 = **2,100 bytes saved**

---

## 🎯 OPTIMIZATION STRATEGY

### Phase 1: Quick Wins - Boolean/ENUM Conversions
**Target:** `autoprint*`, `dbox*` fields that are likely Y/N or short codes

Candidates (need data analysis):
- `autoprintewp`, `autoprintjsbp`, `autoprintonline`, `autoprintswa` (4 fields)
- All `dbox*` start/end fields (likely date strings or dropbox IDs)

**Potential:** Convert 10-15 fields to VARCHAR(20) or less

### Phase 2: URL Field Optimization
**Target:** All `url*` fields (7 fields at VARCHAR(255))

Recommendation:
- Standard URLs: 255 → 150 (saves 420 bytes per field)
- **Total savings:** 7 × 420 = **2,940 bytes**

### Phase 3: ID/Code Field Optimization  
**Target:** Dropbox IDs, case numbers, reference codes

Examples:
- `dboxemailthread*` fields: 255 → 50
- `dboxewpstart/end`, `dboxjsbpstart/end`: 255 → 50
- `attycasenumber`: 255 → 50
- **20+ fields:** 255 → 50 average

**Savings:** 20 × (255-50) × 4 = **16,400 bytes**

### Phase 4: Text Field Right-Sizing
**Target:** Names, titles, descriptions that don't need 255

Examples:
- `jobtitle`: 255 → 100 (save 620 bytes)
- `jobexperience`, `jobeducation`: 255 → 100 each
- `attyfirm`: 255 → 100
- `entity`: 255 → 50
- **15 fields** at 255 → 100

**Savings:** 15 × (255-100) × 4 = **9,300 bytes**

### Phase 5: Address/Email Optimization
**Target:** VARCHAR(100) fields that can be smaller

Examples:
- Email addresses: Keep at 75-100
- Cities: 100 → 50
- States: Already at 40 ✓
- Zip codes: Already at 40 ✓

**Savings:** ~10 fields × 50 bytes × 4 = **2,000 bytes**

---

## 📋 ESTIMATED TOTAL SAVINGS

| Phase | Fields | Savings |
|-------|--------|---------|
| 1. Boolean/ENUM | 10-15 | 5,000-8,000 |
| 2. URLs | 7 | 2,940 |
| 3. IDs/Codes | 20 | 16,400 |
| 4. Text Fields | 15 | 9,300 |
| 5. Address/Email | 10 | 2,000 |
| **TOTAL** | **62-67 fields** | **35,640 - 38,640 bytes** |

### Projected Final State
```
Current:  64,728 bytes (796.6%)
After:    26,088 - 29,088 bytes (321% - 358%)

STILL OVER LIMIT BY: 17,962 - 20,962 bytes
```

**⚠️ CRITICAL:** Even with aggressive optimization, TESTPERM will likely STILL be over the limit!

---

## 🚨 DEEPER PROBLEM: TOO MANY COLUMNS

**The fundamental issue:** TESTPERM has **235 columns**

Even with perfect optimization:
- 47 mediumtext fields = 423 bytes (required)
- 32 date fields = 128 bytes (required)
- 131 VARCHARs optimized to avg 20 chars = 10,480 bytes
- Other fields = ~500 bytes
- **Minimum possible:** ~11,531 bytes (142% still over!)

**Root cause:** The entity has too many fields for a single MySQL row with utf8mb4.

---

## 💡 SOLUTIONS

### Option A: Aggressive VARCHAR Optimization (Partial Fix)
- Optimize all VARCHARs to minimum safe lengths
- **Pro:** Easier, no schema changes
- **Con:** May still be over limit
- **Target:** Get to 80-90% capacity if possible

### Option B: Split Entity (Complete Fix)
- Move some fields to a related entity (e.g., TESTPERM_DETAILS)
- Link via 1:1 relationship
- **Pro:** Permanently solves the problem
- **Con:** Major refactoring required

### Option C: Hybrid Approach (Recommended)
1. Phase 1: Optimize all VARCHARs aggressively
2. Phase 2: Convert TEXT fields that can be VARCHARs
3. Phase 3: If still over, identify 30-50 least-used fields to move to separate table

---

## 🔍 NEXT STEPS (NO CHANGES YET)

To create a precise optimization plan, we need:

1. **Data Analysis:** Sample actual data lengths for top 50 VARCHAR fields
2. **Field Usage Analysis:** Identify which fields are rarely used
3. **Type Analysis:** Check if any VARCHAR(255) fields are actually enums/booleans
4. **Business Logic Review:** Understand which fields are critical vs optional

### Recommended Commands:

```sql
-- Sample data lengths for VARCHAR(255) fields
SELECT 
    MAX(LENGTH(jobtitle)) as jobtitle_max,
    MAX(LENGTH(jobexperience)) as jobexp_max,
    MAX(LENGTH(attyfirm)) as attyfirm_max,
    MAX(LENGTH(urlweb)) as urlweb_max,
    MAX(LENGTH(dboxemailthreadcase)) as dbox_max,
    MAX(LENGTH(autoprintewp)) as autoprint_max
FROM t_e_s_t_p_e_r_m;
```

---

## ⚠️ WARNINGS

1. **DO NOT run rebuild --hard** until optimizations are saved to JSON with dbType/len
2. **This table is currently BROKEN** - Cannot insert new records
3. **Production likely has same issue** - Need to fix DEV first, then PROD
4. **This is more complex than PWD** - May require multiple optimization passes

---

## 📊 COMPARISON: PWD vs TESTPERM

| Metric | PWD | TESTPERM |
|--------|-----|----------|
| Total Columns | ~120 | 235 |
| VARCHAR Fields | ~70 | 131 |
| Starting % | 97.8% | 796.6% |
| After Opt % | 86.5% | ??? (likely 250-350%) |
| Solvable? | ✅ YES | ⚠️ MAYBE |

---

**Status:** ANALYSIS COMPLETE - AWAITING USER DECISION ON APPROACH  
**Recommendation:** Start with data sampling, then aggressive VARCHAR optimization  
**Risk Level:** HIGH - Table is currently unusable

**Next:** User should review this analysis and decide on approach before we proceed with optimizations.

