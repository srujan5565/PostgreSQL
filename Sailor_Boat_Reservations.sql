-- create table Sailors(
-- 	sid INTEGER PRIMARY KEY,
-- 	sname VARCHAR(45),
-- 	rating INTEGER,
-- 	age INTEGER
-- );

-- b(bid, bname, color)

-- Create table Boats(
-- 	bid INTEGER PRIMARY KEY,
-- 	bname VARCHAR(45),
-- 	color VARCHAR(15)
-- );

-- r (sid, bid, date)
-- Create table Reserves(
-- 	sid INTEGER REFERENCES Sailors(sid),
-- 	bid INTEGER REFERENCES Boats(bid),
-- 	date DATE
-- );

-- ALTER TABLE Reserves
-- ADD CONSTRAINT PK_my_table_new
-- PRIMARY KEY (sid, bid, date);



-- INSERT INTO Sailors (sid, sname, rating, age) VALUES
-- (1, 'Albert', 7, 25.5),
-- (2, 'Bob', 5, 30.0),
-- (3, 'Charlie', 8, 35.0),
-- (4, 'David', 9, 45.0),
-- (5, 'Eve', 7, 22.0),
-- (6, 'Frank', 8, 55.0);
-- INSERT INTO Boats (bid, bname, color) VALUES
-- (101, 'Red Storm', 'Red'),
-- (102, 'Blue Thunder', 'Blue'),
-- (103, 'Sea Breeze', 'Green'),
-- (104, 'Typhoon One', 'Yellow'),
-- (105, 'Typhoon Two', 'White');
-- INSERT INTO Reserves (sid, bid, date) VALUES
-- (1, 101, '2024-04-20'),  -- Albert reserves Red Storm
-- (1, 103, '2024-04-21'),  -- Albert reserves Sea Breeze
-- (2, 102, '2024-04-22'),  -- Bob reserves Blue Thunder
-- (3, 103, '2024-04-22'),  -- Charlie reserves Sea Breeze
-- (3, 104, '2024-04-23'),  -- Charlie reserves Typhoon One
-- (4, 103, '2024-04-23'),  -- David reserves Sea Breeze
-- (5, 105, '2024-04-24'),  -- Eve reserves Typhoon Two
-- (6, 104, '2024-04-24'),  -- Frank reserves Typhoon One
-- (6, 105, '2024-04-25');  -- Frank reserves Typhoon Two


-- 1. Find the colors of boats reserved by Albert.
-- select b.color
-- from Sailors s
-- join Reserves r
-- on s.sid=r.sid
-- join Boats b
-- on b.bid=r.bid
-- where s.sname='Albert';

-- 2. Find all sailor id’s of sailors who have a rating of at least 8 or reserved boat 103.
-- select DISTINCT s.sid
-- from Sailors s
-- join Reserves r
-- on s.sid=r.sid
-- where s.rating>=8 or r.bid=103;

-- OR

-- (SELECT sid
--  FROM Sailors
--  WHERE rating >= 8)
-- UNION
-- (SELECT sid
--  FROM Reserves
--  WHERE bid = 103);


-- 3. Find the names of sailors who have not reserved a boat whose name contains the string “storm”. Order the names in ascending order.
-- select DISTINCT sname
-- from Sailors 
-- where sid NOT IN (
-- 	select sid
-- 	from Reserves r
-- 	join Boats b
-- 	on b.bid=r.bid
-- 	where bname LIKE '%storm%'
-- )
-- order by sname;

-- 4. Find the sailor id’s of sailors with age over 20 who have not reserved a boat whose name includes the string “thunder”.
-- select sid
-- from sailors
-- where age>20
-- and sid not in (
-- 	select sid
-- 	from Reserves r
-- 	join Boats b
-- 	on r.bid=b.bid
-- 	where b.bname LIKE '%thunder%'
-- )

-- 5.Find the names of sailors who have reserved at least two boats.
-- select sname
-- from sailors
-- where sid in (
-- 	select sid
-- 	from Reserves
-- 	group by sid 
-- 	having count(DISTINCT bid)>1 -- Gives incorrect if. reserved the same boat twice (on different dates), So DISTINCT is used.
-- )

-- 6. Find the names of sailors who have reserved all boats.
select sname
from sailors
where sid in(
	select sid
	from Reserves r
	group by sid
	having count(DISTINCT bid) = (
		select count(DISTINCT bid)
		from Boats
	)
);

-- OR

SELECT s.sname
FROM Sailors s
WHERE NOT EXISTS (
    SELECT *
    FROM Boats b
    WHERE NOT EXISTS (
        SELECT *
        FROM Reserves r
        WHERE r.sid = s.sid
          AND r.bid = b.bid
    )
);

