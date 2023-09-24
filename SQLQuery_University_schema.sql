--Create and use database

create database university
use university

--Create Tables
create table classroom 
(building		varchar(15),
room_number		varchar(7),
capacity		numeric(4,0),
primary key (room_number)
);

create table department
(dept_name		varchar(20),
building		varchar(15),
budget		        numeric(12,2) check (budget > 0),
primary key (dept_name)
);

create table course
(course_id		varchar(8),
title			varchar(50),
dept_name		varchar(20),
credits		numeric(2,0) check (credits > 0),
primary key (course_id),
foreign key (dept_name) references department (dept_name)
on delete set null
);
create table instructor
(ID			varchar(5),
name			varchar(20) not null,
dept_name		varchar(20),
salary			numeric(8,2) check (salary > 29000),
primary key (ID),
foreign key (dept_name) references department (dept_name)
on delete set null
);
create table time_slot
	(id int primary key,
	time_slot_id		varchar(4),
	 day			varchar(1),
	 start_hr		numeric(2) check (start_hr >= 0 and start_hr < 24),
	 start_min		numeric(2) check (start_min >= 0 and start_min < 60),
	 end_hr			numeric(2) check (end_hr >= 0 and end_hr < 24),
	 end_min		numeric(2) check (end_min >= 0 and end_min < 60)
	);

create table section
	(course_id		varchar(8), 
         sec_id			varchar(8),
	 semester		varchar(6)
		check (semester in ('Fall', 'Winter', 'Spring', 'Summer')), 
	 year			numeric(4,0) check (year > 1701 and year < 2100), 
	 building		varchar(15),
	 room_number		varchar(7),
	 time_slot_id		varchar(4),
	 id int,
	 primary key (course_id, sec_id, semester, year),
	 foreign key (course_id) references course (course_id)
		on delete cascade,
	 foreign key (room_number) references classroom (room_number)
		on delete set null,
	 foreign key (id) references time_slot (id)
		on delete set null,
	);
create table teaches
(ID			varchar(5),
course_id		varchar(8),
sec_id			varchar(8),
semester		varchar(6),
year			numeric(4,0),
primary key (ID, course_id, sec_id, semester, year),
foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
on delete cascade,
foreign key (ID) references instructor (ID)
on delete cascade
);

create table student
(ID			varchar(5),
name			varchar(20) not null,
dept_name		varchar(20),
tot_cred		numeric(3,0) check (tot_cred >= 0),
primary key (ID),
foreign key (dept_name) references department (dept_name)
on delete set null
);

create table takes
(ID			varchar(5),
course_id		varchar(8),
sec_id			varchar(8),
semester		varchar(6),
year			numeric(4,0),
grade		        varchar(2),
primary key (ID, course_id, sec_id, semester, year),
foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
on delete cascade,
foreign key (ID) references student (ID)
on delete cascade
);

create table advisor
(s_ID			varchar(5),
i_ID			varchar(5),
primary key (s_ID),
foreign key (i_ID) references instructor (ID)
on delete set null,
foreign key (s_ID) references student (ID)
on delete cascade
);

create table prereq
(course_id		varchar(8),
prereq_id		varchar(8),
primary key (course_id, prereq_id),
foreign key (course_id) references course (course_id)
on delete cascade,
foreign key (prereq_id) references course (course_id)
);



--Inserting Values

insert into classroom values ('Packard', '101', '500');
insert into classroom values ('Painter', '514', '10');
insert into classroom values ('Taylor', '3128', '70');
insert into classroom values ('Watson', '100', '30');
insert into classroom values ('Watson', '120', '50');
insert into classroom values ('Taylor', '112', '30');
insert into classroom values ('Painter', '234', '50');
insert into classroom values ('Packard', '303', '56');


insert into department values ('Biology', 'Watson', '90000');
insert into department values ('Comp. Sci.', 'Taylor', '100000');
insert into department values ('Elec. Eng.', 'Taylor', '85000');
insert into department values ('Finance', 'Painter', '120000');
insert into department values ('History', 'Painter', '50000');
insert into department values ('Music', 'Packard', '80000');
insert into department values ('Physics', 'Watson', '70000');

