-- Table: Employee

-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | Id          | int  |
-- | Salary      | int  |
-- +-------------+------+
-- Id is the primary key column for this table.
-- Each row of this table contains information about the salary of an employee.
 

-- Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null.

-- The query result format is in the following example.

select 
    (select distinct Salary from Employee
        order by Salary desc
        limit 1 offset 1 --equal to range(1,1) except start is exclusive and end is inclusive
    ) as SecondHighestSalary

-- using ifnull clause
select 
    ifnull(
    (select distinct Salary from Employee
        order by Salary desc
        limit 1 offset 1 --equal to range(1,1) except start is exclusive and end is inclusive
    ), null) as SecondHighestSalary