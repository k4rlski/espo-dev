# TESTPERM Entity Split Strategy - Comprehensive Analysis

**Date:** 2025-11-03  
**Current Status:** 26,685 bytes (328.4% capacity) - 3.28x over limit  
**Target:** < 8,126 bytes (100% capacity)  
**Need to Remove:** 18,559 bytes

---

## 🎯 Entity Split Strategy Overview

### Concept

Split TESTPERM into **2-3 related entities** based on **logical data grouping** and **access frequency**:

**TESTPERM (Main)** - Core, frequently accessed data  
**TESTPERM_COMPANY** - Company/employer details  
**TESTPERM_WORKFLOW** - Workflow/processing details (optional)

---

## 📊 Current Field Breakdown by Category

### **Category 1: CORE FIELDS (Keep in Main TESTPERM) - ~4,500 bytes**

**Essential Identifiers:**
- `id` (17) - PRIMARY KEY
- `name` (150) - 600 bytes - **REQUIRED, main display field**
- `casenumber` (10) - 40 bytes
- `pwdcasenum` (24) - 96 bytes
- `attycasenumber` (30) - 120 bytes

**System Fields (Cannot Remove):**
- `created_by_id` (17) - 68 bytes
- `modified_by_id` (17) - 68 bytes
- `assigned_user_id` (17) - 68 bytes
- `createdAt` (datetime) - 8 bytes
- `modifiedAt` (datetime) - 8 bytes
- `deleted` (tinyint) - 1 byte

**Link Fields (Relationships):**
- `account_id` (17) - 68 bytes - Link to Account
- `local_id` (17) - 68 bytes - Link to Local
- `news_id` (17) - 68 bytes - Link to News
- `online_id` (17) - 68 bytes - Link to Online
- `radio_id` (17) - 68 bytes - Link to Radio
- `swa_id` (17) - 68 bytes - Link to SWA

**Status/Classification:**
- `entity` (15) - 60 bytes - ENUM (PA/NA/JKT)
- `processor` (15) - 60 bytes - ENUM (payment processor)
- `quotereport` (20) - 80 bytes - ENUM (yes/no/---)
- `statacctgcreditnews` (35) - 140 bytes

**Core Dates:**
- Multiple date fields (date type) - 3 bytes each
- `datepaidlocal`, `datepwddeadline`, etc.

**Subtotal: ~4,500 bytes**

---

### **Category 2: COMPANY FIELDS (Move to TESTPERM_COMPANY) - ~6,500 bytes**

**Employer Contact Info:**
- `cocontactfirst` (60) - 240 bytes
- `cocontactlast` (60) - 240 bytes
- `cophone` (60) - 240 bytes
- `contactname` (120) - 480 bytes
- `contactemail` (100) - 400 bytes

**Employer Address:**
- `coaddress` (100) - 400 bytes
- `cocity` (100) - 400 bytes
- `cocounty` (100) - 400 bytes
- `costate` (40) - 160 bytes
- `cozip` (40) - 160 bytes

**Employer Business Info:**
- `cofein` (100) - 400 bytes
- `conaics` (100) - 400 bytes
- `comsa` (30) - 120 bytes
- `coyearbusinessformed` (20) - 80 bytes

**Employer Email/Login Credentials:**
- `coemailcontactstandard` (100) - 400 bytes
- `coemailpermads` (100) - 400 bytes
- `coemailpermadslogin` (60) - 240 bytes
- `coemailpermadspass` (100) - 400 bytes
- `coemailpermadsloginurl` (100) - 400 bytes **← NULL field**

**Employer Portal Access:**
- `codollogin` (40) - 160 bytes
- `codolpass` (40) - 160 bytes
- `codolpin` (30) - 120 bytes
- `coswalogin` (60) - 240 bytes
- `coswapassword` (40) - 160 bytes
- `coswauinumber` (40) - 160 bytes

**Subtotal: ~6,500 bytes**
**If moved to separate entity: TESTPERM saves ~6,500 bytes!**

---

### **Category 3: JOB DETAILS (Move to TESTPERM_COMPANY or separate) - ~5,000 bytes**

