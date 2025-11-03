-- Pre-deployment safety verification for Phase 1 fields
SELECT 
    'processor' as field,
    255 as current_size,
    15 as proposed_size,
    MAX(LENGTH(processor)) as max_actual_data,
    15 - MAX(LENGTH(processor)) as buffer_chars,
    CASE 
        WHEN MAX(LENGTH(processor)) <= 15 THEN '✅ SAFE'
        ELSE '⚠️ WOULD TRUNCATE'
    END as safety_status
FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'entity', 255, 15, MAX(LENGTH(entity)), 15 - MAX(LENGTH(entity)), CASE WHEN MAX(LENGTH(entity)) <= 15 THEN '✅ SAFE' ELSE '⚠️ WOULD TRUNCATE' END FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'quotereport', 255, 20, MAX(LENGTH(quotereport)), 20 - MAX(LENGTH(quotereport)), CASE WHEN MAX(LENGTH(quotereport)) <= 20 THEN '✅ SAFE' ELSE '⚠️ WOULD TRUNCATE' END FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'attycasenumber', 255, 30, MAX(LENGTH(attycasenumber)), 30 - MAX(LENGTH(attycasenumber)), CASE WHEN MAX(LENGTH(attycasenumber)) <= 30 THEN '✅ SAFE' ELSE '⚠️ WOULD TRUNCATE' END FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'statacctgcreditnews', 255, 30, MAX(LENGTH(statacctgcreditnews)), 30 - MAX(LENGTH(statacctgcreditnews)), CASE WHEN MAX(LENGTH(statacctgcreditnews)) <= 30 THEN '✅ SAFE' ELSE '⚠️ WOULD TRUNCATE' END FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'actionnotes', 255, 40, MAX(LENGTH(actionnotes)), 40 - MAX(LENGTH(actionnotes)), CASE WHEN MAX(LENGTH(actionnotes)) <= 40 THEN '✅ SAFE' ELSE '⚠️ WOULD TRUNCATE' END FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'swasubacctuser', 255, 45, MAX(LENGTH(swasubacctuser)), 45 - MAX(LENGTH(swasubacctuser)), CASE WHEN MAX(LENGTH(swasubacctuser)) <= 45 THEN '✅ SAFE' ELSE '⚠️ WOULD TRUNCATE' END FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'dboxemailthreadnews', 255, 50, MAX(LENGTH(dboxemailthreadnews)), 50 - MAX(LENGTH(dboxemailthreadnews)), CASE WHEN MAX(LENGTH(dboxemailthreadnews)) <= 50 THEN '✅ SAFE' ELSE '⚠️ WOULD TRUNCATE' END FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'jobaddress_street', 255, 70, MAX(LENGTH(jobaddress_street)), 70 - MAX(LENGTH(jobaddress_street)), CASE WHEN MAX(LENGTH(jobaddress_street)) <= 70 THEN '✅ SAFE' ELSE '⚠️ WOULD TRUNCATE' END FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'urljsbp', 255, 125, MAX(LENGTH(urljsbp)), 125 - MAX(LENGTH(urljsbp)), CASE WHEN MAX(LENGTH(urljsbp)) <= 125 THEN '✅ SAFE' ELSE '⚠️ WOULD TRUNCATE' END FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'adnumberlocal', 150, 30, MAX(LENGTH(adnumberlocal)), 30 - MAX(LENGTH(adnumberlocal)), CASE WHEN MAX(LENGTH(adnumberlocal)) <= 30 THEN '✅ SAFE' ELSE '⚠️ WOULD TRUNCATE' END FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'codolpin', 150, 30, MAX(LENGTH(codolpin)), 30 - MAX(LENGTH(codolpin)), CASE WHEN MAX(LENGTH(codolpin)) <= 30 THEN '✅ SAFE' ELSE '⚠️ WOULD TRUNCATE' END FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'comsa', 150, 30, MAX(LENGTH(comsa)), 30 - MAX(LENGTH(comsa)), CASE WHEN MAX(LENGTH(comsa)) <= 30 THEN '✅ SAFE' ELSE '⚠️ WOULD TRUNCATE' END FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'name', 255, 145, MAX(LENGTH(name)), 145 - MAX(LENGTH(name)), CASE WHEN MAX(LENGTH(name)) <= 145 THEN '✅ SAFE' ELSE '⚠️ WOULD TRUNCATE' END FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'urlweb', 255, 145, MAX(LENGTH(urlweb)), 145 - MAX(LENGTH(urlweb)), CASE WHEN MAX(LENGTH(urlweb)) <= 145 THEN '✅ SAFE' ELSE '⚠️ WOULD TRUNCATE' END FROM t_e_s_t_p_e_r_m
UNION ALL SELECT 'autoprintewp', 255, 150, MAX(LENGTH(autoprintewp)), 150 - MAX(LENGTH(autoprintewp)), CASE WHEN MAX(LENGTH(autoprintewp)) <= 150 THEN '✅ SAFE' ELSE '⚠️ WOULD TRUNCATE' END FROM t_e_s_t_p_e_r_m
ORDER BY buffer_chars ASC;

