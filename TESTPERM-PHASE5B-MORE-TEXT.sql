-- TESTPERM Phase 5b - More TEXT Conversions (Incremental)
-- Convert additional large VARCHAR fields to TEXT
-- TEXT fields do NOT count toward the 8,126 byte row size limit

-- VARCHAR(150) fields - Name and classification fields
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN yournamefirst TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN yournamelast TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN jobnaics TEXT;

-- VARCHAR(120) fields - Attorney and contact names
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN attyname TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN contactname TEXT;

-- VARCHAR(100) fields - Contact and location details
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN adnumbernews TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN attyassistant TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN coaddress TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN cocity TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN cocounty TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN coemailcontactstandard TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN coemailpermads TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN coemailpermadspass TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN cofein TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN conaics TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN contactemail TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dolbkupcodes TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN jobaddress_city TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN jobaddress_state TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN jobhours TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN jobsiteaddress TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN jobsitecity TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN jobsitezip TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN statswaemail TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN stripeinvoiceid TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN trxstring TEXT;

