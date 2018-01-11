-- Database I ITEC-340
-- Yoga Studio Project

SET ECHO ON;
SET serveroutput ON;
SET linesize 1000;

drop trigger highAttend_Trigger;
drop trigger expLevelTrigger;

drop procedure deleteEnroll;
drop procedure addEnroll;
drop procedure addStudent;
drop procedure addClass;

drop sequence log_refund_seq;
drop table Log_Refund_Yoga;
drop sequence highAttend_seq;
drop table highAttend;
drop table Enroll;
drop table Class;
drop table Student;
drop table Instructor;

Create table Instructor
( 
    TID          int
,   fname        varchar(20) not null
,   lname        varchar(20) not null
,   city         varchar(20)
,   state        char(2)
,   rate_hour    decimal(5,2) not null
,   Constraint   Instructor_PK PRIMARY KEY(TID)
);
   
   
Create Table Student
(
     SID           int
,    first         varchar(20) not null
,    last          varchar(20) not null
,    exp_level     char(1) not null
,    city          varchar(20)
,    state         char(2)
,    Constraint    Student_PK PRIMARY KEY(SID)
,    Constraint Exp_Lev_Ck CHECK (exp_level in ('B', 'I', 'E'))
);
  
  
Create Table Class
(
     name          varchar2(50) not null
 ,   duration      int
 ,   class_level   char(1)
 ,   TID           int
 ,   day           varchar2(5)    not null
 ,   time          varchar2(8)     not null
 ,   cost          Decimal(5,2)
 ,   Constraint Class_PK PRIMARY KEY(name, TID)
 ,   Constraint Inst_FK FOREIGN KEY(TID) references Instructor(TID)
 ,   CONSTRAINT Cls_Lev_Ck CHECK (class_Level in ('B', 'I', 'E', 'A'))
 , 	 CONSTRAINT Cls_Day_Ck CHECK (day in ('Mon', 'Tues', 'Wed', 'Thurs', 'Sat'))
 );
  
Create Table Enroll
(
     class_name     	varchar(50)  
 ,   TID            	int
 ,   SID            	int
 ,   payment        	decimal(5,2)
 ,   Constraint Enroll_PK   Primary key(Class_Name,TID,SID)
 ,   Constraint Ins_FK      Foreign key(TID) references  Instructor(TID)
 ,   Constraint Student_FK  Foreign key(SID) references  Student(SID)
 ,   CONSTRAINT Enroll_payment_Ck CHECK ((payment >= 10.00) AND (payment <= 100.00))
 );

Create Table highAttend
(
     attend_log_ID     	number(10)  
 ,   class_name			varchar2(50) not null
 ,	 TID				int not null
 ,   sys_date  			date
 ,   CONSTRAINT highAttend_PK PRIMARY KEY(attend_log_ID)
 ,   CONSTRAINT class_FK FOREIGN KEY(class_name, TID) REFERENCES Class(name, TID)
 );

CREATE SEQUENCE highAttend_seq
	MINVALUE	-1
	START WITH	0;

Create Table Log_Refund_Yoga
(
     refund_log_ID    	number(10)  
 ,   SID 				int
 ,   payment_log 		decimal(5,2)
 ,   CONSTRAINT log_refund_yoga_PK PRIMARY KEY(refund_log_ID)
 ,   CONSTRAINT log_refund_yoga_FK1 FOREIGN KEY(SID) REFERENCES Student(SID)
 );

CREATE SEQUENCE log_refund_seq
	MINVALUE	-1
	START WITH	0;

commit;


--Data for Instructor table
INSERT INTO Instructor(TID, Fname, Lname, City, State, Rate_Hour)
Values (1, 'Sally', 'Greenville', 'Radford', 'VA', 40.00);

INSERT INTO Instructor(TID, Fname, Lname, City, State, Rate_Hour)
Values (2, 'John', 'Wooding', 'Blacksburg', 'VA', 60.00);

INSERT INTO Instructor(TID, Fname, Lname, City, State, Rate_Hour)
Values (3, 'Debbie', 'Delfield', 'Roanoke', 'VA', 45.00);

INSERT INTO Instructor(TID, Fname, Lname, City, State, Rate_Hour)
Values (4, 'Elaine', 'Tobies', 'Radford', 'VA', 50.00);

