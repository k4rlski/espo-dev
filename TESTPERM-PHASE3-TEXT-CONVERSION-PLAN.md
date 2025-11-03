# TESTPERM Phase 3 - TEXT Conversion Strategy

**Date:** 2025-11-03  
**Status:** Ready for Implementation

---

## 🎯 Strategy: Convert Large VARCHAR Fields to TEXT

### Why TEXT Conversion?

**TEXT fields DO NOT count toward the 8,126 byte row size limit!**

- TEXT data is stored separately from the row
- Only a pointer (9-12 bytes) is stored in the row
- Perfect for large, infrequently-accessed string data
- No data loss - TEXT can hold up to 64KB

### Trade-offs

**Pros:**
✅ Massive byte savings (~22,000 bytes)
✅ Low risk - no data truncation
✅ Quick to implement
✅ Reversible if needed
✅ Works even when table is oversized

**Cons:**
⚠️ Slight performance penalty for TEXT field reads
⚠️ TEXT fields can't be used in indexes
⚠️ Full-text search on TEXT requires special handling

---

## 📋 Fields to Convert (28 fields, ~21,920 bytes freed)

### Category 1: URL Fields (8 fields, ~7,120 bytes freed)

| Field | Current Type | Current Size | Current Bytes | After TEXT | Bytes Freed |
|-------|-------------|--------------|---------------|------------|-------------|
| `urlweb` | VARCHAR | 150 | 600 | TEXT (~10) | 590 |
| `urljsbp` | VARCHAR | 130 | 520 | TEXT (~10) | 510 |
| `urlonline` | VARCHAR | 255 | 1020 | TEXT (~10) | 1010 |
| `urlswa` | VARCHAR | 255 | 1020 | TEXT (~10) | 1010 |
| `urlqbpaylink` | VARCHAR | 255 | 1020 | TEXT (~10) | 1010 |
| `urltrxmercury` | VARCHAR | 255 | 1020 | TEXT (~10) | 1010 |
| `urlgmailadconfirm` | VARCHAR | 255 | 1020 | TEXT (~10) | 1010 |
| `stripepaymentlink` | VARCHAR | 170 | 680 | TEXT (~10) | 670 |

**Subtotal: ~7,820 bytes freed**

### Category 2: Dropbox ID Fields (16 fields, ~12,400 bytes freed)

| Field | Current Type | Current Size | Current Bytes | After TEXT | Bytes Freed |
|-------|-------------|--------------|---------------|------------|-------------|
| `dboxemailthreadcase` | VARCHAR | 255 | 1020 | TEXT (~10) | 1010 |
| `dboxemailthreadnews` | VARCHAR | 50 | 200 | TEXT (~10) | 190 |
| `dboxemailthreadswa` | VARCHAR | 255 | 1020 | TEXT (~10) | 1010 |
| `dboxewpstart` | VARCHAR | 170 | 680 | TEXT (~10) | 670 |
| `dboxewpend` | VARCHAR | 170 | 680 | TEXT (~10) | 670 |
| `dboxjsbpstart` | VARCHAR | 200 | 800 | TEXT (~10) | 790 |
| `dboxjsbpend` | VARCHAR | 200 | 800 | TEXT (~10) | 790 |
| `dboxonlinestart` | VARCHAR | 180 | 720 | TEXT (~10) | 710 |
| `dboxonlineend` | VARCHAR | 180 | 720 | TEXT (~10) | 710 |
| `dboxswastart` | VARCHAR | 180 | 720 | TEXT (~10) | 710 |
| `dboxswaend` | VARCHAR | 255 | 1020 | TEXT (~10) | 1010 |
| `dboxlocalts` | VARCHAR | 185 | 740 | TEXT (~10) | 730 |
| `dboxnewsts1` | VARCHAR | 190 | 760 | TEXT (~10) | 750 |
| `dboxnewsts2` | VARCHAR | 190 | 760 | TEXT (~10) | 750 |
| `dboxradioinvoice` | VARCHAR | 185 | 740 | TEXT (~10) | 730 |
| `dboxradioscript` | VARCHAR | 185 | 740 | TEXT (~10) | 730 |

**Subtotal: ~12,060 bytes freed**

### Category 3: Autoprint Path Fields (4 fields, ~2,040 bytes freed)

