-- TESTPERM Phase 2 - Batch 1 (Biggest savings first - 10 fields)
-- Apply most impactful reductions first to create breathing room

ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN jobexperience VARCHAR(165);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN jobeducation VARCHAR(165);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN autoprintjsbp VARCHAR(170);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN autoprintonline VARCHAR(170);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxewpstart VARCHAR(170);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxewpend VARCHAR(170);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN stripepaymentlink VARCHAR(170);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxswastart VARCHAR(180);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxonlinestart VARCHAR(180);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urltrxmercury VARCHAR(180);

