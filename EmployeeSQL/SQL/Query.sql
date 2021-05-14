select * from department;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;


-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.

select e.emp_no,e.last_name ,e.first_name, e.sex, s.salary
from employees as e
inner join salaries as s
on s.emp_no = e.emp_no;


--2. List first name, last name, and hire date for employees who were hired in 1986.

select first_name, last_name, hire_date
from employees
where hire_date BETWEEN '01/01/1986' AND '12/31/1986';

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

select dept_manager.dept_no, department.dept_name, dept_manager.emp_no , employees.last_name, employees.first_name
from dept_manager
inner join department
	on dept_manager.dept_no = department.dept_no
	inner join employees
		on dept_manager.emp_no = employees.emp_no;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.

select employees.emp_no, employees.last_name, employees.first_name, department.dept_name
from employees 
inner join dept_emp
	on employees.emp_no = dept_emp.emp_no
	inner join department
		on dept_emp.dept_no = department.dept_no;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

select first_name, last_name, sex
from employees
where first_name = 'Hercules' and last_name like 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

-- using join
select e.emp_no,e.last_name,e.first_name, d.dept_name
from employees as e 
inner join dept_emp as de
	on e.emp_no = de.emp_no
	inner join department as d
		on de.dept_no = d.dept_no
where d.dept_name ='Sales';

--using subquery
select emp_no, last_name, first_name, (select dept_name
								 		from department
								 		where dept_name = 'Sales') as "Department Name"
from employees 
where emp_no in (select emp_no 
				from dept_emp
				where dept_no in (select dept_no
								 from department
								 where dept_name = 'Sales'));

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

select e.emp_no,e.last_name,e.first_name, d.dept_name
from employees as e 
inner join dept_emp as de
	on e.emp_no = de.emp_no
	inner join department as d
		on de.dept_no = d.dept_no
where d.dept_name ='Sales' or d.dept_name ='Development';
			 		


-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

select last_name, count(last_name) as "Frequency"
from employees
group by last_name
order by "Frequency" Desc;