--Data for Student table
INSERT INTO Student(SID, First, Last, Exp_Level, City, State)
Values (101, 'Sally', 'Treville', 'E', 'Salem', 'VA');

INSERT INTO Student(SID, First, Last, Exp_Level, City, State)
Values (102, 'Gerald',' Warner', 'B', 'Roanoke', 'VA');

INSERT INTO Student(SID, First, Last, Exp_Level, City, State)
Values (104, 'Katie' , 'Johnson', 'B', 'Blacksburg', 'VA');

INSERT INTO Student(SID, First, Last, Exp_Level, City, State)
Values (105, 'Matt', 'Kingston', 'E', 'Radford', 'VA');

INSERT INTO Student(SID, First, Last, Exp_Level, City, State)
Values (106, 'Ellen', 'Maples', 'I', 'Radford', 'VA');

INSERT INTO Student(SID, First, Last, Exp_Level, City, State)
Values (108, 'Tom', 'Rivers', 'E', 'Radford', 'VA');

INSERT INTO Student(SID, First, Last, Exp_Level, City, State)
Values (109, 'Barbara', 'Singleton','E', 'Radford', 'VA');

INSERT INTO Student(SID, First, Last, Exp_Level, City, State)
Values (110, 'Johathan', 'Stiner', 'I', 'Salem', 'VA');

--Data for Class table
INSERT INTO Class(Name,Duration, Class_Level, TID, Day, Time, Cost)
Values  ('Fun with Yoga', 60, 'B', 1, 'Mon', '6:00 PM', 15.00);

INSERT INTO Class(Name, Duration, Class_Level, TID, Day, Time, Cost)
Values  ('Stretch Yoga', 90, 'I', 2, 'Tues', '5:30 PM', 20.00);

INSERT INTO Class(Name, Duration, Class_Level, TID, Day, Time, Cost)
Values ('Lunch Yoga', 50, 'A', 3, 'Wed', '12:30 PM', 15.00);

INSERT INTO Class(Name, Duration, Class_Level, TID, Day, Time, Cost)
Values ('Yoga for All', 90, 'A', 4, 'Thurs', '7:00 PM', 25.00);

INSERT INTO Class(Name, Duration, Class_Level, TID, Day, Time, Cost)
Values ('Yoga Inversions', 60, 'I', 1, 'Sat', '10:00 AM', 20.00);

INSERT INTO Class(Name, Duration, Class_Level, TID, Day, Time, Cost)
Values ('Advanced Yoga', 90, 'E', 4, 'Sat', '2:00 PM', 25.00);

INSERT INTO Class(Name, Duration, Class_Level, TID, Day, Time, Cost)
Values ('Relaxation Yoga', 90, 'I', 4, 'Mon', '7:30 PM', 40.00);

--Data for Enroll table
INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Fun with Yoga', 1,102,15.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Fun with Yoga', 1,104,15.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Fun with Yoga', 1,108,15.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Stretch Yoga', 2,106,20.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Stretch Yoga', 2,108,20.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Lunch Yoga', 3,102,15.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Lunch Yoga', 3,109,15.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Yoga for All', 4,106,10.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Yoga for All', 4,108,25.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Yoga Inversions', 1,106,25.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Yoga Inversions', 1,105,25.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Advanced Yoga', 4,106,25.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Advanced Yoga', 4,108,25.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Stretch Yoga', 2,110,20.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Relaxation Yoga', 4,101,10.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Relaxation Yoga', 4,106,10.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Relaxation Yoga', 4,108,10.00);


-------------------------Tests for constraints-----------------------------------------------
--Constraint 1
INSERT INTO Class(Name, Duration, Class_Level, TID, Day, Time, Cost)
Values ('Lunch Yoga', 50, 'A', 3, 'Fri', '12:30 PM', 15.00);

INSERT INTO Class(Name, Duration, Class_Level, TID, Day, Time, Cost)
Values ('Lunch Yoga', 50, 'A', 3, 'Sat', '12:30 PM', 15.00);

--Constraint 2
INSERT INTO Student(SID, First, Last, Exp_Level, City, State)
Values (102, 'Sally', 'Treville', 'PRO', 'Salem', 'VA');

