-- cr-company.sql
-- creates the COMPANY DB-schema
-- partial

-- ALSO SEE figures 4.1 and 4.2 of Text (Elmasri 6th Ed.)

-- keep these two commands at the top of every sql file
set echo on
set linesize 120

drop table Employee cascade constraints;
commit;

create table Employee 
(
	fname varchar(15),
	minit varchar(1),
	lname varchar (15),
	ssn char(9),
	bdate date,
	address varchar(30),
	sex varchar(1) 	CHECK(Sex = 'M' or Sex = 'F'),
	salary number, -- need to put check on salary 
	superssn char(9),
	dno number	DEFAULT 0,
	constraint EMPPK
	    primary key(ssn),
	constraint EMPSUPERVRFK
	    foreign key(superssn) references Employee(ssn)
	    	ON DELETE SET NULL
--
--   Note:
--	ON DELETE SET DEFAULT, ON UPDATE CASCADE
-- Oracle does not support cascading updates, and does not allow you to set the value to the default 
-- when the parent row is deleted. Your two options for an on delete behavior are cascade or set null. 
-- Tested: February 05, 2018
--	, constraint EMPDEPTFK 
--		foreign key(dno) references Department(dnumber) 
--			ON DELETE SET NULL
-- ERROR - Department2 table has not been created yet
-- need to postpone this constraint
-- use alter table command to add this constraint
-- alter table Employee add constraint EMPDEPTFK 
--     foreign key(dno) references Department(dnumber) 
--     ON DELETE SET NULL
--
);

drop table Department cascade constraints;
commit;
create table Department 
(
	dname varchar(15) 	NOT NULL,
	dnumber number,
	mgrssn char(9)		DEFAULT '000000000',
	mgrstartdate date,
	constraint DEPTPK
	    primary key(dnumber),
	constraint DEPTMGRFK
	    foreign key(mgrssn) references Employee(ssn)
			ON DELETE SET NULL 
--
--		ON DELETE SET DEFAULT, ON UPDATE CASCADE  
--
-- The above actions for DELETE SET DEFAULT and for UPDATE CASCADE does not work
-- with  the current SQL-plus version we have at this time. 
-- Just use SET NULL for delete and disable the update action part of the constraint.
--
);

alter table Employee add 
	constraint EMPDEPTFK foreign key(dno) references Department(dnumber) 
	ON DELETE SET NULL;
	
	
drop table DEPT_LOCATION cascade constraints; 
commit;
create table DEPT_LOCATION
(
      dnumber number(5),
      dlocation varchar(15),
      constraint DEPLSPK	  
          primary key(dnumber, dlocation),
	  constraint DEPLMGRFK 
	      foreign key(dnumber) references department(dnumber)
		      ON DELETE SET NULL		  
);

drop table PROJECT cascade constraints;
commit;
create table PROJECT
(
    pname varchar(15),
    pnumber number, 
	plocation char(15),
	dnum number,
	   constraint PROJECTSPK
	       primary key( pnumber),
	   constraint  PROJECTDNOFK
	       foreign key(dnum) references Department( dnumber)
		       ON DELETE SET NULL 
);
			   
drop table WORKS_ON cascade constraint;
commit;
create table WORKS_ON
(
      essn char(9),
	  pno number,
	  hours number,
	  constraint WORKS_ONSPK
	       primary key(essn, pno),
	  constraint WORKS_ONESSNFK
		   foreign key (essn) references employee(ssn)
		        ON DELETE SET NULL,
	  constraint WORKS_ONPNOFK
		   foreign key (pno) references Project(pnumber)
				ON DELETE SET NULL	
);

drop table DEPENDENT cascade constraints;
commit;
create table DEPENDENT
(
       essn char(9),
	   dependent_name varchar(15),
	   sex char,
	   bdate date,
	   relationship varchar(8),
	  constraint DEPENDENTSPK
	       primary key(essn,dependent_name),
       constraint DEPENDENTESSNFK
	       foreign key (essn) references Employee(ssn)  
		 ON DELETE SET NULL
);


