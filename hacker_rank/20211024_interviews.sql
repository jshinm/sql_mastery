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