# Gender With Generous Reviews

Write a query to find which gender gives a higher average review score when writing reviews as guests. Use the `from_type` column to identify guest reviews. Output the gender and their average review score.


```
Tables: airbnb_reviews, airbnb_guests
```

```sql
-- gender that gives higher avg review scores for the guests
-- output gender and avg score

-- 1. join two table
-- 2. filter columns
-- 3. group by gender and take the average of review scores
-- 4. get the max

select gender, max(avg) from
(select gender, avg(review_score) avg from
(select from_user, from_type, review_score from airbnb_reviews
where from_type = "guest") b
join
(select guest_id, gender from airbnb_guests) a
on from_user = guest_id
group by gender) c;
```