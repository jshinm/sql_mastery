
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
