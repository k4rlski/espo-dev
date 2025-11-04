# 🏆 BREAKTHROUGH: EspoCRM Row Size & Rebuild Problem SOLVED

**Date:** November 4, 2025, Tuesday Morning (Chiang Mai)
**Environment:** sandbox.permtrak.com
**Status:** ✅ **STABLE & READY FOR MANUAL TESTING**

---

## 🎯 The Problem We Faced

**Your frustration was 100% valid.** We were stuck in a loop:

1. Convert VARCHAR fields to TEXT via SQL ✅
2. Row size drops to 82% ✅
3. Run `rebuild` ❌
4. **Row size jumps back to 105%** ❌
5. All TEXT conversions reverted to VARCHAR ❌

It felt like EspoCRM was junk - nothing stuck!

---

## 💡 The Root Cause

**EspoCRM isn't junk - we just weren't following its workflow.**

EspoCRM's `rebuild` command **uses JSON metadata as the source of truth.** When we changed the database via SQL but didn't update the JSON, rebuild "corrected" our changes back to what the JSON said.

**Think of it like this:**
- JSON = The Blueprint
- Database = The Building
- `rebuild` = Inspector who "fixes" anything that doesn't match the blueprint

We were remodeling the building without updating the blueprint. So the inspector kept "fixing" our remodel.

---

## ✅ The Solution (3-Part Fix)

### Part 1: Update JSON with TEXT Definitions

Created a Python script (`fix-testperm-json-text-fields.py`) that:
- Updated 62 fields in `TESTPERM.json` from `varchar` to `text`
- Removed unnecessary attributes (`maxLength`, `dbType`, `len`)

**Result:** JSON now says "these should be TEXT"

### Part 2: Handle Address Fields (The Tricky Part)

**Problem:** The `jobaddress` field was type `"address"` - a compound field where EspoCRM hardcodes its components (street, city, state, postal_code) as VARCHAR. No amount of JSON editing could override this because it's in EspoCRM's core code.

**Solution:** Convert the compound field to individual TEXT fields:
1. Removed `jobaddress` (type: address) from JSON
2. Added 4 individual TEXT fields:
   - `jobaddress_street`
   - `jobaddress_city`
   - `jobaddress_state`
   - `jobaddress_postal_code`

**Trade-off:** Lost the fancy address widget, but gained database stability.

### Part 3: Apply SQL + Rebuild

1. Applied TEXT conversions via SQL
2. Deployed updated JSON
3. Ran `rebuild` - **IT KEPT THE TEXT FIELDS!** ✅
4. Ran `rebuild --hard` - **STILL STABLE!** ✅

---

## 📊 The Results

### Before Fix (This Morning)
- Row size: **104.7%** (over limit) ❌
- `rebuild` would revert all TEXT → VARCHAR ❌
- Constant backtracking and frustration ❌

### After Fix (Now)
- Row size: **80.3%** (under limit) ✅
- `rebuild` preserves TEXT fields ✅
- `rebuild --hard` preserves TEXT fields ✅
- **STABLE AND REBUILD-PROOF** ✅

---

## 🎓 What We Learned

### EspoCRM Best Practices

1. **JSON is the source of truth**
   - If you change DB via SQL, update JSON too
   - Otherwise `rebuild` will "fix" your changes

2. **The proper workflow:**
   ```
   1. Update JSON metadata
   2. Apply SQL changes
   3. Run rebuild
   4. Verify changes stuck
   ```

3. **Compound field types are hardcoded:**
   - `address`, `personName`, etc. have hardcoded component types
   - Can't override via JSON
   - Must convert to individual fields to control their types

4. **Cache must be off during metadata changes:**
   - Set `useCache: false` in config.php
   - Clear cache after every change
   - Re-enable when done testing

---

## 🚀 What's Ready Now

### Sandbox Environment (`sandbox.permtrak.com`)
- ✅ Full copy of dev.permtrak.com
- ✅ Database optimized to 80.3% row size
- ✅ Cache disabled for testing
- ✅ PHP 8.2 configured
- ✅ All metadata in GitHub (`k4rlski/espo-sandbox`)
- ✅ TEXT conversions are rebuild-proof

### Ready for Manual Testing
You can now safely test:
1. **Layout Manager:** Remove 'trx' field from TESTPERM layout
2. **Entity Manager:** Delete unused fields (like `parentid`)
3. **Field Positioning:** Reorder fields in PWD entity
4. **Record Operations:** Open, edit, save TESTPERM and PWD records

**The key difference:** With cache OFF and JSON in sync, these operations should work correctly and persist!

---

## 📋 What's Next (When You're Ready)

### Manual Testing Phase
1. Login to sandbox Admin UI
2. Verify cache is disabled
3. Run the 4 experiments (see `SANDBOX-READY-FOR-TESTING.md`)
4. Document results

### If Testing Goes Well
1. Apply same fixes to `dev.permtrak.com`
2. Monitor for 1-2 days
3. Eventually migrate to `prod.permtrak.com`

### If Issues Arise
- We have full backups
- Complete documentation of every change
- Both GitHub repos (`espo-dev` and `espo-sandbox`) are up to date

---

## 📁 Documentation Created

All saved in `espo-dev` repo and pushed to GitHub:

1. **`ESPOCRM-REBUILD-METADATA-SYNC-SOLUTION.md`**
   - Complete technical explanation
   - Before/after comparison
   - Lessons learned
   - Verification checklist

2. **`SANDBOX-READY-FOR-TESTING.md`**
   - Current sandbox state
   - Step-by-step test procedures
   - Expected results
   - Monitoring checklist

3. **`fix-testperm-json-text-fields.py`**
   - Script to update regular fields to TEXT

4. **`fix-jobaddress-to-text-fields.py`**
   - Script to convert address compound to individual TEXT fields

5. **`TESTPERM-REAPPLY-ALL-TEXT.sql`**
   - SQL to apply all TEXT conversions

---

## 🎯 Bottom Line

**We solved it.** The sandbox is stable, optimized, and rebuild-proof. 

**EspoCRM isn't junk** - it just has a specific workflow that we weren't following. Now that we understand it:
- JSON = Source of truth
- SQL changes must match JSON
- Compound fields can't be overridden (must be split)
- Cache off during metadata changes

**You now have a stable testing environment** to experiment with Layout Manager and Entity Manager without risking your dev or prod environments.

---

## ☕ Time for that Matcha

You earned it! The sandbox is ready whenever you want to test the UI.

**Next step:** Login and try moving some fields around. See if Layout Manager finally behaves now that cache is off and everything is in sync.

---

**All code, scripts, and documentation are committed to GitHub. Nothing lost, everything documented.**