INSERT INTO Student(SID, First, Last, Exp_Level, City, State)
Values (102, 'Sally', 'Treville', 'All-Star', 'Salem', 'VA');

INSERT INTO Student(SID, First, Last, Exp_Level, City, State)
Values (102, 'Sally', 'Treville', 'All-Star', 'X', 'VA');

--Constraint 3
INSERT INTO Class(Name, Duration, Class_Level, TID, Day, Time, Cost)
Values ('Lunch Yoga', 50, 'Professional', 3, 'Wed', '12:30 PM', 15.00);

INSERT INTO Class(Name, Duration, Class_Level, TID, Day, Time, Cost)
Values ('Lunch Yoga', 50, 'All-Star', 3, 'Wed', '12:30 PM', 15.00);

INSERT INTO Class(Name, Duration, Class_Level, TID, Day, Time, Cost)
Values ('Lunch Yoga', 50, 'X', 3, 'Wed', '12:30 PM', 15.00);

--Constaint 5
INSERT INTO Student(SID, First, Last, Exp_Level, City, State)
Values (101, '', '', '', 'Salem', 'VA');

INSERT INTO Student(SID, First, Last, Exp_Level, City, State)
Values (102, 'Sally', '', 'E', 'Salem', 'VA');

INSERT INTO Student(SID, First, Last, Exp_Level, City, State)
Values (103, '', 'Treville', 'E', 'Salem', 'VA');

INSERT INTO Student(SID, First, Last, Exp_Level, City, State)
Values (104, '', '', 'E', 'Salem', 'VA');

--Constaint 6
INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Relaxation Yoga', 4,108,1.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Relaxation Yoga', 4,108,10.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Relaxation Yoga', 4,108,100.00);

INSERT INTO Enroll(Class_Name, TID, SID, Payment)
Values('Relaxation Yoga', 4,108,101.00);


--Constraint 7
INSERT INTO Instructor(TID, Fname, Lname, City, State, Rate_Hour)
Values (100, '', 'Greenville', 'Radford', 'VA', 40.00);

INSERT INTO Instructor(TID, Fname, Lname, City, State, Rate_Hour)
Values (101, 'Sally', '', 'Radford', 'VA', 40.00);

INSERT INTO Instructor(TID, Fname, Lname, City, State)
Values (1, 'Sally', 'Greenville', 'Radford', 'VA' );

--Constraint 8
INSERT INTO Class(Name, Duration, Class_Level, TID, Day, Time, Cost)
Values ('', 50, 'A', 3, 'Wed', '12:30 PM', 15.00);

INSERT INTO Class(Name, Duration, Class_Level, TID, Day, Time, Cost)
Values ('Lunch Yoga', 50, 'A', 3, '', '12:30 PM', 15.00);

INSERT INTO Class(Name, Duration, Class_Level, TID, Day, Time, Cost)
Values ('Lunch Yoga', 50, 'A', 3, 'Wed', '', 15.00);

INSERT INTO Class(Name, Duration, Class_Level, TID, Day, Time, Cost)
Values ('', 50, 'A', 3, '', '', 15.00);


-------------------------P02 START-----------------------------------------------

ALTER TABLE Class
ADD classCount Number(10) default 0;

UPDATE Class
SET Class.classCount = 3
WHERE Class.name = 'Fun with Yoga';

Update Class
Set Class.classCount = 3
Where Class.name = 'Stretch Yoga';

Update Class
Set Class.classCount = 2
Where Class.name = 'Lunch Yoga';

Update Class
Set Class.classCount = 2
Where Class.name = 'Yoga for All';

Update Class
Set Class.classCount = 2
Where Class.name = 'Yoga Inversions';

Update Class
Set Class.classCount = 2
Where Class.name = 'Advanced Yoga';

Update Class
Set Class.classCount = 3
Where Class.name = 'Relaxation Yoga';