insert into course values ('BIO-101', 'Intro. to Biology', 'Biology', '4');
insert into course values ('BIO-301', 'Genetics', 'Biology', '4');
insert into course values ('BIO-399', 'Computational Biology', 'Biology', '3');
insert into course values ('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', '4');
insert into course values ('CS-190', 'Game Design', 'Comp. Sci.', '4');
insert into course values ('CS-315', 'Robotics', 'Comp. Sci.', '3');
insert into course values ('CS-319', 'Image Processing', 'Comp. Sci.', '3');
insert into course values ('CS-347', 'Database System Concepts', 'Comp. Sci.', '3');
insert into course values ('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', '3');
insert into course values ('FIN-201', 'Investment Banking', 'Finance', '3');
insert into course values ('HIS-351', 'World History', 'History', '3');
insert into course values ('MU-199', 'Music Video Production', 'Music', '3');
insert into course values ('PHY-101', 'Physical Principles', 'Physics', '4');


insert into instructor values ('10101', 'Srinivasan', 'Comp. Sci.', '65000');
insert into instructor values ('12121', 'Wu', 'Finance', '90000');
insert into instructor values ('15151', 'Mozart', 'Music', '40000');
insert into instructor values ('22222', 'Einstein', 'Physics', '95000');
insert into instructor values ('32343', 'El Said', 'History', '60000');
insert into instructor values ('33456', 'Gold', 'Physics', '87000');
insert into instructor values ('45565', 'Katz', 'Comp. Sci.', '75000');
insert into instructor values ('58583', 'Califieri', 'History', '62000');
insert into instructor values ('76543', 'Singh', 'Finance', '80000');
insert into instructor values ('76766', 'Crick', 'Biology', '72000');
insert into instructor values ('83821', 'Brandt', 'Comp. Sci.', '92000');
insert into instructor values ('98345', 'Kim', 'Elec. Eng.', '80000');


insert into section values ('BIO-101', '1', 'Summer', '2017', 'Painter', '514', 'B',1);
insert into section values ('BIO-301', '1', 'Summer', '2018', 'Painter', '514', 'A',2);
insert into section values ('CS-101', '1', 'Fall', '2017', 'Packard', '101', 'H',3);
insert into section values ('CS-101', '1', 'Spring', '2018', 'Packard', '101', 'F',4);
insert into section values ('CS-190', '1', 'Spring', '2017', 'Taylor', '3128', 'E',5);
insert into section values ('CS-190', '2', 'Spring', '2017', 'Taylor', '3128', 'A',6);
insert into section values ('CS-315', '1', 'Spring', '2018', 'Watson', '120', 'D',7);
insert into section values ('CS-319', '1', 'Spring', '2018', 'Watson', '100', 'B',8);
insert into section values ('CS-319', '2', 'Spring', '2018', 'Taylor', '3128', 'C',9);
insert into section values ('CS-347', '1', 'Fall', '2017', 'Taylor', '3128', 'A',10);
insert into section values ('EE-181', '1', 'Spring', '2017', 'Taylor', '3128', 'C',11);
insert into section values ('FIN-201', '1', 'Spring', '2018', 'Packard', '101', 'B',12);
insert into section values ('HIS-351', '1', 'Spring', '2018', 'Painter', '514', 'C',13);
insert into section values ('MU-199', '1', 'Spring', '2018', 'Packard', '101', 'D',14);
insert into section values ('PHY-101', '1', 'Fall', '2017', 'Watson', '100', 'A',15);



