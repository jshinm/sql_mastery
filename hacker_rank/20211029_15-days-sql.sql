-- Julia conducted a 15 days of learning SQL contest. The start date of the contest was March 01, 2016 and the end date was March 15, 2016.

-- Write a query to print total number of unique hackers who made at least 1 submission each day (starting on the first day of the contest), 
-- and find the hacker_id and name of the hacker who made maximum number of submissions each day. If more than one such hacker has a maximum number of submissions, 
-- print the lowest hacker_id. The query should print this information for each day of the contest, sorted by the date.

-- total count only accounts for consecutive submission
-- highest count accounts for every submission for that day
-- pick the lowest # hacker_id when there are two most submissions
-- select only hacker_id that started from the contest begin date (3-1-2016)

-- there's slight discrepency with total count possibly over-counting from day=rnk conditional

select tbl1.submission_date, tbl1.mx, tbl2.hacker_id, tbl2.name from (

select * -- table for highest count each day 
from (
select submission_date
, max(rnk) over (partition by submission_date) mx
, row_number() over (partition by submission_date order by submission_date) rn
from (
select submission_date, submission_id, hacker_id, score,
rank() over (partition by submission_date order by hacker_id) rnk -- table for consecutive submission
from (
select s2.* -- , day(s2.submission_date) day
, datediff(day, '2016-02-29',submission_date) day
, dense_rank() over (partition by s2.hacker_id order by s2.submission_date) rnk
, count(*) over (partition by s2.submission_date, s2.hacker_id order by s2.hacker_id) cnt
from (
select hacker_id from submissions
where submission_date = '2016-03-01'
) s1
join submissions s2
on s1.hacker_id = s2.hacker_id
) tmp
where day = rnk
) tmp
) tmp3
where rn = 1

) tbl1

join 

(
select s.*, h.name from (
select * from ( -- table for highest count each day 
select *, row_number() over (partition by submission_date order by each_count desc, hacker_id) cnt
from (
select *, count(*) over (partition by hacker_id, submission_date) as each_count
from submissions) each_tmp
) each_tmp2
where cnt = 1 ) s

join hackers h
on s.hacker_id = h.hacker_id

) tbl2

on tbl1.submission_date = tbl2.submission_date

order by submission_date;

select s.*, h.name from (
select * from ( -- table for highest count each day 
select *, row_number() over (partition by submission_date order by each_count desc, hacker_id asc) cnt
from (
select *, count(*) over (partition by hacker_id, submission_date) as each_count
from submissions) each_tmp
) each_tmp2
where cnt = 1 ) s

join hackers h
on s.hacker_id = h.hacker_id;