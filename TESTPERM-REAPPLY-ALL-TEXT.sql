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

