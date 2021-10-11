-- Table: Employee

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | Id          | int     |
-- | Name        | varchar |
-- | Salary      | int     |
-- | ManagerId   | int     |
-- +-------------+---------+
-- Id is the primary key column for this table.
-- Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.
 

-- Write an SQL query to find the employees who earn more than their managers.

-- Return the result table in any order.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Employee table:
-- +----+-------+--------+-----------+
-- | Id | Name  | Salary | ManagerId |
-- +----+-------+--------+-----------+
-- | 1  | Joe   | 70000  | 3         |
-- | 2  | Henry | 80000  | 4         |
-- | 3  | Sam   | 60000  | Null      |
-- | 4  | Max   | 90000  | Null      |
-- +----+-------+--------+-----------+
-- Output: 
-- +----------+
-- | Employee |
-- +----------+
-- | Joe      |
-- +----------+
-- Explanation: Joe is the only employee who earns more than his manager.

-- # Write your MySQL query statement below

-- # 1. Join on Left.Id and Right.ManagerId
-- # 2. Set criterion where Left.Salary > Right.Salary

select e.Name as `Employee` from Employee e 
join Employee on Employee.Id = e.ManagerId
where Employee.Salary < e.Salary