insert into teaches values ('10101', 'CS-101', '1', 'Fall', '2017');
insert into teaches values ('10101', 'CS-315', '1', 'Spring', '2018');
insert into teaches values ('10101', 'CS-347', '1', 'Fall', '2017');
insert into teaches values ('12121', 'FIN-201', '1', 'Spring', '2018');
insert into teaches values ('15151', 'MU-199', '1', 'Spring', '2018');
insert into teaches values ('22222', 'PHY-101', '1', 'Fall', '2017');
insert into teaches values ('32343', 'HIS-351', '1', 'Spring', '2018');
insert into teaches values ('45565', 'CS-101', '1', 'Spring', '2018');
insert into teaches values ('45565', 'CS-319', '1', 'Spring', '2018');
insert into teaches values ('76766', 'BIO-101', '1', 'Summer', '2017');
insert into teaches values ('76766', 'BIO-301', '1', 'Summer', '2018');
insert into teaches values ('83821', 'CS-190', '1', 'Spring', '2017');
insert into teaches values ('83821', 'CS-190', '2', 'Spring', '2017');
insert into teaches values ('83821', 'CS-319', '2', 'Spring', '2018');
insert into teaches values ('98345', 'EE-181', '1', 'Spring', '2017');



insert into student values ('00128', 'Zhang', 'Comp. Sci.', '102');
insert into student values ('12345', 'Shankar', 'Comp. Sci.', '32');
insert into student values ('19991', 'Brandt', 'History', '80');
insert into student values ('23121', 'Chavez', 'Finance', '110');
insert into student values ('44553', 'Peltier', 'Physics', '56');
insert into student values ('45678', 'Levy', 'Physics', '46');
insert into student values ('54321', 'Williams', 'Comp. Sci.', '54');
insert into student values ('55739', 'Sanchez', 'Music', '38');
insert into student values ('70557', 'Snow', 'Physics', '0');
insert into student values ('76543', 'Brown', 'Comp. Sci.', '58');
insert into student values ('76653', 'Aoi', 'Elec. Eng.', '60');
insert into student values ('98765', 'Bourikas', 'Elec. Eng.', '98');
insert into student values ('98988', 'Tanaka', 'Biology', '120');



insert into takes values ('00128', 'CS-101', '1', 'Fall', '2017', 'A');
insert into takes values ('00128', 'CS-347', '1', 'Fall', '2017', 'A-');
insert into takes values ('12345', 'CS-101', '1', 'Fall', '2017', 'C');
insert into takes values ('12345', 'CS-190', '2', 'Spring', '2017', 'A');
insert into takes values ('12345', 'CS-315', '1', 'Spring', '2018', 'A');
insert into takes values ('12345', 'CS-347', '1', 'Fall', '2017', 'A');
insert into takes values ('19991', 'HIS-351', '1', 'Spring', '2018', 'B');
insert into takes values ('23121', 'FIN-201', '1', 'Spring', '2018', 'C+');
insert into takes values ('44553', 'PHY-101', '1', 'Fall', '2017', 'B-');
insert into takes values ('45678', 'CS-101', '1', 'Fall', '2017', 'F');
insert into takes values ('45678', 'CS-101', '1', 'Spring', '2018', 'B+');
insert into takes values ('45678', 'CS-319', '1', 'Spring', '2018', 'B');
insert into takes values ('54321', 'CS-101', '1', 'Fall', '2017', 'A-');
insert into takes values ('54321', 'CS-190', '2', 'Spring', '2017', 'B+');
insert into takes values ('55739', 'MU-199', '1', 'Spring', '2018', 'A-');
insert into takes values ('76543', 'CS-101', '1', 'Fall', '2017', 'A');
insert into takes values ('76543', 'CS-319', '2', 'Spring', '2018', 'A');
insert into takes values ('76653', 'EE-181', '1', 'Spring', '2017', 'C');
insert into takes values ('98765', 'CS-101', '1', 'Fall', '2017', 'C-');
insert into takes values ('98765', 'CS-315', '1', 'Spring', '2018', 'B');
insert into takes values ('98988', 'BIO-101', '1', 'Summer', '2017', 'A');
insert into takes values ('98988', 'BIO-301', '1', 'Summer', '2018', null);



insert into advisor values ('00128', '45565');
insert into advisor values ('12345', '10101');
insert into advisor values ('23121', '76543');
insert into advisor values ('44553', '22222');
insert into advisor values ('45678', '22222');
insert into advisor values ('76543', '45565');
insert into advisor values ('76653', '98345');
insert into advisor values ('98765', '98345');
insert into advisor values ('98988', '76766');



