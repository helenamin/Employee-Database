# Employee Database: A Mystery in Two Parts


## Background

This is a research project on employees of a corporation from the 1980s and 1990s. All that remain of the database of employees from that period are six CSV files.

In this Project, I've design the tables to hold data in the CSVs, import the CSVs into a SQL database, and answer some questions about the data. In other words, you will perform:


#### Data Modeling

After inspecting  the CSVs, I've sketched out an ERD of the tables using [http://www.quickdatabasediagrams.com](http://www.quickdatabasediagrams.com).

![Physical Schema](EmployeeSQL/ERD_Image/Physical_schema.png)

#### Data Engineering

* I've used this table schema to create tables required for each of the six CSV files.

```
CREATE TABLE "department" (
    "dept_no" VARCHAR(4)   NOT NULL PRIMARY KEY,
    "dept_name" VARCHAR   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(5)   NOT NULL PRIMARY KEY,
    "title" VARCHAR   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL PRIMARY KEY,
    "emp_title_id" VARCHAR(5)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR(1)   NOT NULL,
    "hire_date" date   NOT NULL,
	FOREIGN KEY("emp_title_id") REFERENCES "titles" ("title_id")
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(4)   NOT NULL,
	FOREIGN KEY("emp_no") REFERENCES "employees" ("emp_no"),
	FOREIGN KEY("dept_no") REFERENCES "department" ("dept_no"),
	Primary Key ("emp_no","dept_no")
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(4)   NOT NULL,
    "emp_no" INT   NOT NULL,
	FOREIGN KEY("emp_no") REFERENCES "employees" ("emp_no"),
	FOREIGN KEY("dept_no") REFERENCES "department" ("dept_no"),
	Primary Key ("emp_no","dept_no")
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
	FOREIGN KEY("emp_no") REFERENCES "employees" ("emp_no"),
	Primary Key ("emp_no", "salary")
);


```

  * The tables have been created in a order to be able to handle foreign keys.

* Then I imported CSV files into the corresponding SQL tablein the same order that tables were created.

#### Data Analysis

Once I got a complete database, Then started answering these question:

1. List the following details of each employee: employee number, last name, first name, sex, and salary.
    ```
    select e.emp_no,e.last_name ,e.first_name, e.sex, s.salary
    from employees as e
    inner join salaries as s
    on s.emp_no = e.emp_no;
    ``` 

2. List first name, last name, and hire date for employees who were hired in 1986.
    ```
    select first_name, last_name, hire_date
    from employees
    where hire_date BETWEEN '01/01/1986' AND '12/31/1986';
    ```

3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

    ```
    select dept_manager.dept_no, department.dept_name, dept_manager.emp_no , employees.last_name, employees.first_name
    from dept_manager
    inner join department
	  on dept_manager.dept_no = department.dept_no
	  inner join employees
		on dept_manager.emp_no = employees.emp_no;
    ```

4. List the department of each employee with the following information: employee number, last name, first name, and department name.

5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

## Bonus (Optional)

As you examine the data, you are overcome with a creeping suspicion that the dataset is fake. You surmise that your boss handed you spurious data in order to test the data engineering skills of a new employee. To confirm your hunch, you decide to take the following steps to generate a visualization of the data, with which you will confront your boss:

1. Import the SQL database into Pandas. (Yes, you could read the CSVs directly in Pandas, but you are, after all, trying to prove your technical mettle.) This step may require some research. Feel free to use the code below to get started. Be sure to make any necessary modifications for your username, password, host, port, and database name:

   ```sql
   from sqlalchemy import create_engine
   engine = create_engine('postgresql://localhost:5432/<your_db_name>')
   connection = engine.connect()
   ```

* Consult [SQLAlchemy documentation](https://docs.sqlalchemy.org/en/latest/core/engines.html#postgresql) for more information.

* If using a password, do not upload your password to your GitHub repository. See [https://www.youtube.com/watch?v=2uaTPmNvH0I](https://www.youtube.com/watch?v=2uaTPmNvH0I) and [https://help.github.com/en/github/using-git/ignoring-files](https://help.github.com/en/github/using-git/ignoring-files) for more information.

2. Create a histogram to visualize the most common salary ranges for employees.

3. Create a bar chart of average salary by title.

## Epilogue

Evidence in hand, you march into your boss's office and present the visualization. With a sly grin, your boss thanks you for your work. On your way out of the office, you hear the words, "Search your ID number." You look down at your badge to see that your employee ID number is 499942.

## Submission

* Create an image file of your ERD.

* Create a `.sql` file of your table schemata.

* Create a `.sql` file of your queries.

* (Optional) Create a Jupyter Notebook of the bonus analysis.

* Create and upload a repository with the above files to GitHub and post a link on BootCamp Spot.

### Copyright

© 2021 Trilogy Education Services, LLC, a 2U, Inc. brand. Confidential and Proprietary. All Rights Reserved.
