-- Samantha interviews many candidates from different colleges using coding challenges 
-- and contests. Write a query to print the contest_id, hacker_id, name, 
-- and the sums of total_submissions, total_accepted_submissions, total_views, 
-- and total_unique_views for each contest sorted by contest_id. 
-- Exclude the contest from the result if all four sums are .

-- Note: A specific contest can be used to screen candidates at more than one college, 
-- but each college only holds  screening contest.

with tmp as (
select distinct ct.*, ch.* from contests ct
        join colleges co
        on ct.contest_id = co.contest_id
        join challenges ch
        on co.college_id = ch.college_id) -- get all non-repeating ids

select distinct contest_id, hacker_id, name, ts, ta, tv, tu from -- reordering columns for submission
(
select distinct contest_id, hacker_id, name, tv, tu, -- get tv, tu, this way there's no double count
    sum(total_submissions) over (partition by contest_id) ts,
    sum(total_accepted_submissions) over (partition by contest_id) ta
    from (
        select distinct contest_id, hacker_id, name, tmp.challenge_id, -- get tv, tu
            sum(total_views) over (partition by contest_id) tv,
            sum(total_unique_views) over (partition by contest_id) tu
        from tmp
        left join view_stats vs
        on tmp.challenge_id = vs.challenge_id
        ) tmp2
    left join submission_stats ss
    on tmp2.challenge_id = ss.challenge_id
) tmp3;

-- Julia conducted a  days of learning SQL contest. The start date of the contest was 
-- March 01, 2016 and the end date was March 15, 2016.

-- Write a query to print total number of unique hackers who made at least 1 submission 
-- each day (starting on the first day of the contest), and find the hacker_id and 
-- name of the hacker who made maximum number of submissions each day. 
-- If more than one such hacker has a maximum number of submissions, 
-- print the lowest hacker_id. The query should print this information for 
-- each day of the contest, sorted by the date.

with tmp as (
select s.*, h.name, dense_rank() over (partition by s.hacker_id order by submission_date) as idx,
dense_rank() over (order by submission_date) as cnt
from submissions s
join 
(select hacker_id
from submissions
where submission_date = '2016-03-01') tmp
on s.hacker_id = tmp.hacker_id
join hackers h
on h.hacker_id = tmp.hacker_id
)

select submission_date, total, hacker_id, name
from (
select submission_date, hacker_id, total, each_count, name,
row_number() over (partition by submission_date order by each_count desc, hacker_id) ridx
from 
(
select submission_date, hacker_id, name,
count(hacker_id) over (partition by submission_date order by submission_date) as total,
count(hacker_id) over (partition by submission_date, hacker_id order by submission_date) as each_count
from tmp t1
where idx = cnt
) tmp2
) tmp3
where ridx = 1
order by submission_date asc, each_count desc, hacker_id asc;