insert into time_slot values (1,'A', 'M', '8', '0', '8', '50');
insert into time_slot values (2,'A', 'W', '8', '0', '8', '50');
insert into time_slot values (3,'A', 'F', '8', '0', '8', '50');
insert into time_slot values (4,'B', 'M', '9', '0', '9', '50');
insert into time_slot values (5,'B', 'W', '9', '0', '9', '50');
insert into time_slot values (6,'B', 'F', '9', '0', '9', '50');
insert into time_slot values (7,'C', 'M', '11', '0', '11', '50');
insert into time_slot values (8,'C', 'W', '11', '0', '11', '50');
insert into time_slot values (9,'C', 'F', '11', '0', '11', '50');
insert into time_slot values (10,'D', 'M', '13', '0', '13', '50');
insert into time_slot values (11,'D', 'W', '13', '0', '13', '50');
insert into time_slot values (12,'D', 'F', '13', '0', '13', '50');
insert into time_slot values (13,'E', 'T', '10', '30', '11', '45 ');
insert into time_slot values (14,'E', 'R', '10', '30', '11', '45 ');
insert into time_slot values (15,'F', 'T', '14', '30', '15', '45 ');
insert into time_slot values (16,'F', 'R', '14', '30', '15', '45 ');
insert into time_slot values (17,'G', 'M', '16', '0', '16', '50');
insert into time_slot values (18,'G', 'W', '16', '0', '16', '50');
insert into time_slot values (19,'G', 'F', '16', '0', '16', '50');
insert into time_slot values (20,'H', 'W', '10', '0', '12', '30');
							  


insert into prereq values ('BIO-301', 'BIO-101');
insert into prereq values ('BIO-399', 'BIO-101');
insert into prereq values ('CS-190', 'CS-101');
insert into prereq values ('CS-315', 'CS-101');
insert into prereq values ('CS-319', 'CS-101');
insert into prereq values ('CS-347', 'CS-101');
insert into prereq values ('EE-181', 'PHY-101');
 

--Assignment Questions

--1. Display average salary given by each department.

 select dept_name,avg(salary) as 'Average salary' from instructor
 group by dept_name

--2. Display the name of students and their corresponding course IDs.

select course_id,name from takes,student
where student.ID=takes.ID 

--3. Display number of courses taken by each student.

select count(course_id),name from takes,student
where student.ID=takes.ID group by name

--4. Get the prerequisites courses for courses in the Spring semester.

select semester,takes.ID,prereq_id from takes,prereq
where takes.course_id=prereq.course_id and semester='Spring'

--5. Display the instructor name who teaches student with highest 5 credits.

select top 5 student.name as 'Student name', instructor.name as 'Instructor name',tot_cred
from student inner join instructor on student.dept_name=instructor.dept_name
order by tot_cred desc

--6. Which semester and department offers maximum number of courses.

select  top 1 semester,dept_name, max(count) as 'max' from
(select semester,dept_name,count(c.course_id) as count from
section s join course c
on s.course_id=c.course_id
group by semester,dept_name)  as b
group by semester,dept_name
order by max desc

--7. Display course and department whose time starts at 8.

select section.course_id, start_hr from time_slot,section
where time_slot.time_slot_id= section.time_slot_id and start_hr=8
group by section.course_id, start_hr

--8. Display the salary of instructors from Watson building.

select name,salary,dept_name from instructor
where dept_name in(select dept_name from department where building='Waston')


--9. Show the title of courses available on Monday.

select title,day from time_slot,course,section
where time_slot.time_slot_id=section.time_slot_id and course.course_id=section.course_id and day='M'

--10. Find the number of courses that start at 8 and end at 8.

select start_hr,end_hr,count(course_id) as 'number of course'
from section,time_slot
where section.time_slot_id=time_slot.time_slot_id and start_hr=8 and end_hr=8
group by start_hr,end_hr

--11. Find instructors having salary more than 90000.

select name from instructor where salary > 90000

--12. Find student records taking courses before 2018.

select * from takes  where year < 2018

