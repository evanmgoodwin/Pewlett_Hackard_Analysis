SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31'
;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31'
;

-- Retirement Eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
;

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
;

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-1' AND '1988-12-31')
;

SELECT * FROM retirement_info
;
-- Retirement Eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
;

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
;

--------------------------------------------------------------------------------------
-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
;
--------------------------------------------------------------------------------------

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_emp.to_date
	FROM retirement_info
		LEFT JOIN dept_emp
			ON retirement_info.emp_no = dept_emp.emp_no
;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
	FROM departments as d
		INNER JOIN dept_manager as dm
			ON d.dept_no = dm.dept_no
;

------------------------------------------------------------------------------------
-- Creating current_emp table
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
	FROM retirement_info as ri
		LEFT JOIN dept_emp as de
			ON ri.emp_no = de.emp_no
		WHERE de.to_date = ('9999-01-01')
;
-------------------------------------------------------------------------------------
-- Recommended Class notes

SELECT * FROM salaries order by salary desc
LIMIT 1
;

SELECT * FROM salaries
WHERE salary < (SELECT MAX(salary) FROM salaries)
ORDER BY salary DESC
LIMIT 1
;
--------------------------------------------------------------------------------------
-- Creating emp-per-dept table
SELECT COUNT(ce.emp_no), de.dept_no
INTO emp_per_dept
	FROM current_emp AS ce
		LEFT JOIN dept_emp AS de
			ON ce.emp_no = de.emp_no
		GROUP BY de.dept_no
		ORDER BY de.dept_no
;
---------------------------------------------------------------------------------------
-- Create emp_info table
SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary, de.to_date
INTO emp_info
	FROM employees AS e
		INNER JOIN salaries AS s
			ON (e.emp_no = s.emp_no)
		INNER JOIN dept_emp AS de
			ON (e.emp_no = de.emp_no)
		WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
		AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
		AND (de.to_date = '9999-01-01')
;
-----------------------------------------------------------------------------------------
-- Creating dept_manager table
SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
INTO manager_info
	FROM dept_manager AS dm
		INNER JOIN departments AS d
			ON (dm.dept_no = d.dept_no)
		INNER JOIN current_emp AS ce
			ON (dm.emp_no = ce.emp_no)
;
------------------------------------------------------------------------------------------
-- Creating dept_info table
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
	FROM current_emp AS ce
		INNER JOIN dept_emp AS de
			ON (ce.emp_no = de.emp_no)
		INNER JOIN departments AS d
			ON (de.dept_no = d.dept_no)
;
-------------------------------------------------------------------------------------------
-- Skill Drills --
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	d.dept_name
	FROM retirement_info AS ri
		INNER JOIN employees AS e
			ON (ri.emp_no = e.emp_no)
		LEFT JOIN departments AS d
			ON (e.dept_no = d.dep_no)
;

-- Retirementinfo for sales team
SELECT emp_no, first_name, last_name
INTO sales_retirement
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
;

-- Sales Team
SELECT di.emp_no,
	di.first_name,
	di.last_name,
	di.dept_name
	FROM dept_info AS di
	WHERE dept_name IN ('Sales', 'Development')
;