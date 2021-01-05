-- q-company.sql
-- partial queries

-- keep these two commands at the top of every sql file
set echo on
set linesize 120

-- test queries, not to be submitted
select * from employee;
select * from department;
select count(*) from employee;
select count(*) as DEPT_COUNT from department;

-- comment out the above queries for your homework

-- your homework queries goes here

-- A: the first name, last name of every employee and name of his/her department

-- 'as' is optional and can be omitted
-- FIRST_NAME, LAST_NAME, DEPARTMENT_NAME are column aliases
-- E, D are table aliases

select E.fname as FIRST_NAME, E.lname as LAST_NAME, D.dname as DEPARTMENT_NAME
from employee E, department D
where E.dno = D.dnumber;

-- B. the first name , last name of employees who works in the project called 'computerization')
select E.fname as FIRST_NAME, E.lname as LAST_NAME, P.pname as PROJECT_NAME
from employee E, project P, works_on w
where P.pname = 'Computerization' and pnumber = pno and ssn = essn;

--C. Find the names of all employees who are directly supervised by 'Franklin Wong'.
select e.fname, e.lname from employee e, employee s where e.superssn = s.ssn and s.fname ='Franklin' and s.lname = 'Wong';

--d. Retrieve the names of all employees in department 5 who work more than 10 hours per week on the 'ProductX' project
select e.fname as first_name, e.lname last_name from employee e, project p, works_on w where e.dno = 5 and p.pname ='productX' and w.hours >10 and p.pnumber = w.pno and e.ssn = w.essn;

--E. For each department, retrieve the department name and the average salary of all employees working in that department
select dname, avg(salary) from (employee join department on dno = dnumber) group by (dname, dno) order by dno;

--F. List the last names of all department managers who have no dependents.
select e.fname, e.lname from employee e where exists(select * from dependent dp where e.ssn = dp.essn);

--G. Retrieve the average salary of all female employees
select avg(salary) from employee where sex= 'F';

--H.I The name of every table. and The name of every column, the table it belongs to, its data type and its size in bytes
--(order by the table name).

select TABLE_NAME || ', ' || TABLE_TYPE from cat order by TABLE_NAME;

--The name of every constraint, its type and the table it belongs to (order by the table name).

select TABLE_NAME || ', ' || TABLE_TYPE from cat where TABLE_NAME not like 'BIN$%'
order by TABLE_NAME;

select TNAME || ', ' || TABTYPE from tab where TNAME not like 'BIN$%' order by TNAME;

select tname || ', ' || cname || ', ' || coltype || ', ' || width as colInfo from col 
where tname not like 'BIN$%'
order by tname, cname;

select table_name || ', ' || constraint_name || ', ' || constraint_type as costraintInfo from user_constraints 
where table_name not like 'BIN$%'
order by table_name, constraint_name;

