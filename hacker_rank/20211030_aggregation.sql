-- We define an employee's total earnings to be their monthly salary x months worked, and the maximum total earnings to be 
-- the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for 
-- all employees as well as the total number of employees who have maximum total earnings. 
-- Then print these values as 2 space-separated integers.

-- calculate the earnings
-- rank and get the max list
-- select earnings and its total count
with tmp as (
    select * from (
        select earnings, rank() over (order by earnings desc) rnk 
        from (select *, (salary * months) as earnings from employee) tmp1
    ) tmp2
    where rnk = 1)

select earnings, count(rnk) from tmp
group by earnings

-- Query the following two values from the STATION table:

-- The sum of all values in LAT_N rounded to a scale of 2 decimal places.
-- The sum of all values in LONG_W rounded to a scale of 2 decimal places.
select cast(sum(lat_n) as decimal(38,2)) lat, cast(sum(long_w) as decimal(38,2)) lon from station

-- Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. 
-- Truncate your answer to 4 decimal places.
select format(max(lat_n), '#.0000') from station
where lat_n < 137.2345

-- Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that 
-- is less than 137.2345. Round your answer to 4 decimal places.
select format(long_w, '#.0000') from (
select long_w, row_number() over (order by lat_n desc) rn from station
where lat_n < 137.2345
) tmp
where rn = 1