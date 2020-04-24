-- Challenge Table 1 --
SELECT ei.emp_no,
	ei.first_name,
	ei.last_name,
	titles.title,
	titles.from_date,
	ei.salary
INTO table_1
	FROM emp_info AS ei
		INNER JOIN titles
			ON (ei.emp_no = titles.emp_no)
;

-- Updated Challenge Table 1 --
SELECT emp_no,
	first_name,
	last_name,
	title,
	from_date,
	salary
--INTO table_1_new as t1n
	FROM
		(SELECT emp_no,
			first_name,
			last_name,
			title,
			from_date,
			salary, ROW_NUMBER() OVER
			(PARTITION BY (emp_no)
			ORDER BY from_date DESC) rn
			FROM table_1
			) tmp WHERE rn = 1
		ORDER BY emp_no
;
-------------------------------------------------------------------------------------------------------
-- Alternative Challenge 1 Table --
-- Employees Retiring --
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	titles.title,
	titles.from_date,
	s.salary
INTO retiring
	FROM employees AS e
		INNER JOIN titles
			ON (e.emp_no = titles.emp_no)
		INNER JOIN salaries AS s
			ON (e.emp_no = s.emp_no)
	WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (titles.to_date = '9999-01-01')
	ORDER BY emp_no ASC
;
-- Number of Titles Retiring --
SELECT title, COUNT(emp_no)
INTO titles_retiring
FROM retiring
	GROUP BY title
	ORDER BY COUNT(emp_no) DESC
;
-- Challenge Table 2 --
-- Mentoring --
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	titles.title,
	titles.from_date,
	titles.to_date
INTO mentoring
	FROM employees AS e
		INNER JOIN titles
			ON (e.emp_no = titles.emp_no)
	WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (titles.to_date = '9999-01-01')
	ORDER BY emp_no ASC
;