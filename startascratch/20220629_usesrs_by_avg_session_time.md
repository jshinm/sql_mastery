# Users By Average Session Time

Which countries have risen in the rankings based on the number of comments between Dec 2019 vs Jan 2020? Hint: Avoid gaps between ranks when ranking countries.Calculate each user's average session time. A session is defined as the time difference between a page_load and page_exit. For simplicity, assume a user has only 1 session per day and if there are multiple of the same events on that day, consider only the latest page_load and earliest page_exit. Output the user_id and their average session time.

```
Table: facebook_web_log
```

```sql
-- avg session time (page_load - page_exit)
-- assume user has only 1 session per day (consider only the latest page_load and earlest page_exit)
-- output: user_id, avg session time

-- 1. filter out for page_load and page_exit in `action`
-- 2. group by user_id and find min max of timestamp
-- 3. find delta

with table1 as (
    select user_id, DATE(timestamp) as d,
    max(case when action = 'page_load' then timestamp else null end) as loaded,
    min(case when action = 'page_exit' then timestamp else null end) as exited
    from facebook_web_log
    group by user_id, d
),

table2 as (
select *, time_to_sec(TIMEDIFF(exited, loaded)) as dt from table1
where TIMEDIFF(exited, loaded) is not null
)

select user_id, avg(dt) as avg from table2 
group by user_id;
```