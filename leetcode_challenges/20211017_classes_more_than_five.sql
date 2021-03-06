-- There is a table courses with columns: student and class

-- Please list out all classes which have more than or equal to 5 students.

-- For example, the table:

-- +---------+------------+
-- | student | class      |
-- +---------+------------+
-- | A       | Math       |
-- | B       | English    |
-- | C       | Math       |
-- | D       | Biology    |
-- | E       | Math       |
-- | F       | Computer   |
-- | G       | Math       |
-- | H       | Math       |
-- | I       | Math       |
-- +---------+------------+
-- Should output:

-- +---------+
-- | class   |
-- +---------+
-- | Math    |
-- +---------+
 

-- Note:
-- The students should not be counted duplicate in each course.
select 
    t.class 
from 
    (select dt.class, count(dt.class) from  -- this didn't have to be double queries by replacing count with count(distinct class)
        (select distinct * from courses) as dt -- #removing duplicates
    group by dt.class
    ) as t
where 
    `count(dt.class)` > 4 --this could have been under HAVING followed by GROUP BY