/*
Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than $2000 per month who have been employees for less than 10 months. Sort your results by ascending employee_id

Input format 

The Employe table containing employe data for a company is described as follows:

Column | Type
employe_id | Integer
name | String
months | Integer 
salary | Integer 

where employe_id is an employe's ID number, name is their name, months is the total number of months they've been working for the company, and salary i s their montly salary
*/
SELECT name
FROM Employee
WHERE salary > 2000 AND months < 10
ORDER BY employee_id ASC;
