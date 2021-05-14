ALTER DATABASE "Employee_DB" SET datestyle TO "ISO, MDY";

-- Physical schema


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