--Stored Procedures--------------------------------------------------------------
CREATE OR Replace PROCEDURE addClass
(
     aName          IN    CLASS.name%Type 
 ,   aDuration      IN    CLASS.duration%Type 
 ,   aClass_level   IN    CLASS.class_level%Type 
 ,   aTID           IN    CLASS.TID%Type 
 ,   aDay           IN    CLASS.day%Type    
 ,   aTime          IN    CLASS.time%Type     
 ,   aCost          IN    CLASS.cost%Type 
 ,   aclassCount	IN 	  CLASS.classCount%Type
) 
IS
BEGIN
  INSERT INTO Class
  (name, duration, class_Level, TID, day, time, cost, classCount)
  VALUES
  (aName, aDuration, aClass_Level,aTID,aDay, aTime, aCost, aclassCount);

  dbms_output.put_line('Added a class.');
  Exception
	WHEN OTHERS THEN dbms_output.put_line('Invalid type given for column when adding a class.');

END;
/

-------------------------Tests for addClass-----------------------------------------------
EXECUTE addClass ('Monster Yoga', 90, 'E', 1, 'Mon', '10:00 AM', 90.00, 0);
SELECT * FROM Class;
 --Delete inserted row
rollback;
EXECUTE addClass (null, 70, 'A', 1, 'Sat', '9:00 AM', 60.00, 0);


CREATE or REPLACE PROCEDURE addStudent
(
     aSID         IN        Student.SID%Type 
 ,   aFirst       IN        Student.first%Type 
 ,   aLast        IN        STUDENT.last%Type 
 ,   aExp_Level   IN        STUDENT.exp_level%Type 
 ,   aCity        IN        STUDENT.city%Type    
 ,   aState       IN        STUDENT.state%Type
) 
IS
BEGIN
	INSERT INTO Student
	(SID, first, last, exp_level, city, state)
	VALUES 
	(aSID, aFirst, aLast, aExp_Level, aCity, aState);

	dbms_output.put_line('Added a student.');
	Exception
	WHEN OTHERS THEN dbms_output.put_line('Invalid type given for column when adding a student.');
	
END;
/

-------------------------Tests for addStudent-----------------------------------------------
EXECUTE addStudent (111, 'Andy', 'Griffith', 'B', 'Mayberry', 'NC');
SELECT * FROM Student;
 --Delete inserted row
rollback;
EXECUTE addStudent (null, 'Barney', 'Fife', 'E', 'Mayberr', 'NC');



CREATE OR REPLACE PROCEDURE addEnroll
(
     aClass_Name        IN  Enroll.class_name%Type 
 ,   aTID               IN  Enroll.TID%Type 
 ,   aSID               IN  Enroll.SID%Type 
 ,   aPayment           IN  Enroll.payment%Type
) 
IS
BEGIN
	
	INSERT INTO Enroll
	(class_name, TID, SID, payment)
	VALUES 
	(aClass_Name, aTID, aSID, aPayment);
	
	UPDATE Class
	SET Class.classCount = Class.classCount + 1
	WHERE Class.name = aClass_Name;
	
	dbms_output.put_line('Added an enrollment.');
	EXCEPTION
	WHEN OTHERS THEN dbms_output.put_line('Invalid type for given for column on attempted enrollment.');
END;
/
-------------------------Tests for addEnroll-----------------------------------------------
EXECUTE addEnroll ('Yoga for All', 2, 110, 25.00);
SELECT * FROM Enroll;
SELECT * FROM Class;
 --Delete inserted row
rollback;
EXECUTE addEnroll ('Yoga for Moms', 10, 101, 40.00);
rollback;


CREATE OR REPLACE PROCEDURE deleteEnroll
(
     aClass_Name        IN  Enroll.class_name%Type 
 ,   aTID               IN  Enroll.TID%Type 
 ,   aSID               IN  Enroll.SID%Type 
) 
IS
BEGIN
	DELETE FROM Enroll
	WHERE Enroll.class_name = aClass_Name AND
		  Enroll.TID = aTID AND 
		  Enroll.SID = aSID;  
	dbms_output.put_line('Deleted an enrollment.');	  
	
	EXCEPTION
	WHEN OTHERS THEN dbms_output.put_line('Invalid type given for column on attempted delete.');
END;
/

-------------------------Tests for deleteEnroll-----------------------------------------------
EXECUTE deleteEnroll ('Fun with Yoga', 1, 102);
SELECT * FROM Enroll;
EXECUTE deleteEnroll ('Yoga for Moms', 4, 110);
rollback;

