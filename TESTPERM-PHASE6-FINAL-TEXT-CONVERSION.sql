-- TESTPERM Phase 6 - Final TEXT Conversions to Get Under Limit
-- Convert last 2 large VARCHAR fields to TEXT
-- Expected savings: 2,040 bytes (will bring us from 107.4% to 82.3% capacity)

-- Convert jobexperience (VARCHAR 255 → TEXT, 1,020 bytes saved)
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN jobexperience TEXT;

-- Convert jobeducation (VARCHAR 255 → TEXT, 1,020 bytes saved)
ALTER TABLE t_e_s_t_p_e_r_m MODIFY COLUMN jobeducation TEXT;

-- KEEP name as VARCHAR(150) - sensitive/important field for search/indexing
-- name remains: VARCHAR(150) = 600 bytes (acceptable)

