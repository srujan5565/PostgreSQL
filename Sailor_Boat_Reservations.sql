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
-- select sname
-- from sailors
-- where sid in(
-- 	select sid
-- 	from Reserves r
-- 	group by sid
-- 	having count(DISTINCT bid) = (
-- 		select count(DISTINCT bid)
-- 		from Boats
-- 	)
-- )

-- OR

-- SELECT s.sname
-- FROM Sailors s
-- WHERE NOT EXISTS (
--     SELECT *
--     FROM Boats b
--     WHERE NOT EXISTS (
--         SELECT *
--         FROM Reserves r
--         WHERE r.sid = s.sid
--           AND r.bid = b.bid
--     )
-- );



