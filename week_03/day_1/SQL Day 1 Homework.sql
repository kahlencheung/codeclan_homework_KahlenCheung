--Question 1.
--Find all the employees who work in the ‘Human Resources’ department.

SELECT *
FROM employees 
WHERE department = 'Human Resources';

--Question 2.
--Get the first_name, last_name, and country of the employees who work in the ‘Legal’ department.

SELECT first_name, last_name, country
FROM employees 
WHERE department = 'Legal';

--Question 3.
--Count the number of employees based in Portugal.
--29
SELECT 
    count(*)
FROM employees 
WHERE country  = 'Portugal';

--Question 4.
--Count the number of employees based in either Portugal or Spain.
--35
SELECT 
    count(*)
FROM employees 
WHERE country  = 'Portugal' OR country = 'Spain';

--Question 5.
--Count the number of pay_details records lacking a local_account_no. 
--25
SELECT 
    count(*)
FROM pay_details 
WHERE local_account_no ISNULL;

--Question 6.
--Are there any pay_details records lacking both a local_account_no and iban number?
--0, no result returns
SELECT 
    count(*)
FROM pay_details 
WHERE local_account_no ISNULL AND iban ISNULL;


--Question 7.
--Get a table with employees first_name and last_name ordered alphabetically 
--by last_name (put any NULLs last).
-- frist name is Anugus Abels
SELECT 
    first_name ,
    last_name 
FROM employees
ORDER BY last_name ASC NULLS LAST;

--Question 8.
--Get a table of employees first_name, last_name and country, 
--ordered alphabetically first by country and then by last_name (put any NULLs last).

SELECT 
    first_name ,
    last_name ,
    country 
FROM employees
ORDER BY country ASC NULLS LAST,   --ORDER BY cannot use AND 
         last_name ASC NULLS LAST;

--Question 9.
--Find the details of the top ten highest paid employees in the corporation.
-- id = 760, 947, 859, 965, 200...
SELECT *
FROM employees
ORDER BY salary DESC NULLS LAST
LIMIT 10;

--Question 10.
--Find the first_name, last_name and salary of the lowest paid employee in Hungary.
-- Eveline Canton 20,519
SELECT 
    first_name ,
    last_name ,
    salary 
FROM
employees 
WHERE country = 'Hungary'
ORDER BY salary ASC NULLS LAST 


/*SELECT 
    first_name ,                --NOT related TO concat a FULL name, since it will RETURN a NEW column
    last_name ,
    min(salary)                --ONLY RETURNS 1 value, need TO know who IS it 
FROM
employees 
WHERE country = 'Hungary'
--for whom
GROUP BY (first_name, last_name)*/

--Question 11.
--How many employees have a first_name beginning with ‘F’?
--30
SELECT 
count(first_name) 
FROM employees 
WHERE first_name LIKE'F%'

--Question 12.
--Find all the details of any employees with a ‘yahoo’ email address?
-- returns 5 results
SELECT *
FROM employees 
WHERE email ILIKE '%yahoo%'

--Question 13. Count the number of pension enrolled employees 
--not based in either France or Germany.
--475
SELECT 
    count(pension_enrol)
FROM employees 
WHERE 
    pension_enrol = TRUE AND    --DO the logical operation IN the WHERE clause
    country NOT IN ('France', 'Germany')

--Question 14.
--What is the maximum salary among those employees in the ‘Engineering’ department 
--who work 1.0 full-time equivalent hours (fte_hours)?
--Gualterio Withnall, 83370    
SELECT *
FROM employees 
WHERE fte_hours = 1.0 AND department  = 'Engineering'
ORDER BY salary DESC NULLS LAST 
LIMIT 1

--Question 15.
--Return a table containing each employees first_name, last_name, full-time 
--equivalent hours (fte_hours), salary, and a new column effective_yearly_salary 
--which should contain fte_hours multiplied by salary.

SELECT 
first_name ,
last_name ,
fte_hours,
salary,
concat (fte_hours*salary) AS effective_yearly_salary
FROM
employees 

--EXTENSION
/*Question 16.
The corporation wants to make name badges for a forthcoming conference. 
Return a column badge_label showing employees’ first_name and last_name joined 
together with their department in the following style: ‘Bob Smith - Legal’. 
Restrict output to only those employees with stored first_name, last_name and department.*/



