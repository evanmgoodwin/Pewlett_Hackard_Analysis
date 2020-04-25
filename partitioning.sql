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