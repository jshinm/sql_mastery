# SQL syntax list with examples

## CREATE TABLE

```sql
create table movies(
    'year' integer not null,
    'imdb_rating' integer check (imdb_rating > 5),
    'name' text unique,
    'id' integer primary key,
    'car' text default 'toyota',
    constraint alias_for_constraint unique(year, name)
);
```

## INSERT INTO (row manipulation)

```sql
-- values ONLY added as a new row
 insert into celebs (id, name, age)
 values (1, 'Justine Bieber', 22);
```

## ALTER TABLE (column manipulation)

```sql
 alter table celebs
 add column twitter_handle TEXT, -- if doesn't work, place col_name in the braket (eg. add column [twitter_handle] text)
 
 alter table celebs
 modify column twitter_handle twitter_not_handle; --modification in mysql
--  alter column in sqlserver
 
 alter table celebs
 drop column [col_name];

 alter table celebs
 add unqiue(some_column);

 alter table celebs
 add constraint alias_for_constraint check(col = 'value');

 alter table celebs
 drop constraint alias_for_constraint;
```

## UPDATE (modifies cell data)

```sql
 update celebs
 set twitter_handle = '@taylorswift13'
 where id = 4;
```

## DELETE FROM

```sql
 delete from celeb
 where twitter_handle is null;
```

## DROP

```sql
drop database some_datbase

drop table submissions
```

## DISTINCT (aka unique)

```sql
select count(distinct category) --this counts for unique values of category column
from fake_apps;
```

## SHOW
- Shows tables and databases
```sql
show databases;
show tables;
```

