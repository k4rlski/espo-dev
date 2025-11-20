# EspoCRM Dev: Custom Metadata & Layouts

**Environment:** Development  
**Domain:** `https://dev.permtrak.com/EspoCRM/`  
**Purpose:** Development environment for EspoCRM custom entities and metadata  
**Database:** `permtrak2_dev`

---

## 🌐 **Repository Ecosystem**

This repository is part of a 10-repository deployment pipeline for managing EspoCRM and WordPress Reports across multiple environments.

### **EspoCRM Repositories (5 Total)**

| Repo | Environment | Domain | Purpose |
|------|-------------|---------|---------|
| **[espo-ctl](https://github.com/k4rlski/espo-ctl)** | Control | N/A | Automation scripts, shared config, credentials, **ALL DOCUMENTATION** |
| **[espo-sandbox](https://github.com/k4rlski/espo-sandbox)** | Sandbox | `sandbox.permtrak.com/EspoCRM` | Sandbox/testing CRM (source) |
| **[espo-dev](https://github.com/k4rlski/espo-dev)** ⭐ | Development | `dev.permtrak.com/EspoCRM` | **THIS REPO** - Development CRM |
| **[espo-staging](https://github.com/k4rlski/espo-staging)** | Staging | `staging.permtrak.com/EspoCRM` | Pre-production CRM |
| **[espo-crm](https://github.com/k4rlski/espo-crm)** | Production | `crm.permtrak.com/EspoCRM` | Production CRM |

### **WordPress Reports Repositories (5 Total)**

| Repo | Environment | Domain | Purpose |
|------|-------------|---------|---------|
| **[reports-ctl](https://github.com/k4rlski/reports-ctl)** | Control | N/A | Automation scripts, shared config, deployment tools |
| **[reports-sb](https://github.com/k4rlski/reports-sb)** | Sandbox | `rpx-sb.permtrak.com` | Sandbox WordPress environment |
| **[reports-dev](https://github.com/k4rlski/reports-dev)** | Development | `rpx-dev.permtrak.com` | Development WordPress environment |
| **[reports-st](https://github.com/k4rlski/reports-st)** | Staging | `rpx-st.permtrak.com` | Pre-production WordPress |
| **[reports-crm](https://github.com/k4rlski/reports-crm)** | Production | `reports.permtrak.com` | Production WordPress |

---

## 📂 **What's in This Repo**

This repository contains EspoCRM custom metadata, entity definitions, and layouts for the **Development** environment:

### **Directory Structure**
```
espo-dev/
├── README.md                    # This file
├── clientDefs/                  # Client-side entity definitions
│   ├── TESTPERM.json           # PERM case client config
│   ├── PWD.json                # Prevailing Wage Determination config
│   ├── News.json               # Main newspaper entity config
│   ├── SWA.json                # State Workforce Agency config
│   └── ... (30+ entity definitions)
├── entityDefs/                  # Server-side entity definitions
│   ├── TESTPERM.json           # PERM case field definitions
│   ├── PWD.json                # PWD field definitions (144 fields)
│   ├── News.json               # Main newspaper field definitions
│   └── ... (30+ entity definitions)
├── recordDefs/                  # Record-level business logic
│   └── ... (entity-specific record definitions)
├── scopes/                      # Entity scope configurations
│   ├── TESTPERM.json           # PERM case scope
│   ├── PWD.json                # PWD scope
│   └── ... (30+ scope definitions)
└── layouts/                     # UI layout configurations
    ├── TESTPERM/               # PERM case layouts
    │   ├── detail.json         # Detail view layout
    │   ├── list.json           # List view layout
    │   └── ... (filters, search, etc.)
    └── ... (layouts for all entities)
```

---

## 🚀 **Deployment Pipeline**

This repo is part of an automated deployment pipeline:

```
Sandbox (espo-sandbox)
    ↓ [Clone + Config Update]
Development (espo-dev) ⭐ YOU ARE HERE
    ↓ [Clone + Config Update]
Staging (espo-staging)
    ↓ [Clone + Config Update]
Production (espo-crm)
```

**Deployment Tool:** `espo-ctl/scripts/espo-clone.py`

---

## 📚 **Key Documentation**

### **⚠️ ALL DOCUMENTATION IS IN `espo-ctl` REPO**

All comprehensive documentation is centralized in the **[espo-ctl](https://github.com/k4rlski/espo-ctl)** repository:

- **[DEPLOYMENT-PIPELINE-PLAN.md](https://github.com/k4rlski/espo-ctl/blob/main/docs/DEPLOYMENT-PIPELINE-PLAN.md)** - Overall deployment strategy (541 lines)
- **[DEPLOYMENT-STATUS-2025-11-20.md](https://github.com/k4rlski/espo-ctl/blob/main/docs/DEPLOYMENT-STATUS-2025-11-20.md)** - Initial dev deployment summary
- **[DEPLOYMENT-SUCCESS-2025-11-20-CLEAN-BASELINE.md](https://github.com/k4rlski/espo-ctl/blob/main/docs/DEPLOYMENT-SUCCESS-2025-11-20-CLEAN-BASELINE.md)** - Clean baseline establishment (117 files eliminated)
- **[CRITICAL-FIX-ENVIRONMENT-LINKAGE.md](https://github.com/k4rlski/espo-ctl/blob/main/docs/CRITICAL-FIX-ENVIRONMENT-LINKAGE.md)** - Environment linkage fixes for WordPress & EspoCRM
- **[WORDPRESS-PATHS-AND-CREDENTIALS.md](https://github.com/k4rlski/espo-ctl/blob/main/docs/WORDPRESS-PATHS-AND-CREDENTIALS.md)** - WordPress file structure & credentials
- **[REPOSITORY-STRUCTURE.md](https://github.com/k4rlski/espo-ctl/blob/main/docs/REPOSITORY-STRUCTURE.md)** - Complete 10-repo ecosystem map
- **[ROOT-CAUSE-ANALYSIS-HARDCODED-LINKS.md](https://github.com/k4rlski/espo-ctl/blob/main/docs/ROOT-CAUSE-ANALYSIS-HARDCODED-LINKS.md)** - Hard-coded link contamination analysis
- **[HARD-CODED-LINKS-SCANNER.md](https://github.com/k4rlski/espo-ctl/blob/main/docs/HARD-CODED-LINKS-SCANNER.md)** - Scanner tool documentation
- **[DEPLOYMENT-STATUS-2025-11-20-FINAL.md](https://github.com/k4rlski/espo-ctl/blob/main/docs/DEPLOYMENT-STATUS-2025-11-20-FINAL.md)** - Final comprehensive deployment summary

**Total Documentation:** 3,500+ lines across 9 comprehensive documents

---

## 🏷️ **Golden Images (Rollback Points)**

This repository has tagged "Golden Images" representing known-good, stable states:

| Tag | Date | Description | Status |
|-----|------|-------------|--------|
| `golden-image-2025-11-20-dev-clone` | 2025-11-20 | Initial dev clone from sandbox | ⭐ LATEST |

**To rollback to a Golden Image:**
```bash
git checkout golden-image-2025-11-20-dev-clone
```

---

## ✅ **Current Status**

### **Environment Verification**
- ✅ **Custom metadata cloned from sandbox**
- ✅ **Database config verified** (`permtrak2_dev`)
- ✅ **EspoCRM cache cleared and rebuilt**
- ✅ **User confirmed:** "Espo dev seems to be working fine"

### **Database Configuration**
- ✅ `config-internal.php` points to `permtrak2_dev`
- ✅ Database credentials verified
- ✅ No cross-environment contamination

### **Custom Entities (30+)**
- `TESTPERM` - PERM labor certification cases
- `PWD` - Prevailing Wage Determinations (144 fields)
- `News` - Main newspaper media
- `Local` - Local newspaper media
- `Radio` - Radio station media
- `SWA` - State Workforce Agency records
- `Online` - Online media
- `CAcctCodes` - Account codes
- `Accounting` - Accounting records
- `CTransactions` - Communications transactions
- `CCommunications` - Communications records
- `CAutoPrint` - Auto-print records
- `CDomainmgt` - Domain management
- `CVendorMgt` - Vendor management
- `CBizExp` - Business expenses
- `CZipsToMedia` - Zip to media mapping
- `ZipToMedia` - Individual zip-media links
- ... and 13+ more custom entities

---

## 🔧 **Local Development**

### **Server Paths**
- **EspoCRM Root:** `/home/permtrak2/dev.permtrak.com/EspoCRM/`
- **Custom Metadata:** `/home/permtrak2/dev.permtrak.com/EspoCRM/custom/Espo/Custom/Resources/metadata/`
- **Config:** `/home/permtrak2/dev.permtrak.com/EspoCRM/data/config-internal.php`

### **Syncing Metadata to Local Repo**
```bash
cd "/home/falken/DEVOPS Dropbox/DEVOPS-KARL/CORE-v4/2-ESPOCRM/ESPO-AUTOMATION/espo-dev"

# Sync all metadata
scp -r permtrak2@permtrak.com:/home/permtrak2/dev.permtrak.com/EspoCRM/custom/Espo/Custom/Resources/metadata/* .

# Commit changes
git add -A
git commit -m "Your commit message"
git push origin main
```

### **Deploying Metadata from Local to Server**
```bash
# Deploy metadata
scp -r clientDefs entityDefs recordDefs scopes layouts permtrak2@permtrak.com:/home/permtrak2/dev.permtrak.com/EspoCRM/custom/Espo/Custom/Resources/metadata/

# Rebuild EspoCRM
ssh permtrak2@permtrak.com "cd /home/permtrak2/dev.permtrak.com/EspoCRM && php command.php clear-cache && php rebuild.php"
```

---

## 🔐 **Database & Credentials**

- **Database Name:** `permtrak2_dev`
- **Database User:** `permtrak2_dev`
- **Credentials:** Stored in `espo-ctl/credentials/dev/espocrm-db.txt` (git-ignored)
- **Database Connection:** Configured in `data/config-internal.php`

---

## 🎯 **Key Custom Entities**

### **PERM Case Management (`TESTPERM`)**
The primary entity for managing PERM labor certification cases. Includes:
- Case tracking (case number, status, dates)
- Employer information
- Job details (title, duties, requirements)
- Attorney/agent information
- Advertising tracking (newspapers, radio, SWA, online)
- Financial tracking (costs, payments, invoices)
- 200+ fields total

### **Prevailing Wage Determination (`PWD`)**
Manages PWD requests and details. Includes:
- 144 fields covering all ETA 9141 form sections
- Job information (title, duties, requirements)
- Employer details
- Prevailing wage data
- BLS area, SOC code, wage levels
- Integration with Quote Builder via `pwd-extraction-view.php`

### **Media Entities**
- **News** - Main newspapers (LA Times, NY Times, etc.)
- **Local** - Local newspapers
- **Radio** - Radio stations
- **Online** - Online job boards

### **Accounting & Communications**
- **Accounting** - Financial records
- **CTransactions** - Transaction tracking
- **CCommunications** - Communication logs
- **CAcctCodes** - Account code management

### **Vendor & Domain Management**
- **CVendorMgt** - Vendor relationships
- **CDomainmgt** - Domain registration & renewal

---

## 📈 **History & Changelog**

### **2025-11-20: Initial Dev Clone**
- ✅ Cloned from sandbox to dev using `espo-clone.py`
- ✅ Updated `config-internal.php` to use `permtrak2_dev` database
- ✅ Cleared cache and rebuilt metadata
- ✅ Verified functionality
- ✅ Golden Image created: `golden-image-2025-11-20-dev-clone`

---

## 🚀 **Next Steps**

1. ✅ Dev environment is clean and ready
2. ⏳ Deploy to staging (`espo-staging`)
3. ⏳ Test staging environment
4. ⏳ Deploy to production (`espo-crm`)

---

## 🤝 **Contributing**

All changes should follow this workflow:

1. **Make changes in sandbox** (`sandbox.permtrak.com/EspoCRM`)
2. **Use Entity Manager** in EspoCRM UI (NEVER direct SQL ALTER TABLE)
3. **Export metadata** from sandbox
4. **Commit to `espo-sandbox` repo**
5. **Clone to dev** using `espo-clone.py`
6. **Test in dev** (`dev.permtrak.com/EspoCRM`)
7. **Commit to this repo** (`espo-dev`)
8. **Promote upstream** (dev → staging → production)

**⚠️ CRITICAL:** Never add database fields via SQL ALTER TABLE. Always use EspoCRM Entity Manager interface!

---

## 🔧 **EspoCRM Maintenance Commands**

### **Clear Cache**
```bash
ssh permtrak2@permtrak.com "cd /home/permtrak2/dev.permtrak.com/EspoCRM && php command.php clear-cache"
```

### **Rebuild Metadata**
```bash
ssh permtrak2@permtrak.com "cd /home/permtrak2/dev.permtrak.com/EspoCRM && php rebuild.php"
```

### **Hard Rebuild (if needed)**
```bash
ssh permtrak2@permtrak.com "cd /home/permtrak2/dev.permtrak.com/EspoCRM && php rebuild.php --hard"
```

---

## 📞 **Support & Contact**

- **Primary Documentation:** [espo-ctl/docs](https://github.com/k4rlski/espo-ctl/tree/main/docs) (3,500+ lines)
- **Deployment Tools:** [espo-ctl/scripts](https://github.com/k4rlski/espo-ctl/tree/main/scripts)
- **Issues:** Use GitHub Issues in respective repos

---

## 📄 **License**

Private repository - All rights reserved.

---

*Last Updated: 2025-11-20*  
*Environment: Development*  
*Status: ✅ Clean, Verified, Production-Ready*
