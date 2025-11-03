-- Fix FULLTEXT index by reducing jobtitle size
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN jobtitle VARCHAR(165);

-- Recreate the FULLTEXT index with smaller columns
ALTER TABLE t_e_s_t_p_e_r_m ADD FULLTEXT INDEX IDX_SYSTEM_FULL_TEXT_SEARCH (name, jobtitle, adnumbernews);

