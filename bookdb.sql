use cinemadb;
-- CREATE TABLE orders (
--     order_id INT PRIMARY KEY AUTO_INCREMENT,
--     order_name VARCHAR(100) -- e.g., 'Order A', 'Order B', etc.
-- );
-- CREATE TABLE books (
--     book_id INT PRIMARY KEY AUTO_INCREMENT,
--     book_name VARCHAR(255)
-- );
-- CREATE TABLE order_line (
--     order_line_id INT PRIMARY KEY AUTO_INCREMENT,
--     order_id INT,
--     book_id INT,
--     quantity INT DEFAULT 1,
--     FOREIGN KEY (order_id) REFERENCES orders(order_id),
--     FOREIGN KEY (book_id) REFERENCES books(book_id)
-- );
-- INSERT INTO books (book_name) VALUES
-- ('The Alchemist'),
-- ('1984'),
-- ('The Great Gatsby'),
-- ('Atomic Habits'),
-- ('Harry Potter and the Sorcerer''s Stone');

-- INSERT INTO orders (order_name) VALUES
-- ('Order A'),
-- ('Order B'),
-- ('Order C');

-- INSERT INTO order_line (order_id, book_id, quantity) VALUES
-- (1, 1, 1),  -- Order A: The Alchemist
-- (1, 2, 2),  -- Order A: 2 copies of 1984
-- (2, 3, 1),  -- Order B: The Great Gatsby
-- (2, 4, 1),  -- Order B: Atomic Habits
-- (3, 5, 3);  -- Order C: 3 copies of Harry Potter
select * 
from order_line
WHERE order_id = 1;



