/*
Write a query that prints a list of employe names (i.e.: the name atribute) from the Employe table in alphabetical order

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
ORDER BY name;
