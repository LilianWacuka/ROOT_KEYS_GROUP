-- ========================================
-- USER MANAGEMENT SECTION
-- ========================================

-- Create user: faith_dev (developer - full access)
CREATE USER 'faith_dev'@'localhost' IDENTIFIED BY '123!';
GRANT ALL PRIVILEGES ON bookstore_db.* TO 'faith_dev'@'localhost';

-- Create user: data_entry (can insert/update data only)
CREATE USER 'data_entry'@'localhost' IDENTIFIED BY '456!';
GRANT SELECT, INSERT, UPDATE ON bookstore_db.* TO 'data_entry'@'localhost';

-- Create user: viewer (read-only access)
CREATE USER 'viewer'@'localhost' IDENTIFIED BY '789!';
GRANT SELECT ON bookstore_db.* TO 'viewer'@'localhost';

-- Apply changes
FLUSH PRIVILEGES;

-- ===========================================
-- FAITH'S SECTION: FIRST FIVE TABLES SETUP
-- ===========================================

-- Table 1: publisher
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Table 2: book_language
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(100) NOT NULL
);

-- Table 3: author
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

-- Table 4: book
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publisher_id INT,
    language_id INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

-- Table 5: book_author
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- ========================================
--  Insert sample data into each table
-- ========================================

INSERT INTO publisher (name)
VALUES 
    ('Penguin Books'),
    ('O\'Reilly Media'),
    ('HarperCollins'),
    ('Random House'),
    ('Simon & Schuster');

INSERT INTO book_language (language_name)
VALUES 
    ('English'),
    ('Spanish'),
    ('French'),
    ('German'),
    ('Swahili');

INSERT INTO author (first_name, last_name)
VALUES 
    ('George', 'Orwell'),
    ('Jane', 'Austen'),
    ('Chinua', 'Achebe'),
    ('J.K.', 'Rowling'),
    ('Gabriel', 'Garcia Marquez');

INSERT INTO book (title, publisher_id, language_id, price)
VALUES 
    ('1984', 1, 1, 19.99),
    ('Pride and Prejudice', 2, 1, 14.50),
    ('Things Fall Apart', 3, 5, 22.00),
    ('Harry Potter and the Sorcerer\'s Stone', 4, 1, 29.99),
    ('One Hundred Years of Solitude', 5, 3, 25.75);

INSERT INTO book_author (book_id, author_id)
VALUES 
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

-- ========================================
-- Creating tables for orders
-- ========================================

CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_name VARCHAR(100)
);

INSERT INTO cust_order (order_name) VALUES
('Order A'), ('Order B'), ('Order C');

CREATE TABLE order_line (
    order_line_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    book_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

INSERT INTO order_line (order_id, book_id, quantity) 
VALUES
(1, 1, 1),  
(1, 2, 2),  
(2, 3, 1),  
(2, 4, 1),  
(3, 5, 3); 

CREATE TABLE shipping_method (
    shipping_id INT PRIMARY KEY AUTO_INCREMENT,
    shipping_mode VARCHAR(200),
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id)
);

INSERT INTO shipping_method (shipping_mode)
VALUES
('Drop_shipping'),
('Local delivery'),
('In_store pickup');

CREATE TABLE order_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    history_name VARCHAR(255),
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id)
);

INSERT INTO order_history (history_name)
VALUES
('Ordered'),
('Cancelled'),
('Delivered');

CREATE TABLE order_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(200)
);

INSERT INTO order_status (status_name)
VALUES
('Shipped'),
('Pending'),
('Delivered');

-- ========================================
-- Customer and address setup
-- ========================================

USE bookdb;

CREATE TABLE customer (
    customer_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255),
    phone VARCHAR(20)
);

INSERT INTO customer (first_name, last_name, email, phone)
VALUES
('Jean','Bikou','jean.bikou@cameroonmail.com','237-123-9876'),
('Miriam','Ngoa','miriam.ngoa@cameroonmail.com','237-765-4321'),
('Claude','Tchatchouang','claude.tchatchouang@nigerianmail.com','234-123-4567'),
('Bernadette','Mouafo','bernadette.mouafo@southafricamail.co.za','27-987-6543'),
('Emmanuel','Moukouri','emmanuel.moukouri@kenyanmail.co.ke','254-234-5678');

CREATE TABLE customer_address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    address_name VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

INSERT INTO customer_address (customer_id, address_name)
VALUES 
(1, '123 Main Street'),
(2, '456 Oak Avenue'),
(3, '789 Pine Road'),
(4, '321 Maple Drive'),
(5, '654 Elm Street');

CREATE TABLE address_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(200),
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES customer_address(address_id)
);

INSERT INTO address_status (status_name)
VALUES
('Current'),
('Old');

CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL,
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES customer_address(address_id)
);

INSERT INTO country (country_name)
VALUES 
('Cameroon'),
('Nigeria'),
('South Africa'),
('Kenya'),
('Ghana');

-- ========================================
-- TESTING QUERIES SECTION
-- ========================================

SELECT * FROM book;

SELECT CONCAT(first_name, ' ', last_name) AS author_name FROM author;

SELECT  
    b.title AS book_title,
    CONCAT(a.first_name, ' ', a.last_name) AS author_name
FROM  
    book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id;

SELECT 
    b.title AS book_title,
    l.language_name
FROM 
    book b
JOIN book_language l ON b.language_id = l.language_id;

SELECT  
    p.name AS publisher_name,
    COUNT(b.book_id) AS number_of_books
FROM  
    publisher p
LEFT JOIN book b ON p.publisher_id = b.publisher_id
GROUP BY p.name;

SELECT status_name, status_id
FROM order_status
GROUP BY status_id
ORDER BY status_name ASC;

-- Additional user creation
CREATE USER 'lilian'@'localhost' IDENTIFIED BY '234';
CREATE USER 'Faith'@'localhost' IDENTIFIED BY '235';
