-- Table: Person

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | PersonId    | int     |
-- | FirstName   | varchar |
-- | LastName    | varchar |
-- +-------------+---------+
-- PersonId is the primary key column for this table.
-- This table contains information about the ID of some persons and their first and last names.
 

-- Table: Address

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | AddressId   | int     |
-- | PersonId    | int     |
-- | City        | varchar |
-- | State       | varchar |
-- +-------------+---------+
-- AddressId is the primary key column for this table.
-- Each row of this table containts information about the city and state of one person with ID = PersonId.
 

-- Write an SQL query to report the first name, last name, city, and state of each person in the Person table. If the address of a PersonId is not present in the Address table, report null instead.

-- Return the result table in any order.

-- The query result format is in the following example.

-- Write your MySQL query statement below
select FirstName, LastNAme, City, State from Person
left join Address
on Person.PersonID = Address.PersonID