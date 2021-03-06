-- There is a table World

-- +-----------------+------------+------------+--------------+---------------+
-- | name            | continent  | area       | population   | gdp           |
-- +-----------------+------------+------------+--------------+---------------+
-- | Afghanistan     | Asia       | 652230     | 25500100     | 20343000      |
-- | Albania         | Europe     | 28748      | 2831741      | 12960000      |
-- | Algeria         | Africa     | 2381741    | 37100000     | 188681000     |
-- | Andorra         | Europe     | 468        | 78115        | 3712000       |
-- | Angola          | Africa     | 1246700    | 20609294     | 100990000     |
-- +-----------------+------------+------------+--------------+---------------+
-- A country is big if it has an area of bigger than 3 million square km or a population of more than 25 million.

-- Write a SQL solution to output big countries' name, population and area.

-- For example, according to the above table, we should output:

-- +--------------+-------------+--------------+
-- | name         | population  | area         |
-- +--------------+-------------+--------------+
-- | Afghanistan  | 25500100    | 652230       |
-- | Algeria      | 37100000    | 2381741      |
-- +--------------+-------------+--------------+

-- # Write your MySQL query statement below
select name, population, area 
from World
where
area > 3000000 or
population > 25000000;

-- union method 
-- the order of TC is union all > union > or
-- between union all and union, the former is faster as it doesn't require sorting after joining
select name, population, area
from World
where
area > 3000000

union

select name, population, area 
-- initially didn't add all three columns for two tables. 
-- For union, there must be the same number of columns for joining AND the matching columns for union to work properly
from World
where
population > 25000000;