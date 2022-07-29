--Deliverable 1
--Create Retirement Titles Table
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

--Create Unique Titles Table
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no, rt.first_name, rt.last_name, rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE (rt.to_date >= '9999-01-01')
ORDER BY emp_no, to_date DESC;

--Create Retiring Titles Table
SELECT COUNT (ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY "title"
ORDER BY "count" DESC;

--Create Mentorship Eligibility table
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date >= '9999-01-01')
AND (e.birth_date BETWEEN '01-01-1965' AND '12-31-1965')
ORDER BY emp_no;

--Extra Queries Created for Written Analysis Below: 


--Create Mentorship Eligibility Count Table
SELECT COUNT (me.emp_no), me.title
INTO mentorship_count
FROM mentorship_eligibility as me
GROUP BY "title"
ORDER BY "count" DESC;

--Create new table Mentorship Eligibility for birth_dates from 01-01-1962 to 12-31-1965
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_elig_expanded
FROM employees as e
LEFT JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date >= '9999-01-01')
AND (e.birth_date BETWEEN '01-01-1962' AND '12-31-1965')
ORDER BY emp_no;

--Create Mentorship Eligibility Expanded (by birthdate) Count Table
SELECT COUNT (mee.emp_no), mee.title
INTO mentorship_elig_expanded_count
FROM mentorship_elig_expanded as mee
GROUP BY "title"
ORDER BY "count" DESC;

--Create Retiree TAble with 1952 birthdates
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO retiree_fiftytwo
FROM employees as e
LEFT JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date >= '9999-01-01')
AND (e.birth_date BETWEEN '01-01-1952' AND '12-31-1952')
ORDER BY emp_no;

--Create Retiree 1952 Count table
SELECT COUNT (rf.emp_no), rf.title
INTO retiree52_count
FROM retiree_fiftytwo as rf
GROUP BY "title"
ORDER BY "count" DESC;