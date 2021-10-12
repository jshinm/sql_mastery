-- Table: Employee

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | Id           | int     |
-- | Name         | varchar |
-- | Salary       | int     |
-- | DepartmentId | int     |
-- +--------------+---------+
-- Id is the primary key column for this table.
-- DepartmentId is a foreign key of the ID from the Department table.
-- Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 

-- Table: Department

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | Id          | int     |
-- | Name        | varchar |
-- +-------------+---------+
-- Id is the primary key column for this table.
-- Each row of this table indicates the ID of a department and its name.
 

-- Write an SQL query to find employees who have the highest salary in each of the departments.

-- Return the result table in any order.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Employee table:
-- +----+-------+--------+--------------+
-- | Id | Name  | Salary | DepartmentId |
-- +----+-------+--------+--------------+
-- | 1  | Joe   | 70000  | 1            |
-- | 2  | Jim   | 90000  | 1            |
-- | 3  | Henry | 80000  | 2            |
-- | 4  | Sam   | 60000  | 2            |
-- | 5  | Max   | 90000  | 1            |
-- +----+-------+--------+--------------+
-- Department table:
-- +----+-------+
-- | Id | Name  |
-- +----+-------+
-- | 1  | IT    |
-- | 2  | Sales |
-- +----+-------+
-- Output: 
-- +------------+----------+--------+
-- | Department | Employee | Salary |
-- +------------+----------+--------+
-- | IT         | Jim      | 90000  |
-- | Sales      | Henry    | 80000  |
-- | IT         | Max      | 90000  |
-- +------------+----------+--------+
-- Explanation: Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.

-- # Write your MySQL query statement below
-- # get max on group by
-- # join cascade (very slow)
select 
    e.Name `Department`, 
    c.Name `Employee`, 
    d.Salary 

from
(select 
     b.Department, 
     b.Salary
from 
 Employee as a, (
select 
     e.Name as Employee, 
     max(e.Salary) as Salary, 
     e.DepartmentId as Department
from Employee e     
group by e.DepartmentId
) as b
 
where 
a.DepartmentId = b.Department and
a.Salary = b.Salary
group by b.Department, b.Salary
) as d

join Employee c on c.DepartmentId = d.Department
join Department e on e.Id = d.Department

where
c.Salary = d.Salary