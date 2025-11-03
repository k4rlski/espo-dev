-- TESTPERM Phase 5a - More TEXT Conversions
-- Convert large VARCHAR fields to TEXT to save ~5,000 bytes
-- TEXT fields do NOT count toward the 8,126 byte row size limit

-- Large VARCHAR(255) fields - candidates for TEXT
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN jobtitle TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN jobaddress_street TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN swasubacctpass TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN domainname TEXT;

-- VARCHAR(150) fields that are at/near capacity
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN swacomment TEXT;

-- Name fields (could be kept as VARCHAR if preferred)
-- ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN yournamefirst TEXT;
-- ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN yournamelast TEXT;

