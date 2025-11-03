-- TESTPERM Phase 3 - TEXT Conversion
-- Convert 28 large VARCHAR fields to TEXT to free ~22,000 bytes from row size
-- TEXT fields do NOT count toward the 8,126 byte row size limit

-- Category 1: URL Fields (8 fields)
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urlweb TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urljsbp TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urlonline TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urlswa TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urlqbpaylink TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urltrxmercury TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urlgmailadconfirm TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN stripepaymentlink TEXT;

-- Category 2: Dropbox ID Fields (16 fields)
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxemailthreadcase TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxemailthreadnews TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxemailthreadswa TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxewpstart TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxewpend TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxjsbpstart TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxjsbpend TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxonlinestart TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxonlineend TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxswastart TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxswaend TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxlocalts TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxnewsts1 TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxnewsts2 TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxradioinvoice TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxradioscript TEXT;

-- Category 3: Autoprint Path Fields (4 fields)
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN autoprintewp TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN autoprintjsbp TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN autoprintonline TEXT;
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN autoprintswa TEXT;

