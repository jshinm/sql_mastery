-- SQLite syntax examples

-- creating new table
create table movies(
    'year', integer not null,
    'imdb_rating', integer, 
    'name', text unique,
    'id', integer primary key
);

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