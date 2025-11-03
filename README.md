# espo-dev

**EspoCRM Metadata Repository - DEV Environment**

Version-controlled metadata for EspoCRM entities, fields, and configurations.

---

## Repository Purpose

This repository contains the **metadata JSON files** that define EspoCRM entities, fields, and business logic. By managing these files in Git, we can:

- ✅ **Version control** entity definitions
- ✅ **Edit JSON directly** instead of using Entity Manager GUI
- ✅ **Optimize MySQL field types** (dbType, len overrides)
- ✅ **Track changes** over time
- ✅ **Rollback** to previous versions if needed
- ✅ **Collaborate** with detailed commit history

---

## Current Status

**Environment:** `dev.permtrak.com`  
**EspoCRM Version:** 9.2.4  
**PHP Version:** 8.2.29  
**Last Updated:** 2025-11-03

**Contents:**
- **34 Entity Definitions** (entityDefs/)
- **25 Scope Configurations** (scopes/)
- **25 Client Definitions** (clientDefs/)
- **25 Record Definitions** (recordDefs/)

**Total:** 110 files, 9,574 lines of JSON

---

## Directory Structure

```
metadata/
├── entityDefs/          # Entity field definitions & MySQL schema
│   ├── SWA.json        # PERM Case entity
│   ├── TESTPERM.json   # Labor Certification entity
│   ├── PWD.json        # Prevailing Wage entity
│   └── ...             # 31 more entities
│
├── scopes/             # Entity-level settings (tab visibility, ACL)
├── clientDefs/         # Frontend behavior (forms, modals)
├── recordDefs/         # Business logic (validation, hooks)
└── .gitignore          # Excludes temp files
```

---

## Key Entities

### PERM Labor Certification System
- **SWA** - State Workforce Agency cases
- **TESTPERM** - PERM labor certification cases
- **PWD** - Prevailing Wage Determinations
- **Radio** - Radio stations for recruitment ads
- **Local** - Locals/unions
- **News** - Newspapers for print ads
- **CCommunications** - Communication tracking

### Custom Business Entities
- **Accounting** - Financial tracking
- **CTransactions** - Transaction records
- **CStripetrx** - Stripe payment transactions
- **Expenses** - Expense tracking
- **Tools** - Tools/utilities

### Standard EspoCRM Entities
- **Account, Contact, Lead** - CRM basics
- **Call, Meeting, Task, Email** - Activities
- **Document** - Document management

---

## Workflow

### Making Changes

**1. Edit Locally:**
```bash
cd /path/to/espo-dev
# Edit JSON files (e.g., entityDefs/SWA.json)
```

**2. Commit Changes:**
```bash
git add entityDefs/SWA.json
git commit -m "Optimize SWA.status field: VARCHAR(255) → VARCHAR(20)"
git push origin main
```

**3. Deploy to Server:**
```bash
# Copy to server
scp -r . permtrak2@permtrak.com:/home/permtrak2/dev.permtrak.com/EspoCRM/custom/Espo/Custom/Resources/metadata/

# SSH to server and rebuild
ssh permtrak2@permtrak.com
cd /home/permtrak2/dev.permtrak.com/EspoCRM
php command.php clear-cache
php rebuild.php
```

**4. Verify:**
```bash
# Check MySQL schema
mysql -u user -p database -e "SHOW CREATE TABLE entity_name;"

# Test in web interface
# https://dev.permtrak.com/EspoCRM/
```

---

## MySQL Optimization

### Current State
All entities use **EspoCRM defaults** (often wasteful):
- VARCHAR fields: `VARCHAR(255)` by default
- Text fields: `TEXT` (65KB)
- Integer fields: `INT` (4 bytes)
- Float fields: `DOUBLE` (8 bytes)

### Optimization Strategy

**Add `dbType` and `len` to field definitions:**

**Before:**
```json
{
  "status": {
    "type": "enum",
    "options": ["New", "Active", "Complete"]
  }
}
```

**After:**
```json
{
  "status": {
    "type": "enum",
    "options": ["New", "Active", "Complete"],
    "dbType": "varchar",
    "len": 20
  }
}
```

**Result:**
- MySQL: `VARCHAR(255)` → `VARCHAR(20)`
- Savings: 235 bytes per record
- Index size: Significantly reduced

### Common Optimizations

| EspoCRM Type | Default MySQL | Optimized | Savings |
|--------------|---------------|-----------|---------|
| varchar | VARCHAR(255) | VARCHAR(20-100) | 155-235 bytes |
| text | TEXT (65KB) | VARCHAR(500-2000) | ~65KB |
| int | INT (4 bytes) | TINYINT (1 byte) | 3 bytes |
| float | DOUBLE (8 bytes) | DECIMAL(10,2) | 5 bytes |

