-- TESTPERM Phase 1 Conservative - Direct SQL ALTER TABLE statements
-- These must be applied BEFORE rebuild --hard due to row size limit

-- ENUM fields (reduce from VARCHAR(255))
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN processor VARCHAR(15);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN entity VARCHAR(15);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN quotereport VARCHAR(20);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN statacctgcreditnews VARCHAR(35);

-- VARCHAR fields (reduce from VARCHAR(255))
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN name VARCHAR(150);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN attycasenumber VARCHAR(30);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN actionnotes VARCHAR(40);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN swasubacctuser VARCHAR(45);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxemailthreadnews VARCHAR(50);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urljsbp VARCHAR(130);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urlweb VARCHAR(150);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN autoprintewp VARCHAR(155);

-- VARCHAR fields (reduce from VARCHAR(150))
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN adnumberlocal VARCHAR(30);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN codolpin VARCHAR(30);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN comsa VARCHAR(30);

