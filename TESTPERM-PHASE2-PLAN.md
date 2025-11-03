# TESTPERM Phase 2 - Tier 3 Optimization Plan

**Date:** 2025-11-03  
**Status:** Ready for Implementation

---

## 📊 Current Status

```
Current (after Phase 1): 53,825 bytes (662.4% capacity)
Target (after Phase 2):  ~43,465 bytes (535% capacity)
Expected Savings:        ~10,360 bytes
```

---

## 🎯 Phase 2 Fields (38 fields + 1 already done)

**Note:** `jobtitle` was already optimized in Phase 1 as a bonus field (255→165).

### VARCHAR(255) Fields → Reduced (23 fields)

| # | Field | Current | New Size | Max Data | Buffer | Bytes Saved |
|---|-------|---------|----------|----------|--------|-------------|
| 1 | `jobexperience` | 255 | **165** | 150 | +15 | 360 |
| 2 | `jobeducation` | 255 | **165** | 150 | +15 | 360 |
| 3 | `autoprintjsbp` | 255 | **170** | 155 | +15 | 340 |
| 4 | `autoprintonline` | 255 | **170** | 156 | +14 | 340 |
| 5 | `dboxewpstart` | 255 | **170** | 158 | +12 | 340 |
| 6 | `dboxewpend` | 255 | **170** | 158 | +12 | 340 |
| 7 | `stripepaymentlink` | 255 | **170** | 159 | +11 | 340 |
| 8 | `dboxswastart` | 255 | **180** | 165 | +15 | 300 |
| 9 | `dboxonlinestart` | 255 | **180** | 165 | +15 | 300 |
| 10 | `urltrxmercury` | 255 | **180** | 165 | +15 | 300 |
| 11 | `dboxonlineend` | 255 | **180** | 166 | +14 | 300 |
| 12 | `dboxradioscript` | 255 | **185** | 169 | +16 | 280 |
| 13 | `autoprintswa` | 255 | **185** | 169 | +16 | 280 |
| 14 | `dboxradioinvoice` | 255 | **185** | 172 | +13 | 280 |
| 15 | `dboxlocalts` | 255 | **185** | 173 | +12 | 280 |
| 16 | `urlgmailadconfirm` | 255 | **190** | 175 | +15 | 260 |
| 17 | `dboxnewsts1` | 255 | **190** | 175 | +15 | 260 |
| 18 | `dboxnewsts2` | 255 | **190** | 175 | +15 | 260 |
| 19 | `urlqbpaylink` | 255 | **190** | 178 | +12 | 260 |
| 20 | `dboxjsbpend` | 255 | **200** | 187 | +13 | 220 |
| 21 | `dboxjsbpstart` | 255 | **200** | 187 | +13 | 220 |
| 22 | `dboxemailthreadcase` | 255 | **205** | 191 | +14 | 200 |
| 23 | `dboxemailthreadswa` | 255 | **205** | 191 | +14 | 200 |

**Subtotal: 6,620 bytes**

### VARCHAR(150) Fields → Reduced (2 fields)

| # | Field | Current | New Size | Max Data | Buffer | Bytes Saved |
|---|-------|---------|----------|----------|--------|-------------|
| 24 | `yournamefirst` | 150 | **80** | 68 | +12 | 280 |
| 25 | `yournamelast` | 150 | **80** | 69 | +11 | 280 |

**Subtotal: 560 bytes**

### VARCHAR(120) Fields → Reduced (1 field)

| # | Field | Current | New Size | Max Data | Buffer | Bytes Saved |
|---|-------|---------|----------|----------|--------|-------------|
| 26 | `contactname` | 120 | **50** | 36 | +14 | 280 |

**Subtotal: 280 bytes**

### VARCHAR(100) Fields → Reduced (12 fields)

| # | Field | Current | New Size | Max Data | Buffer | Bytes Saved |
|---|-------|---------|----------|----------|--------|-------------|
| 27 | `jobaddress_state` | 100 | **30** | 10 | +20 | 280 |
| 28 | `conaics` | 100 | **30** | 20 | +10 | 280 |
| 29 | `jobaddress_city` | 100 | **30** | 18 | +12 | 280 |
| 30 | `attyassistant` | 100 | **30** | 20 | +10 | 280 |
| 31 | `statswaemail` | 100 | **30** | 13 | +17 | 280 |
| 32 | `jobhours` | 100 | **35** | 23 | +12 | 260 |
| 33 | `cocounty` | 100 | **35** | 24 | +11 | 260 |
| 34 | `cofein` | 100 | **35** | 25 | +10 | 260 |
| 35 | `stripeinvoiceid` | 100 | **40** | 27 | +13 | 240 |
| 36 | `coemailpermadspass` | 100 | **45** | 31 | +14 | 220 |
| 37 | `adnumbernews` | 100 | **50** | 39 | +11 | 200 |
| 38 | `cocity` | 100 | **55** | 40 | +15 | 180 |

**Subtotal: 3,020 bytes**

---

## 📊 Phase 2 Summary

| Category | Fields | Bytes Saved |
|----------|--------|-------------|
| VARCHAR(255) reduced | 23 | 6,620 |
| VARCHAR(150) reduced | 2 | 560 |
| VARCHAR(120) reduced | 1 | 280 |
| VARCHAR(100) reduced | 12 | 3,020 |
| **TOTAL** | **38** | **10,480** |

**All buffers: 10-20 chars minimum** - Very safe!

---

## ✅ Safety Verification

- ✅ All fields have 10+ char buffer
- ✅ Average buffer: 13 chars
- ✅ Maximum buffer: 20 chars  
- ✅ No fields at/near capacity included
- ✅ Based on actual data analysis from 16,705 records

---

## 🔧 Implementation Steps

1. Create backup of current TESTPERM.json
2. Update 38 fields with `maxLength` values in JSON
3. Create SQL ALTER TABLE script
4. Apply SQL changes (drop FULLTEXT first if needed)
5. Clear cache
6. Verify byte savings
7. Test record editing
8. Commit and push to git

---

## 📈 Expected Results

```
Phase 1 Result:  53,825 bytes (662.4% capacity)
Phase 2 Target:  43,345 bytes (533.4% capacity)  
Total Savings:   10,480 bytes
```

**Still over limit, but major progress!**

After Phase 2, we'll have optimized **53 fields total** and saved **~20,820 bytes**.

---

**Ready to proceed?**

