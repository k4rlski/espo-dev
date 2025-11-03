# TESTPERM VARCHAR Optimization Plan

**Date:** 2025-11-03  
**Status:** Data Analysis Complete - Ready for Implementation

---

## 📊 Current Status

```
Current Row Size: 64,456 bytes (793.2% of 8,126 byte limit)
Target: < 8,126 bytes (ideally < 7,000 for buffer)
Deficit: 56,330 bytes OVER LIMIT
```

**CRITICAL:** This table is 7x over capacity and CANNOT FUNCTION safely.

---

## 🔍 Data Analysis Summary

Analyzed **75 VARCHAR fields** across sizes 255, 150, 120, 100, 80.

### Key Findings

| Category | Count | Current Bytes | Potential Savings |
|----------|-------|---------------|-------------------|
| **VARCHAR(255) fields** | 44 | 44,880 | ~25,000+ bytes |
| **VARCHAR(150) fields** | 7 | 4,200 | ~2,500 bytes |
| **VARCHAR(120) fields** | 2 | 960 | ~400 bytes |
| **VARCHAR(100) fields** | 21 | 8,400 | ~4,000 bytes |
| **VARCHAR(80) fields** | 1 | 320 | TBD |

**TOTAL OPTIMIZATION POTENTIAL: ~32,000 bytes (can get us to ~32,000 bytes = 393% capacity)**

---

## 🎯 Optimization Tiers

### 🔥 TIER 1: MASSIVE WINS (> 800 bytes saved per field)

| Field | Current | Max Used | Safe Size | Bytes Saved | Priority |
|-------|---------|----------|-----------|-------------|----------|
| `processor` | 255 | 3 | 15 | **968** | ⭐⭐⭐ |
| `entity` | 255 | 3 | 15 | **968** | ⭐⭐⭐ |
| `quotereport` | 255 | 7 | 20 | **940** | ⭐⭐⭐ |
| `attycasenumber` | 255 | 17 | 30 | **900** | ⭐⭐⭐ |
| `statacctgcreditnews` | 255 | 20 | 30 | **900** | ⭐⭐⭐ |
| `actionnotes` | 255 | 28 | 40 | **860** | ⭐⭐⭐ |
| `swasubacctuser` | 255 | 33 | 45 | **840** | ⭐⭐⭐ |
| `dboxemailthreadnews` | 255 | 21 | 50 | **820** | ⭐⭐⭐ |

**Subtotal: ~7,200 bytes saved (8 fields)**

---

### 🚀 TIER 2: BIG WINS (400-800 bytes saved per field)

| Field | Current | Max Used | Safe Size | Bytes Saved |
|-------|---------|----------|-----------|-------------|
| `jobaddress_street` | 255 | 57 | 70 | **740** |
| `urljsbp` | 255 | 112 | 125 | **520** |
| `adnumberlocal` | 150 | 13 | 30 | **480** |
| `codolpin` | 150 | 15 | 30 | **480** |
| `comsa` | 150 | 2 | 30 | **480** |
| `name` | 255 | 132 | 145 | **440** |
| `urlweb` | 255 | 134 | 145 | **440** |
| `autoprintewp` | 255 | 139 | 150 | **420** |

**Subtotal: ~4,000 bytes saved (8 fields)**

---

### 💪 TIER 3: SOLID WINS (200-400 bytes saved per field)

| Field | Current | Max Used | Safe Size | Bytes Saved |
|-------|---------|----------|-----------|-------------|
| `jobexperience` | 255 | 150 | 165 | **360** |
| `jobeducation` | 255 | 150 | 165 | **360** |
| `jobtitle` | 255 | 152 | 165 | **360** |
| `autoprintjsbp` | 255 | 155 | 170 | **340** |
| `autoprintonline` | 255 | 156 | 170 | **340** |
| `dboxewpstart` | 255 | 158 | 170 | **340** |
| `dboxewpend` | 255 | 158 | 170 | **340** |
| `stripepaymentlink` | 255 | 159 | 170 | **340** |
| `dboxswastart` | 255 | 165 | 180 | **300** |
| `dboxonlinestart` | 255 | 165 | 180 | **300** |
| `urltrxmercury` | 255 | 165 | 180 | **300** |
| `dboxonlineend` | 255 | 166 | 180 | **300** |
| `dboxradioscript` | 255 | 169 | 185 | **280** |
| `autoprintswa` | 255 | 169 | 185 | **280** |
| `dboxradioinvoice` | 255 | 172 | 185 | **280** |
| `dboxlocalts` | 255 | 173 | 185 | **280** |
| `urlgmailadconfirm` | 255 | 175 | 190 | **260** |
| `dboxnewsts1` | 255 | 175 | 190 | **260** |
| `dboxnewsts2` | 255 | 175 | 190 | **260** |
| `urlqbpaylink` | 255 | 178 | 190 | **260** |
| `dboxjsbpend` | 255 | 187 | 200 | **220** |
| `dboxjsbpstart` | 255 | 187 | 200 | **220** |
| `dboxemailthreadcase` | 255 | 191 | 205 | **200** |
| `dboxemailthreadswa` | 255 | 191 | 205 | **200** |
| `contactname` | 120 | 36 | 50 | **280** |
| `yournamefirst` | 150 | 68 | 80 | **280** |
| `yournamelast` | 150 | 69 | 80 | **280** |
| `jobaddress_state` | 100 | 10 | 30 | **280** |
| `conaics` | 100 | 20 | 30 | **280** |
| `jobaddress_city` | 100 | 18 | 30 | **280** |
| `attyassistant` | 100 | 20 | 30 | **280** |
| `statswaemail` | 100 | 13 | 30 | **280** |
| `jobhours` | 100 | 23 | 35 | **260** |
| `cocounty` | 100 | 24 | 35 | **260** |
| `cofein` | 100 | 25 | 35 | **260** |
| `stripeinvoiceid` | 100 | 27 | 40 | **240** |
| `coemailpermadspass` | 100 | 31 | 45 | **220** |
| `adnumbernews` | 100 | 39 | 50 | **200** |
| `cocity` | 100 | 40 | 55 | **180** |