**Job Title & Description:**
- `jobtitle` (255) - 1,020 bytes - **LARGE**
- `jobexperience` (165 / TEXT) - 0 bytes - **Already TEXT**
- `jobeducation` (165 / TEXT) - 0 bytes - **Already TEXT**
- `jobnaics` (150) - 600 bytes
- `jobhours` (100) - 400 bytes

**Job Location:**
- `jobaddress_street` (255) - 1,020 bytes - **LARGE**
- `jobaddress_city` (100) - 400 bytes
- `jobaddress_state` (100) - 400 bytes
- `jobaddress_postal_code` (40) - 160 bytes
- `jobaddress_country` (100) - 400 bytes **← NULL field**

**Job Site (if different):**
- `jobsiteaddress` (100) - 400 bytes
- `jobsitecity` (100) - 400 bytes
- `jobsitestate` (40) - 160 bytes
- `jobsitezip` (100) - 400 bytes

**Salary Info:**
- `salary` (20) - 80 bytes
- `salaryrange` (24) - 96 bytes
- `jobsalary` (16) - 64 bytes
- Various salary currency fields (3 bytes each) - 36 bytes total

**Subtotal: ~5,000 bytes (excluding TEXT fields)**
**If moved: TESTPERM saves ~5,000 bytes!**

---

### **Category 4: WORKFLOW/PROCESSING (Keep or Separate) - ~3,000 bytes**

**SWA (State Workforce Agency) Fields:**
- `swasubacctuser` (45) - 180 bytes
- `swasubacctpass` (255) - 1,020 bytes - **LARGE, at capacity**
- `swacomment` (150) - 600 bytes - **At capacity (149/150)**
- `statswaemail` (100) - 400 bytes

**DOL (Department of Labor) Fields:**
- `dolbkupcodes` (100) - 400 bytes

**Ad Tracking:**
- `adnumberlocal` (30) - 120 bytes
- `adnumbernews` (100) - 400 bytes

**Subtotal: ~3,000 bytes**

---

### **Category 5: ATTORNEY/REP FIELDS (Keep in Main or Move) - ~1,500 bytes**

**Attorney Info:**
- `attyfirm` (255) - 1,020 bytes **← NULL field, LARGE**
- `attyname` (120) - 480 bytes
- `attyassistant` (100) - 400 bytes

**Beneficiary Info:**
- `beneficiaryfirst` (60) - 240 bytes
- `beneficiarylast` (60) - 240 bytes
- `yournamefirst` (150) - 600 bytes
- `yournamelast` (150) - 600 bytes

**Subtotal: ~3,580 bytes**

---

### **Category 6: PAYMENT/PRICING FIELDS (Keep or Move) - ~2,500 bytes**

**Various Price Fields:**
- `pricedolquote`, `pricedolreal` - Currency + value
- `priceewpquote`, `priceewpreal` - Currency + value
- `pricejsbpquote`, `pricejsbpreal` - Currency + value
- `pricelocalquote`, `pricelocalreal` - Currency + value
- `pricenewsquote`, `pricenewsreal` - Currency + value
- `priceonlinequote`, `priceonlinereal` - Currency + value
- `priceradioquote`, `priceradioreal` - Currency + value
- `priceswaquote`, `priceswareal` - Currency + value
- `pricesvcfee` - Currency + value
- `salarymax`, `salarymin` - Currency + value

**Transaction Tracking:**
- `trxstring` (100) - 400 bytes - **At capacity**
- `stripeinvoiceid` (100) - 400 bytes

**Subtotal: ~2,500 bytes**

---

### **Category 7: DROPBOX/AUTOPRINT (Already TEXT) - 0 bytes counted**

**These are already TEXT and don't count toward row size:**
- All `dbox*` fields (16 fields) - Already TEXT ✅
- All `autoprint*` fields (4 fields) - Already TEXT ✅
- All `url*` fields (8 fields) - Already TEXT ✅

