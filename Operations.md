# 📘 Index Operations with Pointer Description

## 🔍 Introduction

Indexes in SQL use **tree-like structures** (usually **B+ Trees**) where **nodes** point to rows in the data file. This helps reduce the number of rows scanned during a query. When you search by an indexed column, the DB engine uses **binary search-like logic** through the index to find row locations faster.

- It works by creating a separate data structure that provides pointers to the rows in a table. Which makes it faster to look up rows based on specific column values. Indexes act as a table of contents for a database, allowing the server to locate data quickly and efficiently, reducing disk I/O operations.
- Faster Queries: Speeds up SELECT and JOIN operations.
- Lower Disk I/O: Reduces the load on your database by limiting the amount of data scanned.
- Better Performance on Large Tables: Essential when working with millions of records.

---

## 🧩 Step-by-Step SQL Index Operations

### ✅ 1. Create Table

```sql
CREATE TABLE customers (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  city VARCHAR(50),
  age INT
);
```

---

### ✅ 2. Insert Sample Data

```sql
INSERT INTO customers (id, name, email, city, age) VALUES
(1, 'Alice', 'alice@example.com', 'New York', 28),
(2, 'Bob', 'bob@example.com', 'Los Angeles', 35),
(3, 'Charlie', 'charlie@example.com', 'Chicago', 22),
(4, 'David', 'david@example.com', 'New York', 40),
(5, 'Eva', 'eva@example.com', 'Miami', 30),
(6, 'Frank', 'frank@example.com', 'Chicago', 26),
(7, 'Grace', 'grace@example.com', 'Seattle', 29),
(8, 'Heidi', 'heidi@example.com', 'Austin', 33),
(9, 'Ivan', 'ivan@example.com', 'Boston', 31),
(10, 'Judy', 'judy@example.com', 'Seattle', 27);
```

---

### ✅ 3. Create Indexes

#### 🔹 3.1 Index on `name`

```sql
CREATE INDEX idx_name ON customers(name);
```

#### 🔹 3.2 Composite Index on `city` and `age`

```sql
CREATE INDEX idx_city_age ON customers(city, age);
```

#### 🔹 3.3 Unique Index on `email`

```sql
CREATE UNIQUE INDEX idx_email_unique ON customers(email);
```

---

### ✅ 4. Query with and without Index

#### 🔸 Without Index (on age)

```sql
SELECT * FROM customers WHERE age = 30;
-- Full Table Scan
```

#### 🔸 With Index (on name)

```sql
SELECT * FROM customers WHERE name = 'Alice';
-- Uses idx_name -> Fast B+ Tree lookup
```

#### 🔸 With Composite Index

```sql
SELECT * FROM customers WHERE city = 'Chicago' AND age = 26;
-- Uses idx_city_age efficiently
```

---

### ✅ 5. View Indexes

#### 🟢 MySQL

```sql
SHOW INDEXES FROM customers;
```

#### 🟢 PostgreSQL

```sql
SELECT * FROM pg_indexes WHERE tablename = 'customers';
```

#### 🟢 SQL Server

```sql
EXEC sp_helpindex 'customers';
```

---

### ✅ 6. Drop Index

```sql
DROP INDEX idx_name; -- MySQL / PostgreSQL
-- SQL Server:
DROP INDEX customers.idx_name;
```

---

## 📌 Internal Working: Index with Pointers

Let’s break down how indexing works **internally** using a simplified B+ Tree.

### 🧠 Example: `CREATE INDEX idx_name ON customers(name);`

When you run:

```sql
SELECT * FROM customers WHERE name = 'Grace';
```

Here’s what happens:

#### ✅ B+ Tree Index (Simplified)

```plaintext
       [D]         <- Root Node (sorted keys)
     /     \
 [A B C]   [E F G H I J]    <- Leaf Nodes
```

- B+ Tree stores values in **sorted order** (`A` to `J`).
- Each **leaf node contains pointers** to the actual row in the **table (heap)**.

#### ✅ Pointers in action

- Lookup for `'Grace'` starts at the **root**, goes to the second leaf block (`E F G H...`), and finds `'Grace'`.
- The leaf node then uses a **pointer (row ID)** to retrieve the full row from the table file.

#### 📉 Without Index

- The DB performs **full scan**: starts at row 1, checks each row until it finds `'Grace'`.

---

### 📘 Composite Index: `CREATE INDEX idx_city_age ON customers(city, age);`

B+ Tree keys are formed like tuples:

```plaintext
('Chicago', 22) → pointer to row
('Chicago', 26) → pointer
('New York', 28) → pointer
```

A query like:

```sql
SELECT * FROM customers WHERE city = 'Chicago' AND age = 26;
```

uses **binary search on combined key** and retrieves the row in just **1-2 IOs**.

But:

```sql
SELECT * FROM customers WHERE age = 26;
```

**will not** use this index efficiently unless the **leading column** (`city`) is also filtered.

---

## 🏁 Summary

| Operation       | SQL                            | Description                                          |
| --------------- | ------------------------------ | ---------------------------------------------------- |
| Create Index    | `CREATE INDEX`                 | Builds B+ Tree with pointers to table rows           |
| Use Index       | `SELECT WHERE ...`             | Speeds up lookup using binary search                 |
| Composite Index | `CREATE INDEX ON (col1, col2)` | Searches efficiently only if leftmost column is used |
| Unique Index    | `CREATE UNIQUE INDEX`          | Enforces uniqueness                                  |
| Drop Index      | `DROP INDEX`                   | Deletes index, fall back to full scan                |

---
