-- PWD ENUM Fields Optimization
-- Reducing VARCHAR(255) to appropriate sizes for ENUM storage
-- Date: November 3, 2025

USE permtrak2_dev;

-- 1. statcase (values: "", "Pending", "Certified", "Denied", "Withdrawn")
--    Longest: "Withdrawn" = 9 chars → VARCHAR(15)
ALTER TABLE p_w_d MODIFY COLUMN statcase VARCHAR(15) DEFAULT NULL;

-- 2. visaclass (values: "", "H-1B", "H-1B1", "E-3", "PERM", "Other")
--    Longest: "H-1B1" = 5 chars → VARCHAR(10)
ALTER TABLE p_w_d MODIFY COLUMN visaclass VARCHAR(10) DEFAULT NULL;

-- 3. typeofrep (values: "", "Attorney", "Agent", "Self", "None")
--    Longest: "Attorney" = 8 chars → VARCHAR(10)
ALTER TABLE p_w_d MODIFY COLUMN typeofrep VARCHAR(10) DEFAULT NULL;

-- 4-14. All Yes/No fields (values: "", "Yes", "No")
--       Longest: "Yes"/"No" = 3 chars → VARCHAR(5)
ALTER TABLE p_w_d MODIFY COLUMN statacwiachanged VARCHAR(5) DEFAULT NULL;
ALTER TABLE p_w_d MODIFY COLUMN profsportsleague VARCHAR(5) DEFAULT NULL;
ALTER TABLE p_w_d MODIFY COLUMN supervise_other_emp VARCHAR(5) DEFAULT NULL;
ALTER TABLE p_w_d MODIFY COLUMN secondeducation VARCHAR(5) DEFAULT NULL;
ALTER TABLE p_w_d MODIFY COLUMN requiredtraining VARCHAR(5) DEFAULT NULL;
ALTER TABLE p_w_d MODIFY COLUMN requiredexperience VARCHAR(5) DEFAULT NULL;
ALTER TABLE p_w_d MODIFY COLUMN alttraining VARCHAR(5) DEFAULT NULL;
ALTER TABLE p_w_d MODIFY COLUMN altexperience VARCHAR(5) DEFAULT NULL;
ALTER TABLE p_w_d MODIFY COLUMN travelrequired VARCHAR(5) DEFAULT NULL;

-- 15. wagesourcerequested (values: "", "OES", "CBA", "Other", "Employer Survey")
--     Longest: "Employer Survey" = 15 chars → VARCHAR(20)
ALTER TABLE p_w_d MODIFY COLUMN wagesourcerequested VARCHAR(20) DEFAULT NULL;

-- 16. requirededucationlevel (values: "", "None", "High School", "Associate", "Bachelor", "Master", "Doctorate", "Professional")
--     Longest: "Professional" = 12 chars → VARCHAR(15)
ALTER TABLE p_w_d MODIFY COLUMN requirededucationlevel VARCHAR(15) DEFAULT NULL;

-- Expected byte savings per row:
-- 11 fields: (255 - 5) * 4 = 1,000 bytes each = 11,000 bytes
-- 2 fields: (255 - 10) * 4 = 980 bytes each = 1,960 bytes
-- 1 field: (255 - 15) * 4 = 960 bytes each = 960 bytes
-- 1 field: (255 - 15) * 4 = 960 bytes each = 960 bytes
-- 1 field: (255 - 20) * 4 = 940 bytes each = 940 bytes
-- TOTAL SAVINGS: ~15,820 bytes per row!

-- Note: statcase was already optimized to VARCHAR(20) earlier but rebuild reset it

