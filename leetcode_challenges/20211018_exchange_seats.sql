-- Mary is a teacher in a middle school and she has a table seat storing students' names and their corresponding seat ids.

-- The column id is continuous increment.

-- Mary wants to change seats for the adjacent students.

-- Can you write a SQL query to output the result for Mary?

 

-- +---------+---------+
-- |    id   | student |
-- +---------+---------+
-- |    1    | Abbot   |
-- |    2    | Doris   |
-- |    3    | Emerson |
-- |    4    | Green   |
-- |    5    | Jeames  |
-- +---------+---------+
-- For the sample input, the output is:

-- +---------+---------+
-- |    id   | student |
-- +---------+---------+
-- |    1    | Doris   |
-- |    2    | Abbot   |
-- |    3    | Green   |
-- |    4    | Emerson |
-- |    5    | Jeames  |
-- +---------+---------+
-- Note:

-- If the number of students is odd, there is no need to change the last one's seat.

-- # Write your MySQL query statement below

with temp as (
    select 
        s1.id-1 as id, student 
    from 
        (select * from seat where id % 2 = 0) s1

    union

    select 
        s2.id+1 as id, student 
    from 
        (select * from seat where id % 2 = 1) s2
)

select 
    @i:=@i+1 as id, 
    final.student 
from 
    (select * from temp order by id) final, 
    (select @i:=0) init