--Triggers--------------------------------------------------------------		

CREATE OR REPLACE TRIGGER expLevelTrigger
	BEFORE INSERT OR UPDATE ON Enroll
	FOR EACH ROW
DECLARE

	current_class_level char(1); 
	current_student_level char(1);

BEGIN
	
	SELECT Class.class_level INTO current_class_level
	FROM Class
	INNER JOIN Enroll
	ON Enroll.class_name = Class.name
	WHERE Class.name = :new.class_name;
	
	SELECT Student.exp_level INTO current_student_level
	FROM Student
	INNER JOIN Enroll
	ON Enroll.SID = Student.SID
	WHERE Student.SID = :new.SID;

	--If for enrolled beginner students
	IF ((current_student_level = 'B') AND 
		(current_class_level = 'B')) THEN 
		
		INSERT INTO Enroll (class_name, TID, SID, payment)
		VALUES (:new.class_name, :new.TID, :new.SID, :new.Payment);
		
	--Elsif for enrolled intermediate students
	ELSIF ((current_student_level = 'I') AND
		  (current_class_level = 'B') OR 
		  (current_class_level = 'I')) THEN
		  
		  INSERT INTO Enroll (class_name, TID, SID, payment)
		  VALUES (:new.class_name, :new.TID, :new.SID, :new.Payment);
		  
	--Elsif for enrolled advanced students	  
	ELSIF ((current_student_level = 'A') AND
		  (current_class_level = 'B') OR 
		  (current_class_level = 'I') OR
		  (current_class_level = 'A')) THEN
		  
		  INSERT INTO Enroll (class_name, TID, SID, payment)
		  VALUES (:new.class_name, :new.TID, :new.SID, :new.Payment);
		  
	--Elsif for enrolled expert students
	ELSIF ((current_student_level = 'E') AND
	      (current_class_level = 'B') OR
		  (current_class_level = 'I') OR
		  (current_class_level = 'A') OR
		  (current_class_level = 'E')) THEN
		  
		  INSERT INTO Enroll (class_name, TID, SID, payment)
		  VALUES (:new.class_name, :new.TID, :new.SID, :new.Payment);  
	END IF;
	
	EXCEPTION 
	WHEN OTHERS THEN dbms_output.put_line('Student experience level is too low.');
END expLevelTrigger;
/
 

-------------------------Tests for expLevelTrigger-----------------------------------------------  
INSERT INTO Enroll (class_name, TID, SID, payment)
VALUES ('Advanced Yoga', 4, 101, 25.00);
rollback;
INSERT INTO Enroll (class_name, TID, SID, payment)
VALUES ('Advanced Yoga', 4, 102, 25.00);
rollback;
INSERT INTO Enroll (class_name, TID, SID, payment)
VALUES ('Fun with Yoga', 1, 109, 25.00);
rollback;


CREATE OR REPLACE TRIGGER highAttend_Trigger
	AFTER INSERT ON Enroll
	FOR EACH ROW
DECLARE
	enrollment_count Class.classCount%Type;
BEGIN
	SELECT Class.classCount
	INTO enrollment_count
	FROM Class
	WHERE Class.name = :new.class_name;
	
	IF enrollment_count = 4 THEN 
		INSERT INTO highAttend (attend_log_ID, class_name, TID, sys_date)
		VALUES (highAttend_seq.nextVal, :new.class_name, :new.TID, sysdate);	
		dbms_output.put_line('Student limit for the class has been reached.');
	END IF;
	
	UPDATE Class
	SET classCount = enrollment_count + 1
	WHERE Class.name = :new.class_name;
	
END highAttend_Trigger;
/

INSERT INTO Enroll (class_name, TID, SID, payment)
VALUES ('Advanced Yoga', 4, 102, 25.00);


-------------------------Tests to fire highAttend_Trigger-----------------------------------------------  

SELECT * FROM highAttend;

INSERT INTO Enroll (class_name, TID, SID, payment)
VALUES ('Fun with Yoga', 1, 101, 15.00);


INSERT INTO Enroll (class_name, TID, SID, payment)
VALUES ('Fun with Yoga', 1, 105, 15.00);

SELECT * FROM highAttend;
 
commit;
