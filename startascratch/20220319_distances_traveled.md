# Distances Traveled

Find the top 10 users that have traveled the greatest distance. Output their id, name and a total distance traveled.

```
Tables: lyft_rides_log, lyft_users
```

```sql
-- top 10 users with greatest distance
-- output: id, name, total distance

-- 1. join by id
-- 2. order by distance
-- 3. filter top 10

-- doesn't really need rank here, and only added to add complexity

select id, name, tot, rnk from
(select id, name, tot, dense_rank() over (order by tot desc) as rnk 
from 
        lyft_users v
    join
        (select user_id, x.tot from
            (select user_id, sum(distance) tot from lyft_rides_log
            group by user_id
            order by tot desc) x
        inner join
            (select distinct sum(distance) tot from lyft_rides_log
            group by user_id
            order by tot desc) y
        on x.tot = y.tot) w
    on v.id = w.user_id) zz
where zz.rnk <= 10;
```