-- Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.

select sum(population) from city
where countrycode = 'JPN'

-- Query the difference between the maximum and minimum populations in CITY.
select max(population)-min(population) from city

-- Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, 
-- but did not realize her keyboard's 0 key was broken until after completing the calculation. 
-- She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), 
-- and the actual average salary.

-- Write a query calculating the amount of error (i.e.:  average monthly salaries), and round it up to the next integer.

-- round up the answer before changing to integer
select cast(ceiling(avg(cast(salary as float)) - avg(cast(replace(salary, 0, '') as float))) as int) from employees