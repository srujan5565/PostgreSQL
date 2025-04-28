/*
create database codehelpBabbarSQL;
use codehelpBabbarSQL;

CREATE TABLE Worker (
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	SALARY INT(15),
	JOINING_DATE DATETIME,
	DEPARTMENT CHAR(25)
);

INSERT INTO Worker 
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');


CREATE TABLE Bonus (
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT(10),
	BONUS_DATE DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus 
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '16-02-20'),
		(002, 3000, '16-06-11'),
		(003, 4000, '16-02-20'),
		(001, 4500, '16-02-20'),
		(002, 3500, '16-06-11');
        
CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20 00:00:00'),
 (002, 'Executive', '2016-06-11 00:00:00'),
 (008, 'Executive', '2016-06-11 00:00:00'),
 (005, 'Manager', '2016-06-11 00:00:00'),
 (004, 'Asst. Manager', '2016-06-11 00:00:00'),
 (007, 'Executive', '2016-06-11 00:00:00'),
 (006, 'Lead', '2016-06-11 00:00:00'),
 (003, 'Lead', '2016-06-11 00:00:00');
 
 */
 
-- Q-1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.
select FIRST_NAME as WORKER_NAME from worker ;
-- Q-2. Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
select upper(FIRST_NAME) from worker;
-- Q-3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
select distinct(DEPARTMENT) from worker;
-- Q-4. Write an SQL query to print the first three characters of FIRST_NAME from Worker table.
select left(FIRST_NAME,3) from worker;
-- Q-5. Write an SQL query to find the position of the alphabet (‘b’) in the first name column ‘Amitabh’ from Worker table.
select instr(first_name,'b') from worker;
-- Q-6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.
select rtrim(first_name) from worker;
-- Q-7. Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.
select ltrim(department) from worker;
-- Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.
select distinct department,char_length(department) from worker;
-- Q-9. Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.
select replace(first_name,'a','A') from worker;
-- Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME. A space character should separate them.
select concat_ws(' ',first_name,last_name) as 'Full Name' from worker;
-- Q-11. Write an SQL query to print all Worker details from the Worker table ordered by FIRST_NAME ascending.
select * from worker order by first_name;
-- Q-12. Write an SQL query to print all Worker details from the Worker table ordered by FIRST_NAME ascending and DEPARTMENT descending.
select * from worker order by first_name, department desc;
-- Q-13. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.
select * from worker where first_name in ("Vipul","Satish");
-- Q-14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.
select * from worker where first_name not in ("Vipul","Satish");
-- Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.
select * from worker where department="Admin";
-- Q-16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
select * from worker where first_name like '%a%';
-- Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
select * from worker where first_name like '%a';
-- Q-18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
select * from worker where first_name like '_____h';
-- Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
select * from worker where salary between 100000 and 500000;
-- Q-20. Write an SQL query to print details of the Workers who have joined in Feb’2014.
select * from worker where joining_date between '2014-02-01' and '2014-02-28';
select * from worker where year(joining_date)=2014 and month(joining_date)=2;
-- Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
select count(*) from worker where department="Admin";
-- Q-22. Write an SQL query to fetch worker full names with salaries >= 50000 and <= 100000.
select * from worker where salary between 50000 and 100000;
-- Q-23. Write an SQL query to fetch the number of workers for each department in descending order.
select  department, count(department) from worker group by department order by count(department) desc;
-- Q-24. Write an SQL query to print details of the Workers who are also Managers.
select * from worker w join title t on w.worker_id=t.worker_ref_id where worker_title="manager";
-- Q-25. Write an SQL query to fetch number (more than 1) of same titles in the organization of different types.
select worker_title,count(worker_title) from title group by worker_title having count(worker_title)>1 ;
-- Q-26. Write an SQL query to show only odd rows from a table.
select * from worker where mod(worker_id,2)=1;
-- Q-27. Write an SQL query to show only even rows from a table.
select * from worker where mod(worker_id,2)=0;
-- Q-28. Write an SQL query to clone a new table from another table.
create table worker_clone as select * from worker;
create table worker_clone like worker; -- If you want to clone only structure
-- Q-29. Write an SQL query to fetch intersecting records of two tables.
select * from worker inner join worker_clone using(worker_id);
-- Q-30. Write an SQL query to show records from one table that another table does not have.
insert into worker values('21','adf','adfa',1234,'2024-04-24','HR');
-- has in left but not in right
select worker.* 
from worker
left join worker_clone on worker.worker_id = worker_clone.worker_id
where worker_clone.worker_id is null;
-- has in right but not in left
select worker_clone.* 
from worker
right join worker_clone on worker.worker_id = worker_clone.worker_id
where worker.worker_id is null;
-- Q-31. Write an SQL query to show the current date and time.
select now();
-- Q-32. Write an SQL query to show the top n (say 5) records of a table ordered by descending salary.
select * from worker order by salary desc limit 5;
-- Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.
select * from worker order by salary desc limit 1 offset 4;
-- Q-34. Write an SQL query to determine the 5th highest salary without using the LIMIT keyword. **
select salary from worker w1
WHERE 5 = (
SELECT COUNT(DISTINCT (w2.salary))
from worker w2
where w2.salary >= w1.salary
);
-- Q-35. Write an SQL query to fetch the list of employees with the same salary. **
select w1.* from worker w1, worker w2 where w1.salary = w2.salary and w1.worker_id != w2.worker_id;
select w1.* from worker w1 join worker w2 on w1.salary=w2.salary and w1.worker_id<>w2.worker_id;
-- Q-36. Write an SQL query to show the second highest salary from a table using sub-query.
select * from worker w1
where 2 = (
	select count( distinct salary)
    from worker w2
    where w2.salary>=w1.salary
);

