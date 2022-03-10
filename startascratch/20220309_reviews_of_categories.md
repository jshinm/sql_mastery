# Reviews of Categories

Find the top business categories based on the total number of reviews. Output the category along with the total number of reviews. Order by total reviews in descending order.

```
Table: yelp_business
```

```sql
-- top business categories based on the total # of reviews
-- output: category, total # of reviews - orderby total review in descending order

-- 1. filter columns
-- 2. group by category, count(#reviews)
-- 3. orderby descending order 

-- the following would parse out the first string
-- select substring(categories, 1, locate(';', categories)-1) as category, review_count from yelp_business

select unnest(string_to_array(categories, ';')) as category, sum(review_count) as review_cnt from yelp_business
group by category
order by review_cnt desc
```