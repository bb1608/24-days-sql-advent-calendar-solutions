-- SQL Advent Calendar - Day 3
-- Title: The Grinch's Best Pranks Per Target
-- Difficulty: hard
--
-- Question:
-- The Grinch has brainstormed a ton of pranks for Whoville, but he only wants to keep the top prank per target, with the highest evilness score. Return the most evil prank for each target. If two pranks have the same evilness, the more recently brainstormed wins.
--
-- The Grinch has brainstormed a ton of pranks for Whoville, but he only wants to keep the top prank per target, with the highest evilness score. Return the most evil prank for each target. If two pranks have the same evilness, the more recently brainstormed wins.
--

-- Table Schema:
-- Table: grinch_prank_ideas
--   prank_id: INTEGER
--   target_name: VARCHAR
--   prank_description: VARCHAR
--   evilness_score: INTEGER
--   created_at: TIMESTAMP
--

-- My Solution:

WITH ranked_pranks AS (
  SELECT
    prank_id,
    created_at,
    target_name,
    prank_description,
    evilness_score,
    ROW_NUMBER() OVER (
      PARTITION BY target_name
      ORDER BY evilness_score DESC, created_at DESC
    ) AS rn
  FROM grinch_prank_ideas
)
SELECT
  prank_id,
  created_at,
  target_name,
  prank_description,
  evilness_score
FROM ranked_pranks
WHERE rn = 1;