-- 7. Find the names of sailors who have reserved all boats whose name starts with “typhoon”.
select sname
from Sailors s
where not exists(
	select *
	from boats b
	where not exists(
		select *
		from Reserves r
		where r.sid=s.sid and r.bid=b.bid
	)
	 and b.bname LIKE 'typhoon%'
);

-- 8.Find the sailor id’s of sailors whose rating is better than some sailor called Bob
select s1.sid
from Sailors s1,Sailors s2
where s2.sname='Bob' and s1.rating > s2.rating ;


-- OR


SELECT sid
FROM Sailors
WHERE rating > ( 
    SELECT rating
    FROM Sailors
    WHERE sname = 'Bob'
);

-- 9. Find the sailor id’s of sailors whose rating is better than every sailor called Bob.
select sid
from sailors
where rating > all (
	select rating
	from sailors
	where sname='Bob'
);

-- 10. Find the sailor id(s) of sailors with the highest rating.
select sid
from sailors
where rating = (
	select max(rating)
	from sailors
);

-- 11. Find the name and age of the oldest sailor.
select sname,age
from sailors
where age = (
	select max(age)
	from sailors
);

--or

select sname,age
from sailors
where age >= all (
	select age
	from sailors
);


-- 12. Find the names of sailors who have reserved every boat reserved by those with a lower rating.
select sname
from sailors s1
where not exists (
	select 1
	from sailors s2
	join reserves r1 on r1.sid=s2.sid
	join boats b1 on b1.bid=r1.bid
	where s1.rating>s2.rating and not exists (
		select 1
		from reserves r2
		where r2.sid=s1.sid and r2.bid=b1.bid
	)
);

-- NOT EXISTS (SELECT * FROM Boats WHERE NOT EXISTS (reservation))

-- Reads like:
--  "There is no boat which I didn't reserve."



-- If you want to check...	Use...
-- "Has at least one"	EXISTS
-- "Has none"	NOT EXISTS
-- "Has everything" (ALL)	NOT EXISTS (NOT EXISTS)

-- 13. For each rating, find the average age of sailors at that level of rating
select rating,ROUND(avg(age),2)
from sailors
group by rating;

-- 14. For each boat which was reserved by at least 5 distinct sailors, find the boat id and the average age of sailors who reserved it.
select r.bid, ROUND(avg(age),2) as avg_age
from sailors s
join reserves r
on s.sid=r.sid
join boats b
on b.bid=r.bid
group by r.bid
having count(DISTINCT r.sid) >=5;

--15. For each boat which was reserved by at least 5 sailors with age >= 40, find the boat id and the average age of such sailors.

select r.bid, ROUND(avg(s.age),2) as avg_age
from sailors s
join reserves r
on s.sid=r.sid
join boats b
on r.bid=b.bid
where age >=40
group by r.bid
having count(DISTINCT r.sid) >=5;


-- SQL queries using EXISTS, NOT EXISTS, IN, NOT IN

-- Find all sailors who have reserved at least one boat.
select * 
from sailors s
where exists (
	select 1 
	from reserves r
	where r.sid=s.sid
);


-- Find all sailors who have not reserved any boat.

select * 
from sailors s
where not exists (
	select 1 -- The SELECT 1 inside the subquery is just a placeholder, meaning "return some value"
	from reserves r
	where r.sid=s.sid
);


-- Find the names of all sailors who have reserved a boat that is either 'Red Storm' or 'Blue Thunder'.
SELECT s.sname
FROM Sailors s
WHERE s.sid IN (
    SELECT r.sid
    FROM Reserves r
    JOIN Boats b ON r.bid = b.bid
    WHERE b.bname IN ('Red Storm', 'Blue Thunder')
);

-- Find all sailors who have reserved a boat after '2024-04-22'.
SELECT s.*, r.date
FROM sailors s
JOIN reserves r ON s.sid = r.sid
WHERE r.date > '2024-04-22';

--Using EXISTS

select *
from sailors s
where exists (
	select 1
	from reserves r
	where r.sid=s.sid
	and date > '2024-04-22'
);


-- Find sailors who have reserved boats that are either 'Typhoon One' or 'Typhoon Two'.
select s.sname
from sailors s
where exists (
	select 1
	from reserves r
	join boats b
	on r.bid=b.bid
	where s.sid=r.sid
	and bname in ('Typhoon One','Typhoon Two')
);

-- using IN
select sname 
from sailors
where sid in (
	select sid
	from reserves r
	join boats b
	on r.bid =b.bid
	where bname in ('Typhoon One','Typhoon Two')
);





select sname
from sailors s1
where not exists (
	select 1
	from sailors s2
	join reserves r1 on r1.sid=s2.sid
	join boats b1 on b1.bid=r1.bid
	where s1.rating>s2.rating and not exists (
		select 1
		from reserves r2
		where r2.sid=s1.sid and r2.bid=b1.bid
	)
);




select sname 
from sailors s
where exists(
	select 1
	from reserves r
	where s.sid=r.sid
);