**Subtotal: 0 bytes (TEXT doesn't count)**

---

### **Category 8: NULL/UNUSED FIELDS (DELETE THESE) - ~3,460 bytes**

**Confirmed NULL fields (never used):**
- `parentid` (255) - 1,020 bytes **← DELETE**
- `attyfirm` (255) - 1,020 bytes **← DELETE**
- `domainname` (255) - 1,020 bytes **← DELETE**
- `coemailpermadsloginurl` (100) - 400 bytes **← DELETE**
- `jobaddress_country` (100) - 400 bytes **← DELETE**

**Already deleted:**
- `swasmartlink` (80) - 320 bytes - ✅ Deleted

**Subtotal: 4,860 bytes available to delete**

---

## 🎯 RECOMMENDED ENTITY SPLIT STRATEGY

### **Plan A: 2-Entity Split (Simpler)**

#### **TESTPERM (Main Entity)** - ~10,000 bytes

**Keep:**
- ✅ Core identifiers (id, name, casenumber, etc.)
- ✅ System fields (dates, assigned user, created by, etc.)
- ✅ Link fields (account_id, local_id, news_id, etc.)
- ✅ Status fields (entity, processor, quotereport)
- ✅ Attorney/beneficiary names
- ✅ Core dates
- ✅ Payment/pricing (for quick access)

**Result: ~10,000 bytes (123% capacity) - STILL OVER!**

#### **TESTPERM_DETAILS (Related Entity)** - ~8,000 bytes

**Move:**
- ✅ All company fields (co* prefix) - 6,500 bytes
- ✅ All job fields (job* prefix) - 5,000 bytes
- ✅ SWA workflow fields - 3,000 bytes
- ✅ DOL fields
- ✅ Ad tracking

**Result: ~8,000 bytes (98% capacity) - Under limit! ✅**

**Link:** One-to-one relationship via `testperm_id` foreign key

---

### **Plan B: 3-Entity Split (More Aggressive)**

#### **TESTPERM (Main)** - ~7,500 bytes

**Keep ONLY:**
- Core identifiers
- System fields
- Link fields
- Status fields
- Core dates

**Result: ~7,500 bytes (92% capacity) - Under limit! ✅**

#### **TESTPERM_COMPANY** - ~11,000 bytes

**Move:**
- All company fields (co*)
- All job fields (job*)
- Attorney/beneficiary info

**Result: ~11,000 bytes (135% capacity) - OVER LIMIT**

#### **TESTPERM_WORKFLOW** - ~5,000 bytes

**Move:**
- SWA fields
- DOL fields
- Ad tracking
- Payment/pricing

**Result: ~5,000 bytes (62% capacity) - Under limit! ✅**

---

## 🚨 CRITICAL FINDING

**Even with entity split, some entities may STILL be over the limit!**

This suggests:
1. **Delete NULL fields FIRST** (saves 4,860 bytes immediately)
2. **Then do entity split**
3. **May need to TEXT convert more fields**

---

## 📋 RECOMMENDED EXECUTION PLAN

### **Phase 4a: Delete NULL/Unused Fields** (~4,860 bytes)

**Delete these 5 fields (manual SQL, not Entity Manager):**
1. `parentid` - 1,020 bytes
2. `attyfirm` - 1,020 bytes
3. `domainname` - 1,020 bytes
4. `coemailpermadsloginurl` - 400 bytes
5. `jobaddress_country` - 400 bytes

**After:** ~21,825 bytes (268% capacity)

### **Phase 4b: More TEXT Conversions** (~3,000 bytes)

**Convert to TEXT:**
1. `jobtitle` (255→TEXT) - 1,020 bytes
2. `jobaddress_street` (255→TEXT) - 1,020 bytes
3. `swasubacctpass` (255→TEXT) - 1,020 bytes

**After:** ~18,825 bytes (232% capacity)

### **Phase 4c: Entity Split** (~10,000 bytes)

**Move to TESTPERM_DETAILS:**
- All company fields (6,500 bytes)
- Job location fields (remaining VARCHARs)
- SWA/DOL workflow fields

**After:** TESTPERM ~8,000-9,000 bytes (98-111% capacity)

---

## ✅ WHICH FIELDS DO YOU WANT TO DELETE?

**Please review the list above and tell me which NULL/unused fields you want to delete!**

I can then create the SQL script to remove them safely (without using Entity Manager).

---

**Ready for your field deletion list!**

