-- Create Database
CREATE DATABASE SW;

-- Create Employee Table
	USE SW;
	CREATE TABLE EMPLOYEES 
	(EmployeeNo CHAR(10) NOT NULL UNIQUE,
	DepartmentName CHAR(30) NOT NULL DEFAULT 'Human Resources',
	FirstName CHAR(25) NOT NULL,
	LastName CHAR(25) NOT NULL,
	Category CHAR(20) NOT NULL,
	HourlyRate MONEY NOT NULL,
	TimeCard BIT NOT NULL,
	HourlySalaried CHAR(1)NOT NULL,
	EmpType CHAR(1) NOT NULL,
	Terminated BIT NOT NULL,
	ExemptCode CHAR(2) NOT NULL,
	Supervisor BIT NOT NULL,
	SupervisorName CHAR(50) NOT NULL,
	BirthDate DATE NOT NULL,
	CollegeDegree CHAR(5) NOT NULL,
	CONSTRAINT Employee_PK PRIMARY KEY(EmployeeNo)
	);

-- Create Department Table

	USE SW;
	CREATE TABLE DEPARTMENT
	(
	DepartmentName Char(35) NOT NULL,
	BudgetCode Char(30) NOT NULL,
	OfficeNumber Char(15) NOT NULL,
	Phone Char(15) NOT NULL,
	CONSTRAINT DEPARTMENT_PK PRIMARY KEY(DepartmentName)
);
-- Create Project Table

	USE SW;
	CREATE TABLE PROJECT
	(
	ProjectID Int NOT NULL IDENTITY (1000,100),
	ProjectName Char(50) NOT NULL,
	Department Char(35) NOT NULL,
	MaxHours Numeric(8,2) NOT NULL DEFAULT 100,
	StartDate DateTime NULL,
	EndDate DateTime NULL,
	CONSTRAINT ASSIGNMENT_PK PRIMARY KEY(ProjectID)
);
-- Create Assignment Table

	USE SW;
	CREATE TABLE ASSIGNMENT
	(
	ProjectID Int NOT NULL,
	EmployeeNumber Int NOT NULL,
	HoursWorked Numeric(6,2)NULL
);

