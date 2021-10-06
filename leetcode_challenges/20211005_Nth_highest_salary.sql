-- Table: Employee

-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | Id          | int  |
-- | Salary      | int  |
-- +-------------+------+
-- Id is the primary key column for this table.
-- Each row of this table contains information about the salary of an employee.
 

-- Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Employee table:
-- +----+--------+
-- | Id | Salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+
-- n = 2
-- Output: 
-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | 200                    |
-- +------------------------+
-- Example 2:

-- Input: 
-- Employee table:
-- +----+--------+
-- | Id | Salary |
-- +----+--------+
-- | 1  | 100    |
-- +----+--------+
-- n = 2
-- Output: 
-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | Null                   |
-- +------------------------+

-- by declaring variable
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
declare m int;
set m = N - 1;
  RETURN (
      select distinct Salary from Employee
      order by Salary desc
      limit M,1
  );
END

-- not declaring variable
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN(
      select distinct e1.salary from Employee as e1
      where N-1 = (select count(distinct e2.Salary) from Employee as e2
                   where e1.Salary < e2.Salary)
  );
END