**For detailed guide, see:** [EspoCRM Metadata MySQL Optimization Guide](https://github.com/k4rlski/espo-ctl/blob/main/markdown/EspoCRM_Metadata_MySQL_Optimization_Guide.md)

---

## Important Notes

### ⚠️ Always Test First
1. Make changes in DEV (this repo)
2. Deploy to dev.permtrak.com
3. Test thoroughly
4. Deploy to PROD only after validation

### 🔄 After JSON Changes
**Always rebuild EspoCRM:**
```bash
cd /home/permtrak2/dev.permtrak.com/EspoCRM
php command.php clear-cache
php rebuild.php
```

### 🚫 Never Edit These Files Directly on Server
- Edit locally
- Commit to Git
- Deploy to server
- **Git is the source of truth**

### ⚠️ Stale Browser Cache
After metadata changes, clear browser cache:
- Hard refresh: `Ctrl+F5` (Windows/Linux) or `Cmd+Shift+R` (Mac)
- Or: Clear cache via browser settings

---

## Related Tools

### [espo-ctl](https://github.com/k4rlski/espo-ctl)
Automation toolkit for EspoCRM management:
- **espo-clone-local.py** - Clone PROD → DEV
- **db-update.py** - Sync database only
- **espo-smart-update.py** - Update EspoCRM versions

### [espo-prod](https://github.com/k4rlski/espo-prod)
Production metadata repository (deploy after DEV testing)

---

## Field Type Reference

### Supported dbType Values
- `varchar` - Variable length string (requires `len`)
- `text` - Large text (no len needed)
- `mediumtext` - Larger text (16MB)
- `longtext` - Huge text (4GB)
- `tinyint` - Small integer (-128 to 127, or 0-255 unsigned)
- `smallint` - Medium integer (-32K to 32K)
- `int` - Standard integer
- `bigint` - Large integer
- `decimal(M,D)` - Fixed-point decimal (e.g., `decimal(10,2)`)
- `float` - Floating point (4 bytes)
- `double` - Double precision (8 bytes)
- `date` - Date only
- `datetime` - Date and time
- `timestamp` - Auto-updating timestamp

---

## Troubleshooting

### Changes Not Appearing
```bash
# Clear ALL caches
cd /home/permtrak2/dev.permtrak.com/EspoCRM
rm -rf data/cache/*
php command.php clear-cache
php rebuild.php

# Clear browser cache
# Hard refresh: Ctrl+F5
```

### Rebuild Fails
```bash
# Check logs
tail -100 data/logs/espo-$(date +%Y-%m-%d).log

# Common issues:
# - Invalid JSON syntax
# - Missing required fields
# - MySQL row size exceeded (see optimization guide)
```

### Metadata Reverted
- **Cause:** Stale browser cache in Entity Manager
- **Fix:** Always edit JSON files, never use Entity Manager GUI
- **Prevention:** Document changes in Git commits

---

## Backup & Recovery

### Rollback to Previous Version
```bash
# View history
git log --oneline

# Revert to specific commit
git checkout abc1234 -- entityDefs/SWA.json
git commit -m "Revert SWA.json to known good version"
git push origin main

# Deploy to server
scp entityDefs/SWA.json permtrak2@permtrak.com:/path/to/metadata/entityDefs/
# Then rebuild
```

### Emergency Recovery
```bash
# Server has backups at:
/home/permtrak2/backups/espo-updates/

# Restore from backup
cd /home/permtrak2/dev.permtrak.com/EspoCRM
rm -rf custom/Espo/Custom/Resources/metadata/*
tar -xzf /home/permtrak2/backups/espo-updates/backup-file.tar.gz
php rebuild.php
```

---

## Best Practices

1. **One entity per commit** - Makes reverts easier
2. **Descriptive commit messages** - Explain WHY, not just WHAT
3. **Test before deploying** - Use dev.permtrak.com first
4. **Document optimizations** - Note savings and rationale
5. **Backup before major changes** - Use espo-clone-local.py
6. **Never skip rebuild** - Required after metadata changes
7. **Monitor MySQL logs** - Check for schema errors
8. **Use branches for experiments** - Test risky changes safely

---

## Metrics

### Storage Optimization Potential
Current state: **EspoCRM defaults (unoptimized)**

**Example (SWA entity):**
- Current: ~65KB per record (with defaults)
- Optimized: ~1-2KB per record
- With 10,000 records: **650MB → 20MB** (97% reduction)

**Next Steps:**
1. Analyze current field usage
2. Identify optimization opportunities
3. Apply dbType/len overrides
4. Test and measure actual savings

---

## Contributing

This repository is for EspoCRM metadata management.

**Workflow:**
1. Create feature branch: `git checkout -b optimize/swa-entity`
2. Make changes
3. Commit with detailed message
4. Push and test on dev.permtrak.com
5. Merge to main after validation

---

## License

Proprietary - Internal use only

---

## Contact

**Repository:** https://github.com/k4rlski/espo-dev  
**Related:** https://github.com/k4rlski/espo-ctl  
**Environment:** dev.permtrak.com

**Last Updated:** 2025-11-03  
**EspoCRM Version:** 9.2.4  
**Status:** ✅ Operational

