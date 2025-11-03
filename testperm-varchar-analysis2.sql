-- Check actual data lengths for VARCHAR(150) and VARCHAR(100) fields
SELECT 
    'adnumberlocal' as field,
    150 as current_size,
    MAX(LENGTH(adnumberlocal)) as max_data_length,
    GREATEST(MAX(LENGTH(adnumberlocal)) + 10, 30) as recommended_size,
    (150 - GREATEST(MAX(LENGTH(adnumberlocal)) + 10, 30)) * 4 as bytes_saved
FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'codolpin', 150, MAX(LENGTH(codolpin)), GREATEST(MAX(LENGTH(codolpin)) + 10, 30), (150 - GREATEST(MAX(LENGTH(codolpin)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'comsa', 150, MAX(LENGTH(comsa)), GREATEST(MAX(LENGTH(comsa)) + 10, 30), (150 - GREATEST(MAX(LENGTH(comsa)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'jobnaics', 150, MAX(LENGTH(jobnaics)), GREATEST(MAX(LENGTH(jobnaics)) + 10, 30), (150 - GREATEST(MAX(LENGTH(jobnaics)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'swacomment', 150, MAX(LENGTH(swacomment)), GREATEST(MAX(LENGTH(swacomment)) + 10, 30), (150 - GREATEST(MAX(LENGTH(swacomment)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'yournamefirst', 150, MAX(LENGTH(yournamefirst)), GREATEST(MAX(LENGTH(yournamefirst)) + 10, 30), (150 - GREATEST(MAX(LENGTH(yournamefirst)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'yournamelast', 150, MAX(LENGTH(yournamelast)), GREATEST(MAX(LENGTH(yournamelast)) + 10, 30), (150 - GREATEST(MAX(LENGTH(yournamelast)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'attyname', 120, MAX(LENGTH(attyname)), GREATEST(MAX(LENGTH(attyname)) + 10, 30), (120 - GREATEST(MAX(LENGTH(attyname)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'contactname', 120, MAX(LENGTH(contactname)), GREATEST(MAX(LENGTH(contactname)) + 10, 30), (120 - GREATEST(MAX(LENGTH(contactname)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'adnumbernews', 100, MAX(LENGTH(adnumbernews)), GREATEST(MAX(LENGTH(adnumbernews)) + 10, 30), (100 - GREATEST(MAX(LENGTH(adnumbernews)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'attyassistant', 100, MAX(LENGTH(attyassistant)), GREATEST(MAX(LENGTH(attyassistant)) + 10, 30), (100 - GREATEST(MAX(LENGTH(attyassistant)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'coaddress', 100, MAX(LENGTH(coaddress)), GREATEST(MAX(LENGTH(coaddress)) + 10, 30), (100 - GREATEST(MAX(LENGTH(coaddress)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'cocity', 100, MAX(LENGTH(cocity)), GREATEST(MAX(LENGTH(cocity)) + 10, 30), (100 - GREATEST(MAX(LENGTH(cocity)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'cocounty', 100, MAX(LENGTH(cocounty)), GREATEST(MAX(LENGTH(cocounty)) + 10, 30), (100 - GREATEST(MAX(LENGTH(cocounty)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'coemailcontactstandard', 100, MAX(LENGTH(coemailcontactstandard)), GREATEST(MAX(LENGTH(coemailcontactstandard)) + 10, 30), (100 - GREATEST(MAX(LENGTH(coemailcontactstandard)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'coemailpermads', 100, MAX(LENGTH(coemailpermads)), GREATEST(MAX(LENGTH(coemailpermads)) + 10, 30), (100 - GREATEST(MAX(LENGTH(coemailpermads)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'coemailpermadsloginurl', 100, MAX(LENGTH(coemailpermadsloginurl)), GREATEST(MAX(LENGTH(coemailpermadsloginurl)) + 10, 30), (100 - GREATEST(MAX(LENGTH(coemailpermadsloginurl)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'coemailpermadspass', 100, MAX(LENGTH(coemailpermadspass)), GREATEST(MAX(LENGTH(coemailpermadspass)) + 10, 30), (100 - GREATEST(MAX(LENGTH(coemailpermadspass)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'cofein', 100, MAX(LENGTH(cofein)), GREATEST(MAX(LENGTH(cofein)) + 10, 30), (100 - GREATEST(MAX(LENGTH(cofein)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'conaics', 100, MAX(LENGTH(conaics)), GREATEST(MAX(LENGTH(conaics)) + 10, 30), (100 - GREATEST(MAX(LENGTH(conaics)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'contactemail', 100, MAX(LENGTH(contactemail)), GREATEST(MAX(LENGTH(contactemail)) + 10, 30), (100 - GREATEST(MAX(LENGTH(contactemail)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'dolbkupcodes', 100, MAX(LENGTH(dolbkupcodes)), GREATEST(MAX(LENGTH(dolbkupcodes)) + 10, 30), (100 - GREATEST(MAX(LENGTH(dolbkupcodes)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'jobaddress_city', 100, MAX(LENGTH(jobaddress_city)), GREATEST(MAX(LENGTH(jobaddress_city)) + 10, 30), (100 - GREATEST(MAX(LENGTH(jobaddress_city)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'jobaddress_country', 100, MAX(LENGTH(jobaddress_country)), GREATEST(MAX(LENGTH(jobaddress_country)) + 10, 30), (100 - GREATEST(MAX(LENGTH(jobaddress_country)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'jobaddress_state', 100, MAX(LENGTH(jobaddress_state)), GREATEST(MAX(LENGTH(jobaddress_state)) + 10, 30), (100 - GREATEST(MAX(LENGTH(jobaddress_state)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'jobhours', 100, MAX(LENGTH(jobhours)), GREATEST(MAX(LENGTH(jobhours)) + 10, 30), (100 - GREATEST(MAX(LENGTH(jobhours)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'jobsiteaddress', 100, MAX(LENGTH(jobsiteaddress)), GREATEST(MAX(LENGTH(jobsiteaddress)) + 10, 30), (100 - GREATEST(MAX(LENGTH(jobsiteaddress)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'jobsitecity', 100, MAX(LENGTH(jobsitecity)), GREATEST(MAX(LENGTH(jobsitecity)) + 10, 30), (100 - GREATEST(MAX(LENGTH(jobsitecity)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'jobsitezip', 100, MAX(LENGTH(jobsitezip)), GREATEST(MAX(LENGTH(jobsitezip)) + 10, 30), (100 - GREATEST(MAX(LENGTH(jobsitezip)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'statswaemail', 100, MAX(LENGTH(statswaemail)), GREATEST(MAX(LENGTH(statswaemail)) + 10, 30), (100 - GREATEST(MAX(LENGTH(statswaemail)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'stripeinvoiceid', 100, MAX(LENGTH(stripeinvoiceid)), GREATEST(MAX(LENGTH(stripeinvoiceid)) + 10, 30), (100 - GREATEST(MAX(LENGTH(stripeinvoiceid)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'trxstring', 100, MAX(LENGTH(trxstring)), GREATEST(MAX(LENGTH(trxstring)) + 10, 30), (100 - GREATEST(MAX(LENGTH(trxstring)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'swasmartlink', 80, MAX(LENGTH(swasmartlink)), GREATEST(MAX(LENGTH(swasmartlink)) + 10, 30), (80 - GREATEST(MAX(LENGTH(swasmartlink)) + 10, 30)) * 4 FROM t_e_s_t_p_e_r_m
ORDER BY bytes_saved DESC;

