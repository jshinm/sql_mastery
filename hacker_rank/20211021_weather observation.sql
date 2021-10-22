-- Query a list of CITY names from STATION for cities that have an even ID number. 
-- Print the results in any order, but exclude duplicates from the answer.

select distinct city from station
where id % 2 = 0

-- Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
-- For example, if there are three records in the table with CITY values 'New York', 'New York', 'Bengalaru', 
-- there are 2 different city names: 'New York' and 'Bengalaru'. The query returns , because
select count(s1.city) - count(distinct s1.city) as cnt from station as s1

-- Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). 
-- If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
-- When ordered alphabetically, the CITY names are listed as ABC, DEF, PQRS, and WXY, with lengths and
-- The longest name is PQRS, but there are  options for shortest named city. Choose ABC, because it comes first alphabetically.

-- Note: You can write two separate queries to get the desired output. It need not be a single query.

select city, length(city) as len from station
order by len asc, city asc
limit 1;

select city, length(city) as len from station
order by len desc, city asc
limit 1;

-- Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
select distinct city from station
where city like 'a%' or
city like 'e%' or
city like 'i%' or
city like 'o%' or
city like 'u%'