**Subtotal: ~10,500 bytes saved (39 fields)**

---

### 📦 TIER 4: SMALLER WINS (< 200 bytes)

| Field | Current | Max Used | Safe Size | Bytes Saved |
|-------|---------|----------|-----------|-------------|
| `jobnaics` | 150 | 96 | 110 | **160** |
| `coemailcontactstandard` | 100 | 48 | 60 | **160** |
| `coaddress` | 100 | 50 | 65 | **140** |
| `attyname` | 120 | 77 | 90 | **120** |
| `dolbkupcodes` | 100 | 59 | 70 | **120** |
| `dboxswaend` | 255 | 216 | 230 | **100** |
| `contactemail` | 100 | 61 | 75 | **100** |
| `coemailpermads` | 100 | 66 | 80 | **80** |
| `jobsitezip` | 100 | 70 | 85 | **60** |
| `jobsitecity` | 100 | 78 | 90 | **40** |
| `jobsiteaddress` | 100 | 83 | 95 | **20** |
| `urlonline` | 255 | 240 | 255 | **0** (keep 255) |

**Subtotal: ~1,100 bytes saved (12 fields)**

---

## ⚠️ FIELDS TO SKIP (At/Near Capacity)

| Field | Current | Max Used | Action |
|-------|---------|----------|--------|
| `swasubacctpass` | 255 | 255 | ⛔ **SKIP** - At max capacity |
| `urlswa` | 255 | 255 | ⛔ **SKIP** - At max capacity |
| `swacomment` | 150 | 149 | ⛔ **SKIP** - Too close (1 char buffer) |
| `trxstring` | 100 | 100 | ⛔ **SKIP** - At max capacity |

---

## 🚫 EMPTY FIELDS (NULL Data - Consider Removal?)

| Field | Current Size | Max Data | Status |
|-------|-------------|----------|--------|
| `parentid` | 255 | NULL | No data ever stored |
| `attyfirm` | 255 | NULL | No data ever stored |
| `domainname` | 255 | NULL | No data ever stored |
| `coemailpermadsloginurl` | 100 | NULL | No data ever stored |
| `swasmartlink` | 80 | NULL | No data ever stored |
| `jobaddress_country` | 100 | NULL | No data ever stored |

**💡 Recommendation:** Set these to VARCHAR(30) minimum OR consider removing if truly unused.

---

## 🎯 RECOMMENDED IMPLEMENTATION PLAN

### Phase 1: Quick Wins (Tiers 1-2)
- **16 fields** optimized
- **~11,200 bytes** saved
- **Result:** 53,256 bytes (655% capacity) - Still over but significant progress

### Phase 2: Major Optimization (Tier 3)
- **39 fields** optimized
- **~10,500 bytes** saved
- **Result:** 42,756 bytes (526% capacity) - Still over but major progress

### Phase 3: Final Polish (Tier 4 + Empty Fields)
- **18 fields** optimized
- **~1,100 bytes** saved
- **Result:** 41,656 bytes (512% capacity)

### Phase 4: Empty Field Handling
- **6 fields** reduced to VARCHAR(30) each
- **~4,000 bytes** saved
- **Final Result:** ~37,656 bytes (463% capacity)

---

## 🚨 REALITY CHECK

**Even with ALL VARCHAR optimizations, we'll still be at ~37,000 bytes (463% capacity).**

### This means TESTPERM REQUIRES:

1. ✅ **Aggressive VARCHAR optimization (this plan)**
2. ✅ **Remove more unused fields/links**
3. ⚠️ **Consider TEXT field conversion** (move large fields to separate storage)
4. ⚠️ **Entity split strategy** (split into multiple related entities)

---

## 📋 NEXT STEPS

1. ✅ Review and approve optimization tiers
2. ✅ Update TESTPERM.json with `maxLength` values
3. ✅ Deploy to dev.permtrak.com
4. ✅ Run `rebuild --hard` to apply changes
5. ✅ Verify byte savings
6. ✅ Test record creation/editing
7. ✅ If still over limit, proceed to Phase 2 (entity split planning)

---

**Ready to proceed with Phase 1 (Tiers 1-2)?**

