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


```