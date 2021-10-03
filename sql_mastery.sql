
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