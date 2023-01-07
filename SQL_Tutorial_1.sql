drop database if exists DB_Employee;
drop database if exists sql_store;
create database DB_Employee;
use DB_Employee;

# Creation of Table for employee, manager, work and company.
create table TBL_Employee(
	employee_name varchar(255) primary key,
	company_name varchar(255),
    city_name varchar(255),
    street_name varchar(255)
    );

create table TBL_Work(
	employee_name varchar(255) primary key,
    company_name varchar(255),
    salary int
    );

create table TBL_Manager(
	employee_name varchar(255) primary key,
    manager_name varchar(255) 
    );

create table TBL_Company(
	company_name varchar(255) primary key,
    city_name varchar(255) 
    );

# Adding foreign key 
alter table TBL_Work
	add foreign key (employee_name) references TBL_Employee(employee_name),
	add foreign key (company_name) references TBL_Company (company_name);

alter table TBL_Manager
	add foreign key (employee_name) references TBL_Employee (employee_name);

# Insertion of data in Tables
insert into TBL_Employee (employee_name, city_name, street_name)
values	('Ram Prasad Khanal', 'Kathmandu', 'Jawalakhel Chowk'),
		('Sita Devi', 'Pokhara', 'New Road'),
        ('Hari Kumar', 'Bhaktapur', 'Dattatreya Square'),
        ('Krishna Maharjan', 'Lalitpur', 'Patan Durbar Square'),
		('Binita Thapa', 'Biratnagar', 'Mahabir Market'),
		('Narayan Shah', 'Dharan', 'Bhanu Chowk'),
		('Jones', 'Birgunj', 'Inaruwa Chowk'),
		('Amit Bhandari', 'Nepalgunj', 'Shiva Mandir'),
		('Santosh Pokharel', 'Dhangadhi', 'Durga Temple'),
		('Sabita Thakur', 'Bhairahawa', 'Lumbini Temple');

# Visualization of Table
select * from TBL_Employee;

insert into TBL_Work (employee_name, company_name, salary)
values	('Ram Prasad Khanal', 'First Bank Corporation', 5000),
		('Sita Devi', 'Small Bank Corporation', 8000),
		('Hari Kumar', 'Small Bank Corporation', 7000),
		('Krishna Maharjan', 'First Bank Corporation', 10000),
		('Binita Thapa', 'Small Bank Corporation', 12000),
		('Narayan Shah', 'First Bank Corporation', 4000),
		('Jones', 'Small Bank Corporation', 6000),
		('Amit Bhandari', 'First Bank Corporation', 50000),
		('Santosh Pokharel', 'Small Bank Corporation', 8000),
		('Sabita Thakur', 'First Bank Corporation', 30000);

select * from TBL_Work;

insert into TBL_Company (company_name, city_name)
values	('First Bank Corporation', 'Kathmandu'),
		('Small Bank Corporation', 'Rupandehi');

select * from TBL_Company;

insert into TBL_Manager (employee_name, manager_name)
values	('Ram Prasad Khanal', 'Krishna Maharjan'),
		('Narayan Shah', 'Amit Bhandari'),
		('Sita Devi', 'Hari Kumar'),
		('Binita Thapa', 'Jones'),
		('Santosh Pokharel', 'Sabita Thakur');

select *from TBL_Manager;

# Q2

select employee_name from TBL_Work where company_name = 'First Bank Corporation';

select employee_name, city_name from TBL_Employee where employee_name in
	(select employee_name from TBL_Work where company_name = 'First Bank Corportation');

select * from TBL_Employee where employee_name in
	(select employee_name from TBL_Work where company_name = 'First Bank Corportation' and salary > 10000);

select * from TBL_Employee e where e.city_name = 
	(select city_name from TBL_Company c where c.company_name =
		(select company_name from TBL_Work w where w.employee_name = e.employee_name));


select * from TBL_Employee e where e.city_name = 
	(select city_name from TBL_Employee where TBL_Employee.employee_name in 
		(select manager_name from TBL_Manager m where m.employee_name = e.employee_name));

select employee_name from TBL_Work where company_name != 'First Bank Corporation';

select employee_name from TBL_Work where salary > 
	(select max(salary) from TBL_Work natural join TBL_Company where company_name = 'Small Bank Corporation');

select company_name from TBL_Company where city_name in 
	(select city from TBL_Company where company_name = 'Small Bank Corporation');
    
select employee_name from TBL_Work where salary >
	(select avg(salary) from TBL_Work ws where ws.company_name = TBL_Work.company_name);

# Q3
select * from TBL_Employee;

update TBL_Employee
	set city_name = 'Lalitpur' and street_name = 'Patan' where employee_name = 'Jones';

select * from TBL_Work;

update TBL_work set salary =
	salary * 1.1 where company_name = 'First Bank Corporation';
    
select * from TBL_Work;

update TBL_Work set salary = 
	case
		when salary < 10000 then salary * 1.1
        else salary * 1.3
	end
	where TBL_Work.employee_name in(
		select TBL_Manager.employee_name from TBL_Manager where
        TBL_Manager.manager_name = TBL_Work.employee_name and TBL_Work.company_name = 'First Bank Corporation'
        );
        
select * from TBL_Work, TBL_Manager where 
	TBL_Manager.manager_name = TBL_Work.company_name = 'First Bank Corporation';
    
delete from TBL_Work where company_name = 'Small Bank Corporation';
