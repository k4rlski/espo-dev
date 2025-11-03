-- TESTPERM Phase 2 - Tier 3 Optimization
-- 38 fields to optimize, ~10,480 bytes savings expected

-- VARCHAR(255) fields → reduced (23 fields)
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
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxonlineend VARCHAR(180);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxradioscript VARCHAR(185);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN autoprintswa VARCHAR(185);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxradioinvoice VARCHAR(185);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxlocalts VARCHAR(185);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urlgmailadconfirm VARCHAR(190);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxnewsts1 VARCHAR(190);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxnewsts2 VARCHAR(190);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN urlqbpaylink VARCHAR(190);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxjsbpend VARCHAR(200);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxjsbpstart VARCHAR(200);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxemailthreadcase VARCHAR(205);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN dboxemailthreadswa VARCHAR(205);

-- VARCHAR(150) fields → reduced (2 fields)
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN yournamefirst VARCHAR(80);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN yournamelast VARCHAR(80);

-- VARCHAR(120) fields → reduced (1 field)
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN contactname VARCHAR(50);

-- VARCHAR(100) fields → reduced (12 fields)
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN jobaddress_state VARCHAR(30);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN conaics VARCHAR(30);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN jobaddress_city VARCHAR(30);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN attyassistant VARCHAR(30);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN statswaemail VARCHAR(30);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN jobhours VARCHAR(35);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN cocounty VARCHAR(35);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN cofein VARCHAR(35);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN stripeinvoiceid VARCHAR(40);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN coemailpermadspass VARCHAR(45);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN adnumbernews VARCHAR(50);
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN cocity VARCHAR(55);

