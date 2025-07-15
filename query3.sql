SHOW DATABASES;

USE testdb3;

CREATE TABLE
  IF NOT EXISTS student_records (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    courses VARCHAR(255),
    hobbies VARCHAR(255),
    department_id INT,
    department_name VARCHAR(100)
  );

SHOW TABLES;

INSERT INTO
  student_records
VALUES
  (
    1,
    'Alice',
    16,
    'Math, Physics',
    'Reading, Painting',
    101,
    'Computer Science'
  );

SELECT
  *
FROM
  student_records;

CREATE TABLE
  student_only1 AS
SELECT
  student_id,
  student_name,
  age,
  courses,
  hobbies
FROM
  student_records;

ALTER TABLE student_only1
ADD COLUMN department_id INT;

SELECT
  *
FROM
  student_only1;

UPDATE student_only1
SET
  department_id = 101
WHERE
  student_id = 1;

CREATE TABLE
  department_only1 AS
SELECT
  department_id,
  department_name
FROM
  student_records;

SHOW TABLES;

SELECT
  *
FROM
  department_only1;

SELECT
  *
FROM
  student_only1;

CREATE TABLE
  student_only2 AS
SELECT
  student_id,
  student_name,
  age,
  course,
  hobbie,
  department_id
FROM
  student_only1;

SELECT
  *
FROM
  student_only2;

DESC student_only2;

DELETE FROM student_only2
WHERE
  student_id = 1;

ALTER TABLE student_only2
DROP PRIMARY KEY;

INSERT INTO
  student_only2
VALUES
  (1, 'Alice', 16, 'Math', 'Reading', 101),
  (1, 'Alice', 16, 'Math', 'Painting', 101),
  (1, 'Alice', 16, 'Physics', 'Reading', 101),
  (1, 'Alice', 16, 'Physics', 'Painting', 101);

-- Making my table atomic, removing the repeating groups
SELECT
  *
FROM
  student_only2;

CREATE TABLE
  student_only3 AS
SELECT
  student_id,
  student_name,
  age
FROM
  student_only2;

SELECT
  *
FROM
  student_only3;

DESC student_only2;

CREATE TABLE
  student_table_2nf AS
SELECT
  student_id,
  courses,
  hobbies
FROM
  student_only2;

SELECT
  *
FROM
  student_table_2nf;

SHOW TABLES;

SELECT
  *
FROM
  student_records;

CREATE TABLE
  courses_only1 AS
SELECT
  DISTINCT courses
FROM
  student_table_2nf;

  SELECT * FROM courses_only1;

  ALTER Table courses_only1
  ADD COLUMN 
  column_id INT AUTO_INCREMENT PRIMARY KEY,
  ADD COLUMN course_instructor VARCHAR(100);

  UPDATE courses_only1
  SET course_instructor = 'Dr. Smith'
  WHERE courses = 'Math';

  UPDATE courses_only1
  SET course_instructor = 'Dr. John'
  WHERE courses = 'Physics';