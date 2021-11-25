SELECT first_name,last_name
FROM employees
where birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name,last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name,last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name,last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name,last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

---Retirement Eligibility 
SELECT first_name,last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND
	   (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
	   
	   
---Number of employees retiring
SELECT COUNT (first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND
	   (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
	   
SELECT first_name,last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND
	   (hire_date BETWEEN '1985-01-01' AND '1988-12-31');	   
SELECT * FROM retirement_info;

DROP TABLE retirement_info;

--Create new table for retiring employees
SELECT emp_no,first_name,last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND
	   (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--Check the table
SELECT * FROM retirement_info;

--Joining departments and dept_manager tables
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

--Joining retirement_info and dept_emp tables:
SELECT retirement_info.emp_no,
	retirement_info.first_name,
retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

--shortening names
SELECT ri.emp_no,
	ri.first_name,
ri.last_name,
	dept_emp to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
on ri.emp_no = de.emp_no;

SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');


--COUNT WILL COUNT THE ROWS OF DATA IN A DATASET
--GROUP BY TO GROUP OUR DATA BY TYPE - USED WHEN WE WANT TO GROUP
--ORDER BY  TO PRESENT DESCENDING OR ASCENDING ORDER

--Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

--CHECKING ALL THE TABLES FOR REFERENCES 
SELECT COUNT (emp_no) from current_emp;
SELECT * FROM retirement_info;
SELECT * FROM dept_emp;
SELECT * FROM employees;
SELECT * FROM current_emp;

--LIST 1:CREATING NEW TABLE OF EMPLOYEE INFORMATION LIST 
SELECT e.emp_no,
	e.first_name,
e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

--LIST #2: MANAGEMENT LIST OF UPCOMING DEPARTURES 
SELECT dm.dept_no,
	   d.dept_name,
	   dm.emp_no,
	   ce.last_name,
	   ce.first_name,
	   dm.from_date,
	   dm.to_date
INTO manager_info
FROM dept_manager as DM
INNER JOIN departments as d
ON(dm.dept_no = d.dept_no)
INNER JOIN current_emp as ce
ON (dm.emp_no = ce.emp_no);

--LIST #3: DEPARTMENT RETIREES
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no);

--check tables 
SELECT * FROM manager_info;
--The result of this query looks even more strange than the salaries. 
--How can only five departments have active managers? 
SELECT * FROM emp_info;
--Those salaries still look a little strange, though. Bobby will need to ask his 
--manager about the lack of employee raises.

SELECT * FROM departments;
SELECT * FROM retirement_info;
SELECT * FROM current_emp;
--Tailored List: Sales depart. from Retirement_info Table 
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name, 
	d.dept_name
INTO sales_info
FROM retirement_info as ri
	INNER JOIN dept_emp as de
	ON (ri.emp_no = de.emp_no)
	INNER JOIN departments as d
	ON (de.dept_no = d.dept_no)
WHERE d.dept_no = ('d007');



SELECT * FROM titles;
SELECT * FROM employees;
--Employee Database 
SELECT em.emp_no,
	   em.first_name,
	   em.last_name,
	   ti.title,
	   ti.from_date,
	   ti.to_date
INTO retirement_titles
FROM employees as em 
	INNER JOIN titles as ti
	ON(em.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--GROUP BY de.dept_no
ORDER BY em.emp_no;


