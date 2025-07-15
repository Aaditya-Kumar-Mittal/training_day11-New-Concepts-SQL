SHOW DATABASES;

USE testdb3;

CREATE TABLE
  customers (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    age INT
  );

SHOW TABLES;

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

SELECT * FROM customers;