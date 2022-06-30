# Finding User Purchases

Write a query that'll identify returning active users. A returning active user is a user that has made a second purchase within 7 days of any other of their purchases. Output a list of user_ids of these returning active users.

```
Table: facebook_web_logamazon_transactions
```

```sql
-- identify returning active users (made 2nd purchase within 7 days since last purchase)
-- output: list of user_id of returning active users

-- 1. group by user_id
-- 2. get the two second most recent created_at
-- 3. if thoese two dates are within 7 days apart, then mark as active users
-- 4. return user_ids of all active users

select distinct user_id 
from (
    select *, lead(created_at) over (partition by user_id order by created_at) as nexts
    from amazon_transactions
    ) q
where datediff(nexts, created_at) <= 7;
```