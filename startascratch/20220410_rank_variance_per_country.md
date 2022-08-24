# Rank Variance Per Country

Which countries have risen in the rankings based on the number of comments between Dec 2019 vs Jan 2020? Hint: Avoid gaps between ranks when ranking countries.

```
Tables: fb_comments_count, fb_active_users
```

```sql
-- countries rose in ranks bsed on the # of comments between 12/2019 and 01/2020
-- avoid gaps in ranks

-- 1. join two tables by user_id
-- 2. create two columns for each comparison dates where each column is filtered by dates and groupped by name
-- 3. rank based on the total of each column
-- 4. get only the positive movement in rank

with t_2019 as (
select country, rank() over (order by sum(number_of_comments)) s_2019 from fb_comments_count a
inner join
(select * from fb_active_users) b
on a.user_id = b.user_id
where created_at > "2019-12" and
created_at < "2020-01"
group by country),

t_2020 as (
select country, rank() over (order by sum(number_of_comments)) s_2020 from fb_comments_count a
inner join
(select * from fb_active_users) b
on a.user_id = b.user_id
where created_at > "2020-01" and
created_at < "2020-02"
group by country
)

select a.*, b.s_2020 from t_2019 a
inner join
t_2020 b
on a.country = b.country
where s_2020 < s_2019
```