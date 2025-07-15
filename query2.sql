CREATE INDEX idx_name ON customers(name);

SHOW INDEXES FROM customers;

CREATE INDEX idx_city_age ON customers(city, age);

CREATE UNIQUE INDEX idx_email_unique ON customers(email);

SELECT * FROM customers;
SELECT * FROM customers WHERE age = 30; -- FULL SCAN
SELECT * FROM customers;
SELECT * FROM customers WHERE name = "Alice"; -- Uses idx_name -> Fast B+ Tree lookup

SELECT * FROM customers WHERE city = 'Chicago' AND age = 26; -- -- Uses idx_city_age efficiently

SHOW INDEXES FROM customers;

DROP INDEX idx_name ON customers;