# TESTPERM "Old JSBP Fields" - Field Identification & Usage Analysis

**Date:** 2025-11-03  
**Source:** User screenshot showing "Old JSBP Fields" section

---

## 🔍 Field Mapping (Label → Field Name)

Based on the screenshot and database forensics:

| Screenshot Label | Field Name | Type | Usage | Status |
|-----------------|------------|------|-------|--------|
| **Ordered Job Search Board** | `chkbuyjsbp` | checklist | **19% (2,365/12,390)** | ⚠️ **IN USE** |
| **Datat JSBP Start** | `dstatjsbpstart` | multiEnum | **25% (3,108/12,390)** | ⚠️ **IN USE** |
| **Datat JSBP End** | `dstatjsbpend` | multiEnum | **25% (3,103/12,390)** | ⚠️ **IN USE** |
| **Dbox JSBP End** | `dboxjsbpend` | TEXT | (TEXT field) | ✅ No row size impact |
| **Date JSBP Start** | `datejsbpstart` | date | **5% (643/12,390)** | ⚠️ **IN USE** |
| **Date JSBP End** | `datejsbpend` | date | **5% (644/12,390)** | ⚠️ **IN USE** |
| **JSBP Ad Text** | `adtextjsbp` | mediumtext | **7% (856/12,390)** | ✅ No row size impact |
| **JB-Stat** (showing "-") | `statjsbp` | multiEnum | **79% (9,765/12,390)** | ⚠️ **HEAVILY USED!** |
| **Urljsbp** | `urljsbp` | TEXT | (TEXT field) | ✅ Already TEXT, optimized |
| **JQ** | *(field not found)* | ? | ? | ❓ May be label only |
| **JRP** | *(field not found)* | ? | ? | ❓ May be label only |
| **Auto-Print JSBP** | `autoprintjsbp` | TEXT | (TEXT field) | ✅ Already TEXT, optimized |
| **Dbox JSBP Start** | `dboxjsbpstart` | TEXT | (TEXT field) | ✅ Already TEXT, optimized |
| **Transactions** | `trx` (link) | linkMultiple | (link field) | ℹ️ Cannot delete via UI |

---

## 🚨 CRITICAL FINDING

**These JSBP fields are NOT unused!**

### High Usage Fields (DO NOT DELETE):
- ⚠️ **`statjsbp`** - **79% usage** (9,765 / 12,390 records) - **HEAVILY USED!**
- ⚠️ **`dstatjsbpstart`** - 25% usage (3,108 records)
- ⚠️ **`dstatjsbpend`** - 25% usage (3,103 records)
- ⚠️ **`chkbuyjsbp`** - 19% usage (2,365 records)

### Low Usage Fields (Consider for deletion):
- `adtextjsbp` - 7% usage (856 records) - But it's TEXT (no row size impact)
- `datejsbpstart` - 5% usage (643 records) - Only 3 bytes (date type)
- `datejsbpend` - 5% usage (644 records) - Only 3 bytes (date type)

### Already Optimized (TEXT fields):
- ✅ `dboxjsbpstart` - TEXT (0 row size impact)
- ✅ `dboxjsbpend` - TEXT (0 row size impact)
- ✅ `autoprintjsbp` - TEXT (0 row size impact)
- ✅ `urljsbp` - TEXT (0 row size impact)
- ✅ `adtextjsbp` - mediumtext (0 row size impact)

---

## 📊 Row Size Impact Analysis

### Current JSBP Field Byte Usage:

| Field | Type | Bytes | Can Delete? |
|-------|------|-------|-------------|
| `chkbuyjsbp` | mediumtext | 0 | ❌ 19% usage |
| `datejsbpstart` | date | 3 | ❌ 5% usage |
| `datejsbpend` | date | 3 | ❌ 5% usage |
| `dstatjsbpstart` | mediumtext | 0 | ❌ 25% usage |
| `dstatjsbpend` | mediumtext | 0 | ❌ 25% usage |
| `adtextjsbp` | mediumtext | 0 | TEXT - no impact |
| `statjsbp` | mediumtext | 0 | ❌ **79% usage!** |
| `dboxjsbpstart` | TEXT | 0 | TEXT - no impact |
| `dboxjsbpend` | TEXT | 0 | TEXT - no impact |
| `autoprintjsbp` | TEXT | 0 | TEXT - no impact |
| `urljsbp` | TEXT | 0 | TEXT - no impact |
| `pricejsbpquote` | double + currency | 12 | ℹ️ Pricing data |
| `pricejsbpreal` | double + currency | 12 | ℹ️ Pricing data |

**Total JSBP Row Size Impact: ~30 bytes** (just dates + currency codes)

**Most JSBP fields are already TEXT and don't count toward row size!**

---

## 💡 Why Screenshot Shows "None"

The screenshot shows "None" for JSBP fields because:

1. **You're viewing a specific TESTPERM record** that doesn't have JSBP data
2. **NOT** because the fields are unused across the entire table
3. **79% of records have `statjsbp` data** - this is actively used!

**Just because ONE record shows "None" doesn't mean the field is unused!**

---

## ✅ RECOMMENDATION: DO NOT DELETE JSBP FIELDS

**Reasons:**
1. ⚠️ **High usage** - `statjsbp` used in 79% of records
2. ⚠️ **Moderate usage** - Other JSBP fields used in 5-25% of records
3. ✅ **Already optimized** - Most are TEXT (0 row size impact)
4. ✅ **Minimal impact** - Only ~30 bytes total (dates + currencies)

**Deleting these would:**
- ❌ Lose data in thousands of records
- ❌ Break JSBP workflow functionality
- ✅ Save only ~30 bytes (negligible)

---

## 🎯 Fields That ARE Safe to Delete (From Earlier Analysis)

**These are truly NULL/unused:**

| Field | Size | Status | Safe to Delete? |
|-------|------|--------|-----------------|
| `parentid` | 1,020 bytes | NULL (0 records) | ✅ **YES** |
| `attyfirm` | 1,020 bytes | NULL (0 records) | ✅ **YES** |
| `domainname` | 1,020 bytes | NULL (0 records) | ✅ **YES** |
| `coemailpermadsloginurl` | 400 bytes | NULL (0 records) | ✅ **YES** |
| `jobaddress_country` | 400 bytes | NULL (0 records) | ✅ **YES** |

**Total Safe Deletion: ~4,860 bytes**

---

## 📋 UPDATED RECOMMENDATION

**DO NOT delete JSBP fields from your screenshot!**

**INSTEAD, delete these 5 confirmed NULL fields:**
1. `parentid`
2. `attyfirm`
3. `domainname`
4. `coemailpermadsloginurl`
5. `jobaddress_country`

These are truly unused (0 records) and will save ~4,860 bytes without any data loss.

---

**The JSBP fields in your screenshot are actively used and should be kept!**

