# Pewlett-Hackard-Analysis
## Overview
The objective of this analysis was to help the company, Pewlett Hackard, prepare for the upcoming wave of baby boomers retiring, referred to as the "silver tsunami". This will result in an enormous amount of open positions in the company and Pewlett Hackard needs to know what to expect as far as how many positions will need to be filled and which positions need to be filled in order to future proof the company. Specifically, Pewlett Hackard wants to know how many employees will be retiring by their company title and which current employees are eligible to participate in the new mentorship program. 

## Resources
Data Source: departments.csv, dept_emp.csv, dept_manager.csv, employees.csv, salaries.csv, titles.csv 

Software: SQL, Postgres/pgAdmin 11.16

## Results
### Number of Employees Retiring By Title
For this analysis 3 different queries were made to find and filter the results down to the final retiring_titles table. 
- The first query created the "retirement_titles table:
  - it pulled pertinent information from the employees table (created from employees.csv) and also from the titles table (created from titles.csv) and joined the tables
  - This information was filtered by birthdates between 01-01-1952 and 12-31-1955
  - Finally, this information was ordered by the employee number. 

- The second query created the unique_titles table:
  - Using the 'Distint On' statement filtered the multiple titles that some employees had attached to their employee number down to the most recent title
  - This query also filtered out employees that were no longer employed by the company.

- The third query created the final retiring_titles table:
  - Using the 'Select Count' statement, the employee numbers of the unique titles were counted.
  - Using 'Group by', the table was grouped by titles.
  - Using 'Order By', the table was ordered in descending order.

This last table, retiring_titles, is where the total number of retirement ready employees organized by their company title was found. (This table is posted in the summary section below) Please see the images of the three queries that were created to transform and analyze the date to create our retiring_titles table:

```
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
```

### Employees Eligible for Mentorship Program
To create the mentorship_elibility table the:
  - information was pulled from the employees tables, department employee table and titles tables
  - select columns from the department employee table and titles table were both joined to the employees table
  - the 'Distint On' statement was used to select the first occurrence of the employee number
  - the data was filtered to include only current employees whose birth dates are between 01-01-1965 and 12-31-1965
  - the table was then ordered by employee number

The query used to create the mentorship_eligibility table is included below:

```--Create Mentorship Eligibility table
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
``` 

The first 10 lines of the mentorship_eligibility table are shown below:

![Mentorship Eligibility](https://user-images.githubusercontent.com/106348899/181676530-4c01a6f0-e47d-4446-b408-5f7b3cbb0d88.png)

## Summary 
### Number of Roles to be Filled
The ultimate number of roles that will need to be filled for the "silver tsunami" is quite large.  The good news is that all employees elibible for retirement will not retire at once.  For example, the number of eligibile retirees with birthdays in 1952 will be some of the first to retire.  If those with birthdays in 1952 all retire in the same year, that will only be a total of 16,981 employees to replace for that year. That is still a large number but compared to the grand total of employees retiring it is just a fraction.  Please see the table below that shows the number of retirement ready employees with birthdays from 01-01-1952 to 12-31-1952 by title:

<img width="205" alt="Retirees 1952" src="https://user-images.githubusercontent.com/106348899/181626651-125c6a34-124f-4619-a33d-f1523ba91098.png">

The above table is just the number or retirement ready employees with birthdays in 1952.  The next table will show the full amount of employees ready to retire that have birthdays between 01-01-1952 and 12-31-1955 by title.  This table will show much larger numbers than the first.  The good news is, retirement will happen in waves and not all at once.  Please see table below for complete retirement ready list. 

<img width="228" alt="Complete List Retirees" src="https://user-images.githubusercontent.com/106348899/181626249-36abf052-bb7b-422d-9638-51efb337b947.png">

### Mentorship Numbers

The mentorship_eligibility table just looked at employees that were born in 1965 to eligible for the new mentorship program.  Just comparing the eligible employees from 1965 to the overall retirement ready employees, the answer is yes, there are more than enough employees to mentor the eligible.  The following table shows the number of mentorship eligible employees that were born in 1965:

