-- Table: Logs

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | num         | varchar |
-- +-------------+---------+
-- id is the primary key for this table.
 

-- Write an SQL query to find all numbers that appear at least three times consecutively.

-- Return the result table in any order.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Logs table:
-- +----+-----+
-- | Id | Num |
-- +----+-----+
-- | 1  | 1   |
-- | 2  | 1   |
-- | 3  | 1   |
-- | 4  | 2   |
-- | 5  | 1   |
-- | 6  | 2   |
-- | 7  | 2   |
-- +----+-----+
-- Output: 
-- +-----------------+
-- | ConsecutiveNums |
-- +-----------------+
-- | 1               |
-- +-----------------+
-- Explanation: 1 is the only number that appears consecutively for at least three times.

-- # three tables for three consecutive numbers
-- # where 3 ids are matched as moving through each row
-- # l1 (1) = l2 (2{-1})
-- # l2 (2) = l3 (3{-1})

select distinct l1.Num as ConsecutiveNums
    from Logs l1, Logs l2, Logs l3
where 
    l1.Id = l2.Id - 1 and 
    l2.Id = l3.Id - 1 and 
    l1.Num = l2.Num and 
    l2.Num = l3.Num;

-- # left join method
select L.Num as ConsecutiveNums
from
(select distinct A.Num 
from Logs A
 left join Logs B on A.Id = B.Id - 1
 left join Logs C on B.Id = C.Id - 1
where
 A.Num = B.Num and B.Num = C.Num
) L;

-- where in method
-- but if there's a gap in database, the method falls short
select distinct Num as ConsecutiveNums
from Logs
where (Id + 1, Num) in (select * from Logs) and (Id + 2, Num) in (select * from Logs);