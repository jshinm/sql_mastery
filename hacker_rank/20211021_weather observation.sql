-- Query a list of CITY names from STATION for cities that have an even ID number. 
-- Print the results in any order, but exclude duplicates from the answer.

select distinct city from station
where id % 2 = 0

-- Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
-- For example, if there are three records in the table with CITY values 'New York', 'New York', 'Bengalaru', 
-- there are 2 different city names: 'New York' and 'Bengalaru'. The query returns , because
select count(s1.city) - count(distinct s1.city) as cnt from station as s1