select max(salary) from worker
where salary not in (select max(salary) from worker);
-- Q-37. Write an SQL query to show one row twice in results from a table.
select * from worker
UNION ALL
select * from worker ORDER BY worker_id;
-- Q-38. Write an SQL query to list worker_ids who do not get a bonus.
select * from worker where exists (select 1 from bonus where bonus.worker_ref_id=worker.worker_id );
-- Q-39. Write an SQL query to fetch the first 50% records from a table.
select * from worker where worker_id <(select count(*)/2 from worker);
-- Q-40. Write an SQL query to fetch the departments that have less than 4 people in them.
select department from worker group by department having count(worker_id)<4;
-- Q-41. Write an SQL query to show all departments along with the number of people in them.
select department,count(worker_id) from worker group by department;
-- Q-42. Write an SQL query to show the last record from a table.
select * from worker where worker_id = (select max(worker_id) from worker);
-- Q-43. Write an SQL query to fetch the first row of a table.
select * from worker where worker_id = (select min(worker_id) from worker);
-- Q-44. Write an SQL query to fetch the last five records from a table.
(select * from worker order by worker_id desc limit 5) order by worker_id;
SELECT w.*
FROM worker w
JOIN (
    SELECT worker_id
    FROM worker
    ORDER BY worker_id DESC
    LIMIT 5
) AS top_workers
ON w.worker_id = top_workers.worker_id;
-- Q-45. Write an SQL query to print the names of employees having the highest salary in each department.
select worker.department, worker.first_name, worker.salary from (select department, max(salary) as max_salary from worker group by department) temp
join worker on worker.department=temp.department and worker.salary=temp.max_salary;
-- Q-46. Write an SQL query to fetch three maximum salaries from a table using a co-related subquery.
select distinct salary from worker w1 
where 3 >=(
	select count( distinct salary) from worker w2 where w2.salary>=w1.salary
) order by salary desc ;
-- Q-47. Write an SQL query to fetch three minimum salaries from a table using a co-related subquery.
select distinct salary from worker w1 
where 3 > (
	select count( distinct salary) from worker w2 where w2.salary<w1.salary
) order by salary  ;
-- Q-48. Write an SQL query to fetch nth maximum salaries from a table. --(replace n)
select distinct salary from worker w1
where n >= (select count(distinct salary) from worker w2 where w1.salary <= w2.salary) order by w1.salary desc;
-- Q-49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
select department,sum(salary) from worker group by department;
-- Q-50. Write an SQL query to fetch the names of workers who earn the highest salary.
select concat(w.first_name,' ',w.last_name),w.salary from (select department, max(salary) as max_salary from worker group by department) temp
join worker w on w.department=temp.department and w.salary = temp.max_salary;


create table pairs(
A int,
B int
);
insert into pairs values(1,2),(3,4),(5,3),(5,7),(2,8),(2,1),(4,3),(3,5),(7,5);
select * from pairs;
-- print only one pair at once without its reverse
-- Using joins
select p1.* from pairs p1 left join pairs p2 on p1.a=p2.b and p2.a=p1.b where p1.a<p2.a or p2.a is null;

-- Using correlated subquery
select * from pairs p1 where not exists (
	select 1 from pairs p2 where p1.a=p2.b and p2.a=p1.b and p1.a>p2.a
);





