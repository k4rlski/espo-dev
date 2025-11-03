# TESTPERM Link Field Removal Analysis

**Date:** November 3, 2025  
**Purpose:** Identify link fields that can be safely removed to reduce row size  
**Current Status:** 796.6% (64,728 / 8,126 bytes)

---

## 🔍 LINK FIELDS ANALYSIS

### What are Link Fields?

In EspoCRM:
- **`belongsTo`** links create a `_id` column (VARCHAR(17) = 68 bytes each)
- **`hasMany`** links DON'T create columns in this table
- **`linkMultiple`** links DON'T create columns in this table

### Current Link Fields in TESTPERM

| Link Name | Type | Creates Column | Bytes | Entity |
|-----------|------|----------------|-------|--------|
| createdBy | belongsTo | created_by_id | 68 | User (system) |
| modifiedBy | belongsTo | modified_by_id | 68 | User (system) |
| assignedUser | belongsTo | assigned_user_id | 68 | User (system) |
| **local** | belongsTo | local_id | 68 | Local |
| **online** | belongsTo | online_id | 68 | Online |
| **radio** | belongsTo | radio_id | 68 | Radio |
| **swa** | belongsTo | swa_id | 68 | SWA |
| **document** | belongsTo | document_id | 68 | Document |
| **news** | belongsTo | news_id | 68 | News |
| **contact** | belongsTo | contact_id | 68 | Contact |
| **account** | belongsTo | account_id | 68 | Account |
| **transactions** | belongsTo | transactions_id | 68 | CTransactions |
| **communications** | belongsTo | communications_id | 68 | CCommunications |
| trx | hasMany | (no column) | 0 | CTransactions |
| teams | hasMany | (no column) | 0 | Team |

**Total removable link bytes:** 13 custom links × 68 = **884 bytes**

---

## 📋 CANDIDATES FOR REMOVAL

### Priority 1: Test with "transactions" (User Request)

**Field:** `transactions` and `trx`  
**Columns:** `transactions_id` (68 bytes)  
**Reason:** User specifically wants to test this  
**Risk:** Low if unused, check data first  

### Priority 2: Likely Unused Links

Based on naming, these might be legacy/unused:
- `document` → document_id (68 bytes)
- `communications` → communications_id (68 bytes)

### Priority 3: Possibly Redundant

These might duplicate data available elsewhere:
- `contact` → contact_id (if contact data is in other fields)
- `account` → account_id (if account data is in other fields)

### Do NOT Remove (Likely Used)
- `local`, `online`, `radio`, `swa`, `news` - Core recruitment ad types
- `createdBy`, `modifiedBy`, `assignedUser` - System fields

---

## 🧪 TEST PLAN: Remove "transactions" Link

### Step 1: Check Data Usage
Query to see if transactions_id is actually used:
```sql
SELECT 
    COUNT(*) as total_records,
    COUNT(transactions_id) as has_transaction,
    COUNT(*) - COUNT(transactions_id) as null_transactions
FROM t_e_s_t_p_e_r_m;
```

**Decision:**
- If 100% NULL → Safe to remove
- If < 5% populated → Probably safe to remove
- If > 10% populated → Need to understand usage first

### Step 2: Remove from JSON (3 locations)

**A. Remove from fields section:**
```json
"transactions": {
    "type": "link"
},
```

**B. Remove from links section:**
```json
"transactions": {
    "type": "belongsTo",
    "foreign": "tESTPERMs",
    "entity": "CTransactions",
    "audited": false,
    "isCustom": true
},
```

**C. Consider removing trx (hasMany):**
```json
"trx": {
    "type": "linkMultiple",
    "layoutDetailDisabled": true,
    "layoutMassUpdateDisabled": true,
    "layoutListDisabled": true,
    "noLoad": true,
    "importDisabled": true,
    "exportDisabled": true,
    "customizationDisabled": true,
    "isCustom": true
},
```
and
```json
"trx": {
    "type": "hasMany",
    "foreign": "perm",
    "entity": "CTransactions",
    "audited": false,
    "isCustom": true
},
```

**Note:** `trx` is a hasMany so it doesn't create a column, but removing it prevents UI from showing the relationship.

### Step 3: Deploy and Rebuild
1. Update TESTPERM.json
2. Deploy to server
3. Run `php command.php rebuild`
4. EspoCRM will DROP the transactions_id column automatically
5. Verify row size reduction

### Step 4: Verify Byte Savings
Expected result:
- Before: 64,728 bytes (796.6%)
- Savings: 68 bytes
- After: 64,660 bytes (795.8%)
- **Minimal impact** - need to remove more!

---

## 💡 RECOMMENDATION: Batch Removal

Instead of removing one at a time, we should:

1. **Check data for ALL link fields** (see query above)
2. **Identify 5-10 unused links** to remove in batch
3. **Remove them all at once** from JSON
4. **Deploy and rebuild once**
5. **Save ~500-700 bytes** in one go

### Likely Safe to Remove (Need to Verify):
- transactions (68 bytes)
- communications (68 bytes)
- document (68 bytes)
- contact (68 bytes) - if contact info is in other fields
- account (68 bytes) - if account info is in other fields

**Potential savings:** 5 links × 68 = **340 bytes**

---

## ⚠️ IMPORTANT NOTES

### 1. JSON is Source of Truth
- Remove from JSON first
- Deploy JSON
- Run rebuild (auto-drops column)
- **Don't** manually DROP COLUMN via SQL

### 2. Check Foreign Key Constraints
Some links might have foreign key constraints that need to be dropped first.

### 3. Backup First
Before removing any links:
```bash
mysqldump -h permtrak.com -u permtrak2_dev -p permtrak2_dev t_e_s_t_p_e_r_m > testperm_backup_before_link_removal.sql
```

### 4. Can't Undo Without Backup
Once you remove a link and rebuild, the column is GONE.  
Make sure you have backups of:
- JSON metadata
- Database table

---

## 📊 IMPACT ASSESSMENT

### Single Link Removal (transactions)
- Bytes saved: 68
- Impact: 0.1% reduction
- New capacity: 795.8%
- **Still way over limit!**

### Batch Removal (5 links)
- Bytes saved: 340
- Impact: 0.5% reduction
- New capacity: 792.4%
- **Still way over limit!**

### Reality Check
Removing ALL 13 custom links would only save 884 bytes (1.4% reduction).  
We'd still be at 783.7% capacity.

**Conclusion:** Link removal helps but is NOT enough. We still need to:
1. Optimize VARCHAR fields (main savings)
2. Consider entity split if still over limit

---

## 🎯 NEXT STEPS

**Option A: Test transactions removal only**
- Quick test to verify process works
- Minimal savings, but proves concept
- Good learning experience

**Option B: Check all links first, then batch remove**
- More efficient
- Bigger savings in one operation
- Less deploy/rebuild cycles

**Option C: Skip link removal, focus on VARCHAR optimization**
- Link removal saves < 1,000 bytes total
- VARCHAR optimization saves 30,000+ bytes
- Better use of time

**Recommendation:** Do Option A (test with transactions) to prove the process, then move to VARCHAR optimization for real savings.

---

**Status:** AWAITING DATA ANALYSIS RESULTS  
**Next:** Check if transactions_id is actually used in the data

