# SQL Indexes

## Table of Contents

- [SQL Indexes](#sql-indexes)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Why Use Indexes](#why-use-indexes)
  - [Core Concepts](#core-concepts)
  - [Types of Indexes](#types-of-indexes)
  - [When to Use an Index](#when-to-use-an-index)
  - [SQL Operations on Indexes](#sql-operations-on-indexes)
    - [1. **Create Index**](#1-create-index)
    - [2. **Create Composite Index**](#2-create-composite-index)
    - [3. **Create Unique Index**](#3-create-unique-index)
    - [4. **Drop Index**](#4-drop-index)
    - [5. **See Indexes**](#5-see-indexes)
  - [Practical SQL Examples](#practical-sql-examples)
    - [1. Create a Table](#1-create-a-table)
    - [2. Create Index on Single Column](#2-create-index-on-single-column)
    - [3. Create Composite Index](#3-create-composite-index)
    - [4. Create Unique Index](#4-create-unique-index)
    - [5. Query that Benefits from Index](#5-query-that-benefits-from-index)
    - [6. Drop an Index](#6-drop-an-index)
    - [7. Force Index Use (MySQL)](#7-force-index-use-mysql)
  - [Best Practices](#best-practices)

---

## Introduction

Indexes in SQL are **data structures** that improve the speed of data retrieval operations on a database table at the cost of additional **writes** and **storage**. Think of an index as a **book index** — it lets you quickly find the pages that mention a topic, rather than scanning every page.

---

## Why Use Indexes

- Improve **SELECT** query performance.
- Speed up **JOINs**, **WHERE**, **ORDER BY**, and **GROUP BY** operations.
- Reduce table scan time.
- Provide **uniqueness** constraint in some types.

---

## Core Concepts

Here are the foundational concepts you should understand:

1. **B-Tree Structure**: Most relational databases use B-Trees to organize indexes. Fast lookup, insertion, and deletion are possible with B-Trees.
2. **Clustered vs Non-Clustered Index**:

   - Clustered Index defines the **physical order** of data in a table.
   - Non-Clustered Index maintains a separate structure and has **pointers** to actual table rows.

3. **Composite Index**: Index on **multiple columns**.
4. **Covering Index**: Index that includes **all columns** required to satisfy a query, avoiding lookup in the table.
5. **Index Selectivity**: Ratio of distinct values. High selectivity = better index performance.
6. **Fill Factor**: Defines the percentage of space on each leaf-level page to be filled with data.
7. **Index Scan vs Seek**:

   - **Seek** = fast; index can directly find the data.
   - **Scan** = slower; checks many rows.

---

## Types of Indexes

| Index Type                       | Description                               |
| -------------------------------- | ----------------------------------------- |
| **Primary Index**                | Automatically created on the primary key. |
| **Unique Index**                 | Ensures all values are unique.            |
| **Composite Index**              | Covers multiple columns.                  |
| **Full-text Index**              | Used for searching large text columns.    |
| **Spatial Index**                | Used for geospatial data.                 |
| **Bitmap Index** (in some DBMSs) | Efficient for low-cardinality columns.    |

---

## When to Use an Index

✅ Use index on:

- Columns used in **WHERE**, **JOIN**, **ORDER BY**, **GROUP BY**.
- High-selectivity columns.
- Foreign key columns.

❌ Avoid index on:

- Frequently updated columns (adds overhead).
- Low-selectivity columns (e.g., boolean).
- Small tables (full table scan might be faster).

---

## SQL Operations on Indexes

### 1. **Create Index**

```sql
CREATE INDEX idx_customer_name ON customers(name);
```

### 2. **Create Composite Index**

```sql
CREATE INDEX idx_customer_name_city ON customers(name, city);
```

### 3. **Create Unique Index**

```sql
CREATE UNIQUE INDEX idx_email_unique ON customers(email);
```

### 4. **Drop Index**

```sql
DROP INDEX idx_customer_name; -- MySQL
-- SQL Server / PostgreSQL syntax differs:
DROP INDEX idx_customer_name ON customers;
```

### 5. **See Indexes**

```sql
-- MySQL
SHOW INDEXES FROM customers;

-- PostgreSQL
SELECT * FROM pg_indexes WHERE tablename = 'customers';

-- SQL Server
EXEC sp_helpindex 'customers';
```

---

## Practical SQL Examples

### 1. Create a Table

```sql
CREATE TABLE customers (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  city VARCHAR(50),
  created_at DATE
);
```

### 2. Create Index on Single Column

```sql
CREATE INDEX idx_name ON customers(name);
```

### 3. Create Composite Index

```sql
CREATE INDEX idx_name_city ON customers(name, city);
```

### 4. Create Unique Index

```sql
CREATE UNIQUE INDEX idx_email ON customers(email);
```

### 5. Query that Benefits from Index

```sql
SELECT * FROM customers WHERE name = 'John Doe';
```

### 6. Drop an Index

```sql
DROP INDEX idx_name; -- MySQL
-- or PostgreSQL:
DROP INDEX idx_name;
-- or SQL Server:
DROP INDEX customers.idx_name;
```

### 7. Force Index Use (MySQL)

```sql
SELECT * FROM customers FORCE INDEX (idx_name) WHERE name = 'John Doe';
```

---

## Best Practices

- Use **EXPLAIN** to check if indexes are being used.
- Don’t **over-index**: each index adds overhead to INSERT/UPDATE/DELETE.
- Prefer **covering indexes** for read-heavy queries.
- Avoid **functions** on indexed columns in WHERE clauses (e.g., `WHERE UPPER(name) = 'AADI'`).
- Periodically **rebuild/reorganize** indexes in large databases.

---
# training_day11-New-Concepts-SQL
