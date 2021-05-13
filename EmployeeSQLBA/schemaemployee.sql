--creating table schema 

-- titles table title_id,title
create table titles (
	title_id varchar not null,
	title varchar not null,
	primary key (title_id)
);

select * 
from titles;

-- employees table emp_no,emp_title_id,birth_date,first_name,last_name,sex,hire_date
create table employees (
	emp_no int not null,
	emp_title_id varchar not null,
	birth_date date not null,
	first_name varchar not null,
	last_name varchar not null,
	sex varchar,
	hire_date date not null,
	primary key (emp_no),
	foreign key (emp_title_id) references titles (title_id)
);
	
-- departments table "dept_no","dept_name"
create table departments 
	(dept_no varchar not null,
	 dept_name varchar not null,
	 primary key (dept_no)
	);

-- department manager table 
create table departments_manager
	(dept_no varchar not null,
	 emp_no int not null,
	 primary key (dept_no,emp_no),
	 foreign key (emp_no) references employees (emp_no),
	 foreign key (dept_no) references departments (dept_no)
	);

-- department employee table
create table departments_employees
	( emp_no int not null,
	 dept_no varchar not null,
	 primary key (dept_no,emp_no),
	 foreign key (emp_no) references employees (emp_no),
	 foreign key (dept_no) references departments (dept_no)
	);

-- salaries table
create table salaries
	(emp_no int not null,
	 salaries int not null,
	 primary key (emp_no),
	 foreign key (emp_no) references employees (emp_no)
	);