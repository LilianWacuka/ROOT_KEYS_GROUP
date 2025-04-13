CREATE DATABASE bookdb;
USE bookdb;
-- 2Creating a table for customer orders
CREATE TABLE cust_order (
order_id INT PRIMARY KEY AUTO_INCREMENT,
 order_name VARCHAR(100)
);
INSERT INTO cust_order (order_name) VALUES
('Order A'),
('Order B'),
('Order C');
-- in this the order_id will refernce the order-id in the books and cust_orders to know how many books are available.
--CREATE TABLE ORDER_LINE AND ORDER-ID BEING THE REFERRNCE KEY 
CREATE TABLE order_line (
order_line_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT,
book_id INT,
quantity INT,
FOREIGN KEY (order_id) REFERENCES book(order_id)
FOREIGN KEY (order_id) REFERENCES cust_order(order_id));

-- Inserting values
INSERT INTO order_line (order_id, book_id, quantity) 
VALUES
(1, 1, 1),  
(1, 2, 2),  
(2, 3, 1),  
(2, 4, 1),  
(3, 5, 3); 

CREATE TABLE shipping_method(
shipping_id INT PRIMARY KEY AUTO_INCREMENT,
shipping_mode VARCHAR(200),
order_id INT
); 
ALTER TABLE cust_order
ADD CONSTRAINT fk_shipping_id
FOREIGN KEY (order_id) REFERENCES shipping_method(shipping_id);

INSERT INTO shipping_method (shipping_mode)
 VALUES
('Drop_shipping'),
('Local delivery'),
 ('In_store pickup');

 CREATE TABLE order_history(
history_id INT PRIMARY KEY AUTO_INCREMENT,
history_name VARCHAR (255),
order_id INT,
FOREIGN KEY (order_id) REFERENCES cust_order (order_id)
);
-- creating a table for order status
-- order_id will refernce the order-id in the books and cust_orders to know how many books are available.
CREATE TABLE order_status(
status_id INT PRIMARY KEY AUTO_INCREMENT,
status_name VARCHAR (255),
order_id INT,
FOREIGN KEY (order_id) REFERENCES book_id (order_id),
FOREIGN KEY (order_id) REFERENCES cust_order (order_id)
);
-- INSERTING DATA INTO order_history
INSERT INTO order_history(history_name)
VALUES
('Ordered'),
('Cancelled'),
('Delivered');

-- INSERTING DATA INTO order_status
INSERT INTO order_status(status_name)
VALUES
('Shipped'),
('Pending'),
('Delivered');

-- testing queries
SELECT * 
FROM order_line
WHERE book_id = 1;

SELECT status_name,status_id
FROM order_status
GROUP BY status_id
ORDER BY status_name ASC;

-- creating a new user
CREATE USER 'lilian'@'localhost' IDENTIFIED BY '234';
CREATE USER 'Faith'@'localhost' IDENTIFIED BY '235';
-- foreign key will reference the order_id in the books and cust_orders to know how many books are available.