--13. Find student records taking courses in the fall semester and coming under first section.

select * from takes 
where semester='Fall' and sec_id=1

--14. Find student records taking courses in the fall semester and coming under second section.

select * from takes 
where semester='Fall' and sec_id=2

--15. Find student records taking courses in the summer semester, coming under first section in the year 2017.

select * from takes 
where semester='Summer' and sec_id = 1 and year=2017

--16. Find student records taking courses in the fall semester and having A grade.

select * from takes 
where semester='Fall' and grade='A'

--17. Find student records taking courses in the summer semester and having A grade.

select * from takes 
where semester='Summer' and grade='A'

--18. Display section details with B time slot, room number 514 and in the Painter building.

select * from section
where time_slot_id = 'B' and room_number = 514 and building = 'Painter'

--19. Find all course titles which have a string "Intro.".

select title from course where title like '%Intro%'

--20. Find the titles of courses in the Computer Science department that have 3 credits.

select title from course where dept_name='Comp. Sci.' and credits=3

--21. Find IDs and titles of all the courses which were taught by an instructor named Einstein. Make sure there are no duplicates in the result.

select course.course_id,title from course,instructor,teaches
where course.course_id= teaches.course_id and instructor.dept_name = course.dept_name
and instructor.name='Einstein'

--22. Find all course IDs which start with CS

select course_id  from course where course_id like 'Cs%'

--23. For each department, find the maximum salary of instructors in that department.

select dept_name ,max(salary) as 'max salary' from instructor
group by dept_name

--24. Find the enrollment (number of students) of each section that was offered in Fall 2017.

select sec_id,count(id) as 'number of student', semester,year from takes 
where semester='Fall' and year='2017' group by sec_id,semester,year

--25. Increase(update) the salary of each instructor by 10% if their current salary is between 0 and 90000.

update instructor
set salary=salary*1.1 where salary between 0 and 90000

select name, salary from instructor

--26. Find the names of instructors from Biology department having salary more than 50000.

select name,salary from instructor where dept_name='Biology' and salary>50000

--27. Find the IDs and titles of all courses taken by a student named Shankar.

select name,takes.course_id,title from student,takes,course
where student.ID=takes.ID and takes.course_id=course.course_id and name='Shankar'


--28. For each department, find the total credit hours of courses in that department.

select dept_name,sum(credits) as total_credits from course
group by dept_name

--29. Find the number of courses having A grade in each building.

select building,count(takes.course_id) as 'number of courses' ,grade
from section,takes
where section.course_id = takes.course_id and grade='A'
group by building,grade

--30. Display number of students in each department having total credits divisible by course credits.

select student.dept_name,count(student.id) as 'number of courses'
from course,student
where course.dept_name = student.dept_name and tot_cred%credits = 0
group by course.dept_name, student.dept_name


--31. Display number of courses available in each building.

select buliding,count(course_id) as 'number of course' from course,department
where course.dept_name= department.dept_name group by building

--32. Find number of instructors in each department having 'a' and 'e' in their name.

select dept_name,count(name) as 'number of instructor' from instructor
where name like '%a%e%' 
group by dept_name

--33. Display number of courses being taught in classroom having capacity more than 20.

select classroom.room_number, capacity, count(course_id) as 'number of course'
from section,classroom
where section.room_number=classroom.room_number and capacity>20
group by classroom.room_number, capacity

--34. Update the budget of each department by Rs. 1000

update department 
set budget = budget+1000

--35. Find number of students in each room.

select room_number,count(takes.id) as 'number of students' from takes,section
where section.course_id=takes.course_id
group by room_number

--36. Give the prerequisite course for each student.

select name,prereq_id from student,takes,prereq
where student.ID=takes.ID and takes.course_id=prereq.course_id

--37. Display number of students attending classes on Wednesday.

select day,count(takes.id) as 'number of students' from time_slot, takes, section
where time_slot.time_slot_id=section.time_slot_id and takes.course_id= section.course_id and day = 'W'
group by time_slot.day

--38. Display number of students and instructors in each department

