-- Check actual data lengths for VARCHAR(255) text fields
SELECT 
    'name' as field,
    255 as current_size,
    MAX(LENGTH(name)) as max_data_length,
    MAX(LENGTH(name)) + 10 as recommended_size,
    (255 - (MAX(LENGTH(name)) + 10)) * 4 as bytes_saved
FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'jobtitle', 255, MAX(LENGTH(jobtitle)), MAX(LENGTH(jobtitle)) + 10, (255 - (MAX(LENGTH(jobtitle)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'jobexperience', 255, MAX(LENGTH(jobexperience)), MAX(LENGTH(jobexperience)) + 10, (255 - (MAX(LENGTH(jobexperience)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'jobeducation', 255, MAX(LENGTH(jobeducation)), MAX(LENGTH(jobeducation)) + 10, (255 - (MAX(LENGTH(jobeducation)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'attyfirm', 255, MAX(LENGTH(attyfirm)), MAX(LENGTH(attyfirm)) + 10, (255 - (MAX(LENGTH(attyfirm)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'attycasenumber', 255, MAX(LENGTH(attycasenumber)), MAX(LENGTH(attycasenumber)) + 10, (255 - (MAX(LENGTH(attycasenumber)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'entity', 255, MAX(LENGTH(entity)), MAX(LENGTH(entity)) + 10, (255 - (MAX(LENGTH(entity)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'domainname', 255, MAX(LENGTH(domainname)), MAX(LENGTH(domainname)) + 10, (255 - (MAX(LENGTH(domainname)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'processor', 255, MAX(LENGTH(processor)), MAX(LENGTH(processor)) + 10, (255 - (MAX(LENGTH(processor)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'actionnotes', 255, MAX(LENGTH(actionnotes)), MAX(LENGTH(actionnotes)) + 10, (255 - (MAX(LENGTH(actionnotes)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'quotereport', 255, MAX(LENGTH(quotereport)), MAX(LENGTH(quotereport)) + 10, (255 - (MAX(LENGTH(quotereport)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'parentid', 255, MAX(LENGTH(parentid)), MAX(LENGTH(parentid)) + 10, (255 - (MAX(LENGTH(parentid)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'jobaddress_street', 255, MAX(LENGTH(jobaddress_street)), MAX(LENGTH(jobaddress_street)) + 10, (255 - (MAX(LENGTH(jobaddress_street)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'urlweb', 255, MAX(LENGTH(urlweb)), MAX(LENGTH(urlweb)) + 10, (255 - (MAX(LENGTH(urlweb)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'urljsbp', 255, MAX(LENGTH(urljsbp)), MAX(LENGTH(urljsbp)) + 10, (255 - (MAX(LENGTH(urljsbp)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'urlonline', 255, MAX(LENGTH(urlonline)), MAX(LENGTH(urlonline)) + 10, (255 - (MAX(LENGTH(urlonline)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'urlswa', 255, MAX(LENGTH(urlswa)), MAX(LENGTH(urlswa)) + 10, (255 - (MAX(LENGTH(urlswa)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'urlqbpaylink', 255, MAX(LENGTH(urlqbpaylink)), MAX(LENGTH(urlqbpaylink)) + 10, (255 - (MAX(LENGTH(urlqbpaylink)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'urltrxmercury', 255, MAX(LENGTH(urltrxmercury)), MAX(LENGTH(urltrxmercury)) + 10, (255 - (MAX(LENGTH(urltrxmercury)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'urlgmailadconfirm', 255, MAX(LENGTH(urlgmailadconfirm)), MAX(LENGTH(urlgmailadconfirm)) + 10, (255 - (MAX(LENGTH(urlgmailadconfirm)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'stripepaymentlink', 255, MAX(LENGTH(stripepaymentlink)), MAX(LENGTH(stripepaymentlink)) + 10, (255 - (MAX(LENGTH(stripepaymentlink)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'autoprintewp', 255, MAX(LENGTH(autoprintewp)), MAX(LENGTH(autoprintewp)) + 10, (255 - (MAX(LENGTH(autoprintewp)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'autoprintjsbp', 255, MAX(LENGTH(autoprintjsbp)), MAX(LENGTH(autoprintjsbp)) + 10, (255 - (MAX(LENGTH(autoprintjsbp)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'autoprintonline', 255, MAX(LENGTH(autoprintonline)), MAX(LENGTH(autoprintonline)) + 10, (255 - (MAX(LENGTH(autoprintonline)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'autoprintswa', 255, MAX(LENGTH(autoprintswa)), MAX(LENGTH(autoprintswa)) + 10, (255 - (MAX(LENGTH(autoprintswa)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'swasubacctuser', 255, MAX(LENGTH(swasubacctuser)), MAX(LENGTH(swasubacctuser)) + 10, (255 - (MAX(LENGTH(swasubacctuser)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'swasubacctpass', 255, MAX(LENGTH(swasubacctpass)), MAX(LENGTH(swasubacctpass)) + 10, (255 - (MAX(LENGTH(swasubacctpass)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'statacctgcreditnews', 255, MAX(LENGTH(statacctgcreditnews)), MAX(LENGTH(statacctgcreditnews)) + 10, (255 - (MAX(LENGTH(statacctgcreditnews)) + 10)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'dboxemailthreadcase', 255, MAX(LENGTH(dboxemailthreadcase)), GREATEST(MAX(LENGTH(dboxemailthreadcase)) + 10, 50), (255 - GREATEST(MAX(LENGTH(dboxemailthreadcase)) + 10, 50)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'dboxemailthreadnews', 255, MAX(LENGTH(dboxemailthreadnews)), GREATEST(MAX(LENGTH(dboxemailthreadnews)) + 10, 50), (255 - GREATEST(MAX(LENGTH(dboxemailthreadnews)) + 10, 50)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'dboxemailthreadswa', 255, MAX(LENGTH(dboxemailthreadswa)), GREATEST(MAX(LENGTH(dboxemailthreadswa)) + 10, 50), (255 - GREATEST(MAX(LENGTH(dboxemailthreadswa)) + 10, 50)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'dboxewpstart', 255, MAX(LENGTH(dboxewpstart)), GREATEST(MAX(LENGTH(dboxewpstart)) + 10, 50), (255 - GREATEST(MAX(LENGTH(dboxewpstart)) + 10, 50)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'dboxewpend', 255, MAX(LENGTH(dboxewpend)), GREATEST(MAX(LENGTH(dboxewpend)) + 10, 50), (255 - GREATEST(MAX(LENGTH(dboxewpend)) + 10, 50)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'dboxjsbpstart', 255, MAX(LENGTH(dboxjsbpstart)), GREATEST(MAX(LENGTH(dboxjsbpstart)) + 10, 50), (255 - GREATEST(MAX(LENGTH(dboxjsbpstart)) + 10, 50)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'dboxjsbpend', 255, MAX(LENGTH(dboxjsbpend)), GREATEST(MAX(LENGTH(dboxjsbpend)) + 10, 50), (255 - GREATEST(MAX(LENGTH(dboxjsbpend)) + 10, 50)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'dboxonlinestart', 255, MAX(LENGTH(dboxonlinestart)), GREATEST(MAX(LENGTH(dboxonlinestart)) + 10, 50), (255 - GREATEST(MAX(LENGTH(dboxonlinestart)) + 10, 50)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'dboxonlineend', 255, MAX(LENGTH(dboxonlineend)), GREATEST(MAX(LENGTH(dboxonlineend)) + 10, 50), (255 - GREATEST(MAX(LENGTH(dboxonlineend)) + 10, 50)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'dboxswastart', 255, MAX(LENGTH(dboxswastart)), GREATEST(MAX(LENGTH(dboxswastart)) + 10, 50), (255 - GREATEST(MAX(LENGTH(dboxswastart)) + 10, 50)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'dboxswaend', 255, MAX(LENGTH(dboxswaend)), GREATEST(MAX(LENGTH(dboxswaend)) + 10, 50), (255 - GREATEST(MAX(LENGTH(dboxswaend)) + 10, 50)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'dboxlocalts', 255, MAX(LENGTH(dboxlocalts)), GREATEST(MAX(LENGTH(dboxlocalts)) + 10, 50), (255 - GREATEST(MAX(LENGTH(dboxlocalts)) + 10, 50)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'dboxnewsts1', 255, MAX(LENGTH(dboxnewsts1)), GREATEST(MAX(LENGTH(dboxnewsts1)) + 10, 50), (255 - GREATEST(MAX(LENGTH(dboxnewsts1)) + 10, 50)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'dboxnewsts2', 255, MAX(LENGTH(dboxnewsts2)), GREATEST(MAX(LENGTH(dboxnewsts2)) + 10, 50), (255 - GREATEST(MAX(LENGTH(dboxnewsts2)) + 10, 50)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'dboxradioinvoice', 255, MAX(LENGTH(dboxradioinvoice)), GREATEST(MAX(LENGTH(dboxradioinvoice)) + 10, 50), (255 - GREATEST(MAX(LENGTH(dboxradioinvoice)) + 10, 50)) * 4 FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'dboxradioscript', 255, MAX(LENGTH(dboxradioscript)), GREATEST(MAX(LENGTH(dboxradioscript)) + 10, 50), (255 - GREATEST(MAX(LENGTH(dboxradioscript)) + 10, 50)) * 4 FROM t_e_s_t_p_e_r_m
ORDER BY bytes_saved DESC;

