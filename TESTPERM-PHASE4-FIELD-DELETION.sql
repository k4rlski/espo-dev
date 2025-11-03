-- TESTPERM Phase 4: Delete 4 NULL/Unused Fields
-- These fields have ZERO data and are safe to remove
-- Keep domainname (user requested)

-- Drop columns from database
ALTER TABLE t_e_s_t_p_e_r_m DROP COLUMN parentid;
ALTER TABLE t_e_s_t_p_e_r_m DROP COLUMN attyfirm;
ALTER TABLE t_e_s_t_p_e_r_m DROP COLUMN coemailpermadsloginurl;
ALTER TABLE t_e_s_t_p_e_r_m DROP COLUMN jobaddress_country;