select student.dept_name, count(student.ID) as 'number of students and instructors' from student
group by student.dept_name
union all
select instructor.dept_name, count(instructor.ID) as 'number of instructors' from instructor
group by instructor.dept_name


--39. Display number of students in each semester and their sum of credits.

select semester,count(takes.id) as 'number of students', sum(tot_cred) as 'sum of credits' from takes,student
where takes.ID = student.id
group by semester

--40. Give number of instructors in each building.

select building,count(instructor.id) as 'number of instructors' from instructor,teaches,section
where instructor.ID = teaches.id and teaches.course_id = section.course_id
group by section.building

--41. Display advisor IDs for instructors in Painter building.

select building,instructor.name,advisor.s_ID
from instructor,advisor,teaches,section
where instructor.id = advisor.i_ID and teaches.ID= instructor.id
and teaches.course_id = section.course_id and building='Painter' 

--42. Find total credits earned by students coming at 9am

select student.name,start_hr, tot_cred
from student,takes,section,time_slot
where student.id= takes.id and takes.course_id = section.course_id
and section.time_slot_id = time_slot.time_slot_id and start_hr=9

--43. Display student names ordered by room number

select student.name,section.room_number
from student,takes,section
where student.id= takes.id and takes.course_id = section.course_id
order by room_number

--44. Find the number of capacity left after occupying all the students.

select classroom.room_number,classroom.capacity - count(takes.ID) as 'remaining capacity'
from takes,section,classroom
where takes.course_id = section.course_id and section.room_number=classroom.room_number
group by section.room_number,classroom.room_number,classroom.capacity

--45. Find the duration for which each student has to attend each lecture.

select student.name,takes.course_id, end_hr - start_hr as 'duration', end_min - start_min as 'duration in mins' 
from student,takes,section,time_slot
where student.id= takes.id and takes.course_id = section.course_id and section.time_slot_id= time_slot.time_slot_id
group by student.name,takes.course_id,time_slot.start_hr,time_slot.end_hr,time_slot.start_min,time_slot.end_min

--46. Create a timetable for the university.

select time_slot.day,section.building,section.room_number,section.course_id
from section,time_slot
where section.time_slot_id= time_slot.time_slot_id
group by time_slot.day,section.building,section.room_number,section.course_id

--47. Find the average salary that's distributed to teachers for each course and sort them in descending order

with teacher_course_data as (
select id,title from teaches as t
join course as c
on c.course_id=t.course_id )
select title as course_name, avg(salary) as avg_salary from teacher_course_data as tcd
join instructor as i
on tcd.id = i.id
group by tcd.title
order by avg_salary desc

--48. Find the average duration of classes for each course id

with time_slot_duration as (
select time_slot_id,(end_min - start_min) as duration
from time_slot
)
select s.course_id,avg(duration) as duration from section as s
join time_slot_duration tsd on s.time_slot_id = tsd.time_slot_id

--49 Get the name of the instructor with highest salary from each department.

select dept_name, name , max(salary) as highest_salary from instructor
group by dept_name, name

--50. Get the sum of the total credits of students that is dealt by the instructors along with their names

with student_advisor_data as (
select * from student s
join advisor a
on s.id = a.s_ID)
select i.name,tot_cred_data.sum_of_credits
from (select i_id,sum(tot_cred) as sum_of_credits
from student_advisor_data
group by i_id)
as tot_cred_data
join instructor i on tot_cred_data.i_id = i.id

--51. Perform division between student credits and department total credits

with dept_creds as (
select dept_name, sum(credits) as dept_total_creds
from course
group by dept_name
)
select s.name,s.tot_cred, dc.dept_total_creds
from student s join dept_creds dc
on s.dept_name=dc.dept_name

--52. If the department budget was to be distributed among the buildings, how much amount can be allocated to each room in a building

with building_room_data as (
select building,count(room_number) as num_rooms
from classroom
group by building
)
select bb.building, bb.building_budget/num_rooms as room_budget
from building_room_data as brd
join
( 
select building,sum(budget) as building_budget
from department
group by building
) as bb
on bb.building=brd.building
