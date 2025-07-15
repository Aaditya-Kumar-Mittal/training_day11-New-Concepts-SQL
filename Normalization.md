# ✅ Normalization - Notes with Examples

<!-- markdownlint-disable MD024 -->

## ⭐ Key Objectives

* Make data **easy to understand**.
* Make database **easy to enhance and extend**.
* **Avoid anomalies** in Insert, Update, Delete operations.

---

## 🔑 Criteria for Normal Forms

* 1NF (First Normal Form)
* 2NF (Second Normal Form)
* 3NF (Third Normal Form)
* BCNF (Boyce-Codd Normal Form)
* 4NF (Fourth Normal Form)
* 5NF (Fifth Normal Form)

---

## 📌 First Normal Form (1NF)

> 🔍 Eliminate repeating groups and ensure atomicity.

### ✅ Rules

* Every column should contain **atomic values**.
* No **repeating groups** (no multiple values in one column).
* All entries in a column must be of the **same data type**.
* The table must have a **primary key**.
* Row **order should not carry information**.

### ❌ Violations

* Storing multiple values in one cell:

  ```plaintext
  StudentID | Name    | Courses
  ----------|---------|---------------------
  101       | Alice   | Math, Physics, Chem  ❌ (Multiple values)
  ```

* Mixing data types in a column:

  ```plaintext
  StudentID | Age
  ----------|-----
  101       | 20
  102       | Twenty-One ❌ (Inconsistent type)
  ```

* No primary key:

  ```plaintext
  Name  | Course
  ------|-------
  Raj   | Math
  Raj   | Science ❌ (No uniqueness)
  ```

### ✅ 1NF Compliant Example

```plaintext
StudentID | Name   | Course
----------|--------|-------
101       | Alice  | Math
101       | Alice  | Physics
102       | Bob    | Chemistry
```

---

## 📌 Second Normal Form (2NF)

> 🔍 Remove Partial Dependency (applies to tables with composite primary keys).

### ✅ Rules

* Table must be in **1NF**.
* All non-key attributes must depend on the **entire primary key** (not just part of it).

### ❌ Violation

```plaintext
Table: Enrollment (StudentID, CourseID, StudentName)

Composite Key: (StudentID, CourseID)

Issue: StudentName depends only on StudentID — Partial Dependency ❌
```

### ✅ 2NF Solution

Split into two tables:

```plaintext
Student Table:
StudentID | StudentName
----------|-------------
101       | Alice

Enrollment Table:
StudentID | CourseID
----------|----------
101       | MATH101
```

---

## 📌 Third Normal Form (3NF)

> 🔍 Remove Transitive Dependency.

### ✅ Rules

* Table must be in **2NF**.
* Non-key attributes should **not depend on another non-key attribute** (No transitive dependency).
* Every non-key attribute must depend **only on the primary key**.

### ❌ Violation

```plaintext
Table: Student (StudentID, Name, DepartmentID, DepartmentName)

DepartmentName depends on DepartmentID, which is a non-key → Transitive Dependency ❌
```

### ✅ 3NF Solution

Break into two tables:

```plaintext
Student Table:
StudentID | Name   | DepartmentID
----------|--------|--------------
101       | Alice  | D01

Department Table:
DepartmentID | DepartmentName
-------------|----------------
D01          | Computer Science
```

---

## 📌 Boyce-Codd Normal Form (BCNF)

> 🔍 A stronger version of 3NF.

### ✅ Rules

* Table must be in **3NF**.
* For every functional dependency X → Y, X must be a **super key**.

### ❌ Violation Example

```plaintext
Table: Courses (Course, Instructor, Room)

Assumptions:
- Each course is taught by only one instructor.
- Each room can have only one instructor.

FDs:
Course → Instructor ✅
Room → Instructor ❌ (Room is not a key)

This violates BCNF
```

### ✅ BCNF Solution

Split into:

```plaintext
Course-Instructor:
Course | Instructor

Room-Instructor:
Room | Instructor
```

---

## 📌 Fourth Normal Form (4NF)

> 🔍 Eliminate **multi-valued dependencies**.

### ✅ Rules

* Table must be in **BCNF**.
* **No multi-valued dependencies** — each fact should be stored in **one place only**.

### ❌ Violation Example

```plaintext
Table: StudentHobbyLanguage (StudentID, Hobby, Language)

Data:
101 | Painting | English
101 | Painting | Hindi
101 | Dancing  | English
101 | Dancing  | Hindi

→ Two independent sets: Hobby and Language per StudentID → Multi-valued dependency ❌
```

### ✅ 4NF Solution

Break into two separate tables:

```plaintext
StudentHobby:
StudentID | Hobby
----------|--------
101       | Painting
101       | Dancing

StudentLanguage:
StudentID | Language
----------|----------
101       | English
101       | Hindi
```

---

## ✅ Summary Table

| Normal Form | Eliminates                        | Key Focus                                   |
| ----------- | --------------------------------- | ------------------------------------------- |
| 1NF         | Repeating groups                  | Atomic columns, no multi-values             |
| 2NF         | Partial dependency                | Full dependency on entire primary key       |
| 3NF         | Transitive dependency             | No non-key depending on another non-key     |
| BCNF        | Any anomaly due to candidate keys | LHS of every FD must be a super key         |
| 4NF         | Multi-valued dependency           | Independent multivalued facts are separated |

---
