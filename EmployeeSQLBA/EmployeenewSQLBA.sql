drop table if exists title cascade;
drop table if exists department_manager cascade;
drop table if exists department_employee cascade;
drop table if exists department cascade;
drop table if exists employee cascade;

create table employee (
emp_no integer not null,
emp_title_id char(5),
birth_date date,
first_name varchar(50),
last_name varchar(50),
sex char(1),
hire_date date);

create table department (
dept_no char(5) not null,
dept_name varchar(50)
);

create table salary (
emp_no integer not null,
salary integer
);

create table title (
title_id char(5) not null,
title varchar(50)
);

create table department_manager (
dept_no char(5) not null,
emp_no integer not null
);

create table department_employee (
emp_no integer not null,
dept_no char(5) not null
);

alter table department add constraint PK_001 primary key (dept_no);
alter table salary add constraint PK_002 primary key (emp_no);
alter table title add constraint PK_003 primary key (title_id);
alter table department_manager add constraint PK_004 primary key (dept_no, emp_no);
alter table department_employee add constraint PK_005 primary key (emp_no, dept_no);
alter table employee add constraint PK_006 primary key (emp_no);
alter table employee add constraint FK_001 foreign key (emp_title_id) references title (title_id);
alter table salary add constraint FK_002 foreign key (emp_no) references employee (emp_no);
alter table department_employee add constraint FK_003 foreign key (emp_no) references employee (emp_no);
alter table department_employee add constraint FK_004 foreign key (dept_no) references department (dept_no);
alter table department_manager add constraint FK_005 foreign key (emp_no) references employee (emp_no);
alter table department_manager add constraint FK_006 foreign key (dept_no) references department (dept_no);


--1. List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT employee number, last_name, first_name, sex, salary
FROM employee 
LEFT JOIN salary
on salary.emp_no = employee.emp_no

--2. List employees who were hired in 1986.

SELECT * FROM employee
WHERE DATE_PART('year',hire_date) = 1986
order by emp_no

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

SELECT department_manager.dept_no, 
	   department.dept_name,
	   department_manager.emp_no,
	   employee.last_name,
	   employee.first_name
FROM department_Manager
INNER JOIN department ON
department_manager.dept_no = department.dept_no
INNER JOIN employee ON
department_manager.emp_no = employee.emp_no;

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT employee.emp_no,
       employee.last_name,
       employee.first_name,
	   department.dept_name
FROM employee
INNER JOIN department_manager ON employee.emp_no = department_manager.emp_no 
INNER JOIN department ON department_manager.dept_no = department.dept_no;

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT last_name,
       first_name,
	   Sex
FROM employee WHERE first_name = 'Hercules' and Last_name like 'B%';

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT employee.emp_no,
       employee.last_name,
       employee.first_name,
	   department.dept_name
FROM employee
INNER JOIN department_manager ON employee.emp_no = department_manager.emp_no 
INNER JOIN department ON department_manager.dept_no = department.dept_no WHERE department.dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT employee.emp_no,
       employee.last_name,
       employee.first_name,
	   department.dept_name
FROM employee
INNER JOIN department_manager 
ON employee.emp_no = department_manager.emp_no 
INNER JOIN department 
ON department_manager.dept_no = department.dept_no 
WHERE dept_name = 'Sales' OR dept_name = 'Development';

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name,
COUNT (last_name)
FROM employee 
GROUP BY last_name
HAVING COUNT (last_name)>1
ORDER BY last_name DESC;

SELECT last_name,COUNT(last_name)
FROM employee
GROUP BY last_name
HAVING COUNT(last_name)>1
ORDER BY last_name DESC;

