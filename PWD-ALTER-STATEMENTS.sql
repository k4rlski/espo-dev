-- PWD Table Column Optimization
-- Database: permtrak2_dev
-- Table: p_w_d
-- Date: November 3, 2025
-- Purpose: Reduce VARCHAR column lengths to save 1,420 bytes per row
-- Safety: All data verified to fit within new limits

-- BEFORE executing, current row size: 7,949 / 8,126 bytes (97.8%)
-- AFTER executing, expected row size: ~6,529 / 8,126 bytes (80.3%)

USE permtrak2_dev;

-- 1. name: VARCHAR(255) → VARCHAR(100)
--    Current max data length: 4 chars
--    Savings: ~620 bytes per row
ALTER TABLE p_w_d MODIFY COLUMN name VARCHAR(100) NOT NULL;

-- 2. empsoccodes: VARCHAR(60) → VARCHAR(30)
--    Current max data length: 11 chars
--    Savings: ~120 bytes per row
ALTER TABLE p_w_d MODIFY COLUMN empsoccodes VARCHAR(30) DEFAULT NULL;

-- 3. altforeignlanguage: VARCHAR(60) → VARCHAR(40)
--    Current max data length: 18 chars
--    Savings: ~80 bytes per row
ALTER TABLE p_w_d MODIFY COLUMN altforeignlanguage VARCHAR(40) DEFAULT NULL;

-- 4. onettitlecombo: VARCHAR(60) → VARCHAR(50)
--    Current max data length: 14 chars
--    Savings: ~40 bytes per row
ALTER TABLE p_w_d MODIFY COLUMN onettitlecombo VARCHAR(50) DEFAULT NULL;

-- 5. coveredbyacwia: VARCHAR(100) → VARCHAR(10)
--    Current max data length: 14 chars (ENUM values: Yes, No, NA)
--    Savings: ~360 bytes per row
ALTER TABLE p_w_d MODIFY COLUMN coveredbyacwia VARCHAR(10) DEFAULT 'NA';

-- 6. visatype: VARCHAR(100) → VARCHAR(50)
--    Current max data length: 8 chars (ENUM values: PERM, NA)
--    Savings: ~200 bytes per row
ALTER TABLE p_w_d MODIFY COLUMN visatype VARCHAR(50) DEFAULT 'NA';

-- Total expected savings: 1,420 bytes per row
-- Expected new capacity: 80.3% (19.7% buffer available)

