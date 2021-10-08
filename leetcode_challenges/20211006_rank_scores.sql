-- Table: Scores

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | Id          | int     |
-- | Score       | decimal |
-- +-------------+---------+
-- Id is the primary key for this table.
-- Each row of this table contains the score of a game. Score is a floating point value with two decimal places.
 

-- Write an SQL query to rank the scores. The ranking should be calculated according to the following rules:

-- The scores should be ranked from the highest to the lowest.
-- If there is a tie between two scores, both should have the same ranking.
-- After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
-- Return the result table ordered by score in descending order.

-- The query result format is in the following example.

-- # final columns [Score, Rank]
-- # Score should be unique values
-- # table s is as original Scores table
-- # another table is comparing unique list of score to each row of score
-- # for (id: 1, score: 3.5) => 3.4,3.5,2.0 => 3
-- # and this is returned as column named `Rank` where Rank has to be in quotes as it's reserved keyword

select Score, 
    (select count(distinct Score) from Scores 
     where Score >= s.Score) as `Rank`
from Scores as s
order by Score desc