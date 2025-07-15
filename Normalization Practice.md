# 🔄 Database Normalization with SQL Queries (1NF to 5NF)

<!-- markdownlint-disable MD024 -->

## 🧱 Start: Unnormalized Table (UNF)

### ⚠️ Problem: Multiple values in one field, repeating groups, mixed dependencies

### 🛠 SQL to Create UNF Table

```sql
CREATE TABLE StudentRecords (
    StudentID INT,
    StudentName VARCHAR(100),
    Courses VARCHAR(255),           -- e.g., 'Math, Physics'
    Hobbies VARCHAR(255),           -- e.g., 'Reading, Painting'
    DepartmentID INT,
    DepartmentName VARCHAR(100)
);

INSERT INTO StudentRecords VALUES
(1, 'Alice', 'Math, Physics', 'Reading, Painting', 101, 'Computer Science');
```

---

## ✅ 1NF: First Normal Form

### 📌 Fixes

* Atomic values (split comma-separated lists).
* No repeating groups.

### 🛠 1NF Table Design

```sql
CREATE TABLE StudentCourses (
    StudentID INT,
    StudentName VARCHAR(100),
    Course VARCHAR(100),
    Hobby VARCHAR(100),
    DepartmentID INT,
    DepartmentName VARCHAR(100)
);

INSERT INTO StudentCourses VALUES
(1, 'Alice', 'Math', 'Reading', 101, 'Computer Science'),
(1, 'Alice', 'Math', 'Painting', 101, 'Computer Science'),
(1, 'Alice', 'Physics', 'Reading', 101, 'Computer Science'),
(1, 'Alice', 'Physics', 'Painting', 101, 'Computer Science');
```

---

## ✅ 2NF: Second Normal Form

### 📌 Fixes

* Remove partial dependencies.
* Assumes composite key: (StudentID, Course)

### 🛠 Table Breakdown

#### 🎯 Remove StudentName and Department info from course-hobby table

```sql
-- Students Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    DepartmentID INT
);

INSERT INTO Students VALUES (1, 'Alice', 101);

-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

INSERT INTO Departments VALUES (101, 'Computer Science');

-- Courses Table
CREATE TABLE StudentCourses2NF (
    StudentID INT,
    Course VARCHAR(100),
    Hobby VARCHAR(100),
    PRIMARY KEY (StudentID, Course, Hobby)
);

INSERT INTO StudentCourses2NF VALUES
(1, 'Math', 'Reading'),
(1, 'Math', 'Painting'),
(1, 'Physics', 'Reading'),
(1, 'Physics', 'Painting');
```

---

## ✅ 3NF: Third Normal Form

### 📌 Fixes

* Remove transitive dependency: DepartmentName depends on DepartmentID, not StudentID.

### ✅ Already handled in 2NF above

* `DepartmentName` moved to its own `Departments` table.
* `Students` table stores `DepartmentID` only.
* ✔️ No transitive dependencies remain.

---

## ✅ 3.5NF / BCNF: Boyce-Codd Normal Form

### 📌 Fixes

* Every determinant is a candidate key.

### 🧠 Example Violation

```sql
-- Suppose:
-- One instructor teaches only one course
-- But one course can have multiple instructors ➝ violates BCNF

CREATE TABLE CourseInstructor (
    Course VARCHAR(100),
    Instructor VARCHAR(100)
);

INSERT INTO CourseInstructor VALUES
('Math', 'Dr. Smith'),
('Math', 'Dr. John'); -- Multiple instructors for same course
```

### 🛠 Fix

Split tables:

```sql
CREATE TABLE Instructors (
    Instructor VARCHAR(100) PRIMARY KEY,
    Course VARCHAR(100)
);

INSERT INTO Instructors VALUES
('Dr. Smith', 'Math'),
('Dr. John', 'Physics');
```

---

## ✅ 4NF: Fourth Normal Form

### 📌 Fixes

* Eliminate multi-valued dependencies.

### 🧠 Violation Example

```sql
-- A student can have multiple hobbies AND multiple courses independently

CREATE TABLE StudentMulti (
    StudentID INT,
    Course VARCHAR(100),
    Hobby VARCHAR(100)
);

-- Multi-valued dependency: Hobby and Course are independent
INSERT INTO StudentMulti VALUES
(1, 'Math', 'Reading'),
(1, 'Math', 'Painting'),
(1, 'Physics', 'Reading'),
(1, 'Physics', 'Painting'); -- Redundant combinations ❌
```

### 🛠 Fix: Separate into two tables

```sql
CREATE TABLE StudentHobbies (
    StudentID INT,
    Hobby VARCHAR(100),
    PRIMARY KEY (StudentID, Hobby)
);

INSERT INTO StudentHobbies VALUES
(1, 'Reading'),
(1, 'Painting');

CREATE TABLE StudentCourses4NF (
    StudentID INT,
    Course VARCHAR(100),
    PRIMARY KEY (StudentID, Course)
);

INSERT INTO StudentCourses4NF VALUES
(1, 'Math'),
(1, 'Physics');
```

---

## ✅ 5NF: Fifth Normal Form (Project-Join Normal Form)

### 📌 Fixes

* Eliminate join dependency where data is reconstructible by joining multiple tables, and the decomposition is **lossless**.

### 🧠 Example

```sql
-- A company assigns Employees to Projects using Suppliers

-- Unnormalized Table:
CREATE TABLE EmployeeProjectSupplier (
    Employee VARCHAR(100),
    Project VARCHAR(100),
    Supplier VARCHAR(100)
);

INSERT INTO EmployeeProjectSupplier VALUES
('E1', 'P1', 'S1'),
('E1', 'P1', 'S2'),
('E1', 'P2', 'S1'),
('E1', 'P2', 'S2');
```

### 🛠 Fix: Decompose into 3 tables

```sql
CREATE TABLE EmployeeProject (
    Employee VARCHAR(100),
    Project VARCHAR(100),
    PRIMARY KEY (Employee, Project)
);

CREATE TABLE ProjectSupplier (
    Project VARCHAR(100),
    Supplier VARCHAR(100),
    PRIMARY KEY (Project, Supplier)
);

CREATE TABLE EmployeeSupplier (
    Employee VARCHAR(100),
    Supplier VARCHAR(100),
    PRIMARY KEY (Employee, Supplier)
);

-- You can reconstruct original via natural join of these three.
```

---

## 📚 Summary Table

| Normal Form | Problem Solved                 | Fix Strategy                              |
| ----------- | ------------------------------ | ----------------------------------------- |
| 1NF         | Repeating groups, multi-values | Atomic columns                            |
| 2NF         | Partial dependency             | Remove to new table                       |
| 3NF         | Transitive dependency          | Factor non-key dependencies               |
| BCNF        | Super key issue                | Every determinant must be a candidate key |
| 4NF         | Multi-valued dependency        | Separate independent multi-valued data    |
| 5NF         | Join dependency                | Decompose into reconstructible tables     |

---
