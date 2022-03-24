

--Question 1.
--How many employee records are lacking both a grade and salary?
--406
SELECT sum(id)
FROM employees 
WHERE grade IS NULL AND salary IS NULL ;


--Question 2.
/*Produce a table with the two following fields (columns):

the department
the employees full name (first and last name)
Order your resulting table alphabetically by department, and then by last name*/

SELECT department , first_name, last_name
FROM employees 
ORDER BY (department, last_name);

--Question 3.
--Find the details of the top ten highest paid employees who have 
--a last_name beginning with ‘A’.

SELECT *
FROM employees
WHERE last_name LIKE 'A%'
LIMIT 10;

--Question 4.
--Obtain a count by department of the employees who started work 
--with the corporation in 2003.
--538
SELECT count(*) 
FROM employees 
WHERE start_date >= '2003-01-01';

--Question 5.
/*Obtain a table showing department, fte_hours and the number of employees in each 
department who work each fte_hours pattern. 
Order the table alphabetically by department, and then in ascending order of fte_hours. */


SELECT department, 
       fte_hours,
       count(department)
FROM employees 
GROUP BY (department,fte_hours)
ORDER BY (department,fte_hours);


--Question 6.
--Provide a breakdown of the numbers of employees enrolled, not enrolled, 
--and with unknown enrollment status in the corporation pension scheme.


SELECT 

(SELECT count(pension_enrol)
FROM employees 
WHERE pension_enrol = TRUE)AS Y,

(SELECT count(pension_enrol)
FROM employees 
WHERE pension_enrol = FALSE)AS N,

(SELECT count(*)
FROM employees 
WHERE pension_enrol IS NULL)AS nul

FROM employees 
LIMIT 1


--Question 7.
--Obtain the details for the employee with the highest salary in the ‘Accounting’ 
--department who is not enrolled in the pension scheme?
--Gobbet
SELECT *
FROM employees 
WHERE department ='Accounting' AND pension_enrol = FALSE
ORDER BY salary DESC 

--Question 8.
--Get a table of country, number of employees in that country, and the average 
--salary of employees in that country for any countries in which more than 30 
--employees are based. Order the table by average salary descending.



--13
--order by LIMIT 
mozelle


--16
SELECT department,
sum(CAST (grade ='1'AS int))/CAST (count(id)AS REAL)),2) AS prop_grade_1 
FROM employees
GROUP BY department 