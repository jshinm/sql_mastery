-- SQLite syntax examples

-- creating new table
create table movies(
    'year', integer not null,
    'imdb_rating', integer, 
    'name', text unique,
    'id', integer primary key
);

-- INSERT INTO (adds new row)
 insert into celebs (id, name, age)
 values (1, 'Justine Bieber', 22);

 -- ALTER TABLE (adds new column)
 alter table celebs
 add column twitter_handle TEXT;

-- UPDATE (modifies cell data)
 update celebs
 set twitter_handle = '@taylorswift13'
 where id = 4;

-- DELETE FROM
 delete from celeb
 where twitter_handle is null;

-- DISTINCT (aka unique)
select count(distinct category) --this counts for unique values of category column
from fake_apps;

-- multiple WHERE clause
select * from movies
where imdb_rating < 5 and year > 2014;

-- LIKE clause
select * from movies
where name like 'Se_en'; --specific number of characters to be matched

-- LIKE % method
select * from movies
where name like '%man%' --nonspecific number of characters

-- for search characters such as % and _ use backslash
select * from movies
where name like '\% \_' --similar to python

-- BETWEEN clause
select * from movies
where name between 'D' and 'G' 
-- this would select anything that starts with the letter D, E, F, AND just a single G character
-- this is because between only goes up to the second value

select * from movies
where year between 1990 and 1999 --here 1999 is inclusive

-- Usage of AND
select * from movies
where year < 1985 and genre = 'horror';

select * from movies
where year between 1980 and 1985 and genre = 'horror'; --here two ANDs are two different operators

-- Usage of OR
select * from movies
where genre = 'romance' or genre = 'comedy'; --this can't be genre = 'a' or 'b'

-- Usage of parentheses (dictates the ordering of the command execution)
select * from movies
where (year between 2000 and 2010) 
or (genre = 'romance' and genre = 'comedy')

-- Order by (asc, desc)
select name, year, imdb_rating from movies
order by imdb_rating desc, year asc; --order by rating first then keeping the ordering the result is again order by year

-- LIMIT (the number of limit can go beyond the total number of rows)
select * from movies
order by imdb_rating desc
limit 3;

-- CASE (sql if-else statement), the following creates a column named 'Mood' according to the 3 conditionals below
 select name, --case comes AFTER SELECT
  case
    when genre = 'romance' then 'Chill' --values after THEN can be mixed types
    when genre = 'comedy' then 'Chill' --e.g. here it can be numbers instead of a string
    else 'Intense'
  end as 'Mood'
from movies;

-- Aggregate
select count(*) from fake_apps; --returns the total number of rows (note: it counts duplicate values, ie. this is not a uniuqe count)
select sum(downloads) from fake_apps; --returns 0.0 if sum(TEXT), also doesn't take multiple values unless combined within (eg sum(id + downloads))
select max(category) from fake_apps; -- returns asc desc item if passed TEXT
select min(downloads) from fake_apps; -- for the multiple min/max, the first row is returned
select avg(price) from fake_apps; -- returns 0.0 if passed TEXT
select name, round(price, 0) from fake_apps; --returns name and round(price, 0) columns (literally) where values under price column are rounded to 0 decimal places
-- in sqlite, n < 5 is rounded down and up if n > 5

-- Group by
select category, sum(downloads) from fake_apps
group by category --group by doesn't need to be one of the columns selected
order by 1;-- group by (and order by) could be indexed e.g. group by 1 to indicate `category`

-- Two group by
select category, price, avg(downloads) from fake_apps
group by category, price; --group by price after grouped by caterogry

-- using group by with HAVING
-- When we want to limit the results of a query based on values of the individual rows, use WHERE.
-- When we want to limit the results of a query based on an aggregate property, use HAVING.
select category, price, avg(downloads) from fake_apps
group by 1,2
having avg(downloads) > 10000; -- replacing having with where will throw an error

-- WHERE and HAVING can be in the same query
select name,category,downloads from fake_apps
where downloads > 10000
group by 1,2
having downloads > 20000

-- INNER JOIN (complete join)
select * from orders
join subscriptions
on orders.subscription_id = subscriptions.subscription_id

-- seems like the tables are being inner joined here first after which the the result is wrapped by the count and returns int
select count(*) from online
join newspaper
on newspaper.id = online.id; --the order of tables being joined do not yield different join product except the ordering of the columns

-- LEFT JOIN
select * from newspaper
left join online
on newspaper.id = online.id

-- if were to select what not joined from right table
select * from newspaper
left join online
on newspaper.id = online.id
where online.id is null; -- another words, this would be the list from LEFT table ~(LEFT JOIN on RIGHT table)

-- INNER vs LEFT
-- Return all the data from the first table no matter what. 
-- If there are any matches with the second table, provide that information as well, 
-- but if not, just fill the missing data with NULL values

-- Primary keys cannot be NULL
-- Must be unique
-- There can only be one primary key per table
-- When the primary key for one table appears in a different table, it is called a foreign key.
-- Candidate key is a column with unqiue items that could be a 'candidate' for a primary key

-- CROSS JOIN (making every possible combinations, e.g. color(3 items) x shape(2 items) = result(6 items)
select month, count(*) from newspaper
cross join months --month is from months table; also cross join can be done multiple times
where start_month <= month and end_month >= month
group by month; -- group by on cross joined product

-- UNION
-- Tables must have the same number of columns.
-- The columns must have the same data types in the same order as the first table.
select * from newspaper
union
select * from online
-- When you combine tables with UNION, duplicate rows will be excluded.
-- but if you wanted to include duplicates, there is union all

-- WITH
-- creates temporary table to be refereced as alias
with previous_query as (
  select customer_id, count(subscription_id) as 'subscriptions' 
  from orders
  group by customer_id
)

select customer_name, subscriptions from customers
join previous_query
on previous_query.customer_id = customers.customer_id;
-- Can we use WITH for more than one nested query in SQL?
-- yes as follows:
-- WITH
-- query1 AS (SELECT column1 FROM table1 WHERE condition1),
-- query2 AS (SELECT column2 FROM table2 WHERE condition2),