## DESCRIBE
- returns table data types (in mysql, doesn't work in sql server)
```sql
select * from table
describe table;
```

## CREATE INDEX

```sql
-- works in sqlserver
create index idx_name
on table_name (col_name);

drop index table_name.idx_name;
```

## multiple WHERE clause

```sql
select * from movies
where imdb_rating < 5 and year > 2014;
```

## LIKE clause

```sql
select * from movies
where name like 'Se_en'; --specific number of characters to be matched
```

### LIKE % method

```sql
select * from movies
where name like '%man%' --nonspecific number of characters
```

### for search characters such as % and \_ use backslash

```sql
select * from movies
where name like '\% \_' --similar to python
```

## BETWEEN clause

```sql
select * from movies
where name between 'D' and 'G'
-- this would select anything that starts with the letter D, E, F, AND just a single G character
-- this is because between only goes up to the second value

select * from movies
where year between 1990 and 1999 --here 1999 is inclusive
```

## Usage of AND

```sql
select * from movies
where year < 1985 and genre = 'horror';

select * from movies
where year between 1980 and 1985 and genre = 'horror'; --here two ANDs are two different operators
```

## Usage of OR

```sql
select * from movies
where genre = 'romance' or genre = 'comedy'; --this can't be genre = 'a' or 'b'
```

## Usage of parentheses (dictates the ordering of the command execution)

```sql
select * from movies
where (year between 2000 and 2010)
or (genre = 'romance' and genre = 'comedy')
```

## Order by (asc, desc)

```sql
select name, year, imdb_rating from movies
order by imdb_rating desc, year asc; --order by rating first then keeping the ordering the result is again order by year
```

## LIMIT (the number of limit can go beyond the total number of rows)

```sql
-- LIMIT row_count
-- LIMIT row_count OFFSET offset
-- LIMIT offset, row_count //limit 3,1 means to get 1 row starting from the 4th row
select * from movies
order by imdb_rating desc
limit 3;
```

## CASE (sql if-else statement)

```sql
-- the following creates a column named 'Mood' according to the 3 conditionals below

 select name, --case comes AFTER SELECT
  case
    when genre = 'romance' then 'Chill' --values after THEN can be mixed types
    when genre = 'comedy' then 'Chill' --e.g. here it can be numbers instead of a string
    else 'Intense'
  end as 'Mood'
from movies;
```

## Aggregate

```sql
select count(*) from fake_apps; --returns the total number of rows (note: it counts duplicate values, ie. this is not a uniuqe count)
select sum(downloads) from fake_apps; --returns 0.0 if sum(TEXT), also doesn't take multiple values unless combined within (eg sum(id + downloads))
select max(category) from fake_apps; -- returns asc desc item if passed TEXT
select min(downloads) from fake_apps; -- for the multiple min/max, the first row is returned
select avg(price) from fake_apps; -- returns 0.0 if passed TEXT
select name, round(price, 0) from fake_apps; --returns name and round(price, 0) columns (literally) where values under price column are rounded to 0 decimal places
-- in sqlite, n < 5 is rounded down and up if n > 5
```

## Group by

```sql
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
```

## INNER JOIN (complete join)

```sql
select * from orders
join subscriptions
on orders.subscription_id = subscriptions.subscription_id

-- seems like the tables are being inner joined here first after which the the result is wrapped by the count and returns int
select count(*) from online
join newspaper
on newspaper.id = online.id; --the order of tables being joined do not yield different join product except the ordering of the columns
```

## LEFT JOIN

```sql
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
```

## CROSS JOIN 

```sql
-- making every possible combinations, e.g. color(3 items) x shape(2 items) = result(6 items)

select month, count(*) from newspaper
cross join months --month is from months table; also cross join can be done multiple times
where start_month <= month and end_month >= month
group by month; -- group by on cross joined product
```

## UNION

```sql
-- Tables must have the same number of columns.
-- The columns must have the same data types in the same order as the first table.
select * from newspaper
union
select * from online
-- When you combine tables with UNION, duplicate rows will be excluded.
-- but if you wanted to include duplicates, there is union all
```

## WITH

```sql
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
```

```sql
-- WITH clause can stack multiple queries easily
-- One query after next takes on preceding queries

-- get the list of host scores
with tmp1 as (
    select host_team as team,
        case
            when host_goals > guest_goals then 3
            when host_goals = guest_goals then 1
        end as score
    from matches),
-- get the list of guest scores
tmp2 as (
    select guest_team as team,
        case
            when host_goals < guest_goals then 3
            when host_goals = guest_goals then 1
        end as score
    from matches),
-- union of tmp1 and tmp2 (yields null values)
tmp3 as (
    select * from tmp1
    union all
    select * from tmp2
    ),
-- sum ignores null
tmp4 as (
    select team, sum(score) as score from tmp3
    group by team
    )
```

## Define function

```sql
create function funcname(N int) returns int
begin
  return (
    -- sql queries here
    -- sql queries here
    -- sql queries here
  );
end
```

## User defined variable

```sql
set @var_name = 'variable';

-- above is the same as below
declare var_name
set var_name = 'variable';

-- there is one significant difference between := and =, and that is that := works as a variable-assignment operator everywhere, while = only works that way in SET statements, and is a comparison operator everywhere else. So SELECT @var = 1 + 1; will leave @var unchanged and return a boolean (1 or 0 depending on the current value of @var), while SELECT @var := 1 + 1; will change @var to 2, and return 2
-- https://stackoverflow.com/questions/1009954/mysql-variable-vs-variable-whats-the-difference
```
## IN

```sql
-- specifies multiple values in a where clause
-- can be interpreted as OR clause
-- Must be in parentheses

select col_names
from tables
where col_names in (val1, val2, val3); -- or IN (select statement)

select * from country_list
where country not in ('country_A', 'country_B', 'country_C');
```

## Operation with Date type

```sql
-- When subtracting date, subdate() has to be used
-- Its counterpart for addition is adddate()
select w2.Id
from
    (select * from Weather order by RecordDate asc) w1, 
    (select * from Weather order by RecordDate asc) w2
where
w1.RecordDate = subdate(w2.RecordDate,1) and
w1.Temperature < w2.Temperature
```

## Difference between = vs :=

```sql
-- similarly in math, := specifically refers to the assignment of value 
-- where simple equal sign can be used for both conditional testing and variable assignment in sql
set @val := 1;
```

## Length()

```sql
-- length is used to count the number of characters in a given string
length(char)
```

## IF(cond,1,0)

```sql
if(gender='m','f','m') --swap m with f
```

## REGEXP (REGEXP statement)

```sql
-- SQL server does NOT support REGEXP instead it can match pattern using LIKE clause
-- select all city names that start with vowel and end with vowel
select city from station
where city regexp '^[aeiou].*[aeiou]$'
```

```
#basic regexp syntax
*	Zero or more instances of string preceding it
+	One or more instances of strings preceding it
.	Any single character
?	Match zero or one instances of the strings preceding it.
^	caret(^) matches Beginning of string
$	End of string
[abc]	Any character listed between the square brackets
[^abc]	Any character not listed between the square brackets
[A-Z]	match any upper case letter.
[a-z]	match any lower case letter
[0-9]	match any digit from 0 through to 9.
[[:<:]]	matches the beginning of words.
[[:>:]]	matches the end of words.
[:class:]	matches a character class i.e. [:alpha:] to match letters, [:space:] to match white space, [:punct:] is match punctuations and [:upper:] for upper class letters.
p1|p2|p3	Alternation; matches any of the patterns p1, p2, or p3
{n}	n instances of preceding element
{m,n}	m through n instances of preceding element
```

## PARTITION BY

```sql
-- partition by is similar to pandas' group by
-- the following groups by price and within each group the list is ordered by id
-- then the window function is applied to each group
select *, row_number() over (partition by price order by id) rownum from temp;
```

## SUBSTRING(column, index)

```sql
-- gets the last 3 strings of the name from table students
select name from students
where marks > 75
order by substring(name, -3), id
```

## DATEDIFF(date1, date2)

```sql
set sql_mode = '';
select start_date, end_date from
(select start_date from projects where start_date not in (select end_date from projects)) a,
(select end_date from projects where end_date not in (select start_date from projects)) b
where start_date < end_date
group by start_date
order by datediff(end_date, start_date), start_date -- difference between end and start dates
```

## ROW_NUMBER()

```sql
-- collects row number based on the ordering of the price
-- this is different from rank() as rank() would return same value for equal value
select id, rank() over (order by price) from some_table
```

## RANK() / DENSE_RANK()

```sql
-- ranks table based on the ordering of the price
select id, rank() over (order by price) from some_table
-- returns (id, rank()), (4, 1), (5, 1), (1, 3), (4, 4)

-- dense_rank() will not skip the rank
select id, dense_rank() over (order by price) from some_table
-- returns (id, rank()), (4, 1), (5, 1), (1, 2), (4, 3)
```

## CAST(col as [data type])
- Changes data type
```sql
-- changes string column (salary) into float
select cast(ceiling(avg(cast(salary as float)) - avg(cast(replace(salary, 0, '') as float))) as int) from employees

-- cast as user-specific data type
-- where decimal(p, s), numeric(p, s)
-- where p: max num decimal digits to be stored, s: decimal point to be rounded
select cast(sum(lat_n) as decimal(38,2)) lat, cast(sum(long_w) as decimal(38,2)) lon from station
```

## REPLACE(col, from, to)
- Replaces character regardless of its data type
```sql
-- replace function reads int column and replaces zero with empty string after which the column type becomes varchar
select cast(ceiling(avg(cast(salary as float)) - avg(cast(replace(salary, 0, '') as float))) as int) from employees
```

## CEILING(col)
- Rounds up
```sql
-- rounds up the computation inside the parenthesis
select cast(ceiling(avg(cast(salary as float)) - avg(cast(replace(salary, 0, '') as float))) as int) from employees
```

## FORMAT(char, format)
- Formats character as stated as format arg
```sql
select format(12345, '#.00') from station
```

## REPEAT(e, n)
- Repeats entity e for n times (mysql, not in sql server)
```sql
select repeat('a', 10);
```

## UPPER(c), LOWER(c), ucase(c), lcase(c)
- Changes character c into a uppercase or lowercase
```sql
select upper('name');
```

## CURDATE()
- Returns current date (only in mysql)
```sql
select curdate();
```

## Length(e)
- Returns the length of the entity e
- Length() or character_length() in mysql
- len() in sql server
```sql
-- returns 4
select len('name');
```

## Concat(e)
- Concatenate entities e into a single entity
- Works on MySQL and SQL server
```sql
-- returns 123a
select concat(1,2,3,'a');
```

## Reverse(e)
- Reverses entity e in order
- Works on MySQL and SQL server
```sql
-- Returns 444
select num + rev from (select 123 as num, reverse(123) as rev) tmp;
```

## Trim(), ltrim(), rtrim()
- Removes whitespace in a string
```sql
-- returns abc
select trim('       abc      ');
```

## Position(keyword in string)
- Returns index of the keyword in a string
```sql
-- returns 6
select position('world' in 'hello world');
```

## COALESCE(col_containing_null, val)
- Replaces null with `val`
```sql
-- the function creates new column
select teams.*, coalesce(score, 0) as points from tmp4
right join teams
on team_id = team
order by points desc, team_id asc;
```

## UNNEST(array)
- Takes an array and returns a table with a row for each element in the array
```sql
select unnest(['A', 'B']) from tables;
```

## STRING_TO_ARRAY(string, separator)
- Parse out each element from a string and returns an array
```sql
select unnest(string_to_array(categories, ';')) as category, sum(review_count) as review_cnt from yelp_business
group by category
order by review_cnt desc
```