| Field | Current Type | Current Size | Current Bytes | After TEXT | Bytes Freed |
|-------|-------------|--------------|---------------|------------|-------------|
| `autoprintewp` | VARCHAR | 155 | 620 | TEXT (~10) | 610 |
| `autoprintjsbp` | VARCHAR | 170 | 680 | TEXT (~10) | 670 |
| `autoprintonline` | VARCHAR | 170 | 680 | TEXT (~10) | 670 |
| `autoprintswa` | VARCHAR | 185 | 740 | TEXT (~10) | 730 |

**Subtotal: ~2,680 bytes freed**

---

## 📊 Expected Results

```
Current (Phase 2):   46,845 bytes (576.5% capacity)
After TEXT Conv:     ~24,925 bytes (306.7% capacity)
Savings:             21,920 bytes (46.8% reduction!)
```

**Still 3x over limit, but major progress!**

---

## 🔧 Implementation Steps

### Step 1: Create Backup
```bash
cp entityDefs/TESTPERM.json entityDefs/TESTPERM.json.backup-phase3
```

### Step 2: Apply SQL TEXT Conversion
```sql
-- Convert URL fields to TEXT (8 fields)
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urlweb TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urljsbp TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urlonline TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urlswa TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urlqbpaylink TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urltrxmercury TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urlgmailadconfirm TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN stripepaymentlink TEXT;

-- Convert Dropbox ID fields to TEXT (16 fields)
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxemailthreadcase TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxemailthreadnews TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxemailthreadswa TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxewpstart TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxewpend TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxjsbpstart TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxjsbpend TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxonlinestart TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxonlineend TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxswastart TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxswaend TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxlocalts TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxnewsts1 TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxnewsts2 TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxradioinvoice TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxradioscript TEXT;

-- Convert Autoprint path fields to TEXT (4 fields)
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN autoprintewp TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN autoprintjsbp TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN autoprintonline TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN autoprintswa TEXT;
```

### Step 3: Update TESTPERM.json
Change field type from `"varchar"` to `"text"` for all 28 fields.
Remove `maxLength` attribute from TEXT fields.

### Step 4: Clear Cache
```bash
ssh permtrak2@permtrak.com "cd /home/permtrak2/dev.permtrak.com/EspoCRM && php command.php clear-cache"
```

### Step 5: Verify Byte Savings
Run row size query to confirm ~307% capacity.

### Step 6: Test Functionality
- Open TESTPERM records
- Verify URL/Dropbox/Autoprint fields display correctly
- Test editing and saving records

---

## ⚠️ Important Notes

### TEXT Field Behavior in EspoCRM

1. **Display:** TEXT fields display normally in UI
2. **Edit:** Users can edit TEXT fields like VARCHAR
3. **Search:** Full-text search still works (may need index rebuild)
4. **Export:** TEXT fields export normally to CSV/Excel
5. **API:** TEXT fields accessible via REST API

### What Won't Work with TEXT

❌ **Cannot be part of regular indexes** (B-tree)
❌ **Cannot have UNIQUE constraint**
❌ **Cannot be used in ORDER BY** (in some MySQL versions)
❌ **Cannot be part of composite keys**

### Our Fields Are Safe

All 28 fields we're converting:
✅ Are NOT indexed
✅ Do NOT have UNIQUE constraints
✅ Are NOT used for sorting
✅ Are NOT part of any keys
✅ Are display/storage only

**No functionality will be lost!**

---

## 🎯 After Phase 3

### Progress Summary

| Metric | Original | After Phase 3 | Total Change |
|--------|----------|---------------|--------------|
| **Bytes Used** | 64,165 | ~24,925 | -39,240 (61% reduction!) |
| **% Capacity** | 789.6% | ~306.7% | -482.9% |
| **Fields Optimized** | 0 | 64 total | 36 VARCHAR + 28 TEXT |

### Still Need

**To get under 8,126 byte limit:**
- Current after Phase 3: ~24,925 bytes
- Need to reduce: 16,799 more bytes
- **Still 3x over the limit**

### Phase 4 Options

**A) Field Removal** (~2,000-4,000 bytes)
- Remove 6 confirmed NULL fields
- Identify more unused fields

**B) More TEXT Conversions** (~3,000-5,000 bytes)
- Convert job description fields
- Convert notes fields
- Convert less critical text data

**C) Entity Split** (Final solution)
- Move 15-25 remaining fields to TESTPERM_DETAILS
- Target: TESTPERM under 8,000 bytes

---

**Ready to execute Phase 3 TEXT conversion!**

