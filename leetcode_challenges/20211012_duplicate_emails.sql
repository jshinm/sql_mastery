-- Table: Person

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | Id          | int     |
-- | Email       | varchar |
-- +-------------+---------+
-- Id is the primary key column for this table.
-- Each row of this table contains an email. The emails will not contain uppercase letters.
 

-- Write an SQL query to report all the duplicate emails.

-- Return the result table in any order.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Person table:
-- +----+---------+
-- | Id | Email   |
-- +----+---------+
-- | 1  | a@b.com |
-- | 2  | c@d.com |
-- | 3  | a@b.com |
-- +----+---------+
-- Output: 
-- +---------+
-- | Email   |
-- +---------+
-- | a@b.com |
-- +---------+
-- Explanation: a@b.com is repeated two times.

-- # Write your MySQL query statement below
-- # Count the group by values, then filter out i = 1
select p.Email 
    from 
    (select p.Email, count(p.Email) as `Count`
     from Person p 
     group by Email
    ) p
where p.Count > 1;

-- #group by and having method
select Email
from Person
group by Email
having count(Email) > 1;