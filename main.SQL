

-- create tableone by one
CREATE TABLE "books" (
  id SERIAL PRIMARY KEY,
  title VARCHAR(60) NOT NULL,
  publisherId INT NOT NULL,
  FOREIGN KEY (publisherId) REFERENCES "publishers" (id) ON DELETE CASCADE,
  publication_year INT CHECK (publication_year >= 1000 AND publication_year <= EXTRACT(YEAR FROM CURRENT_DATE)),-- mavjud bulmagan yillarni yozishlikni yonini olish uchun
  isbn VARCHAR(20) UNIQUE NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  categoryId INT NOT NULL,
  FOREIGN KEY (categoryId) REFERENCES "categories" (id) ON DELETE CASCADE,
  stock_quantity INT NOT NULL DEFAULT 0
);

CREATE TABLE "authors" (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(60) NOT NULL,
  last_name VARCHAR(60) NOT NULL,
  bio VARCHAR(255)
);

CREATE TABLE "book_authors" (
  bookId INT NOT NULL,
  authorId INT NOT NULL,
  PRIMARY KEY (bookId, authorId),
  FOREIGN KEY (bookId) REFERENCES "books" (id) ON DELETE CASCADE,
  FOREIGN KEY (authorId) REFERENCES "authors" (id) ON DELETE CASCADE
);

CREATE TABLE "publishers" (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(255) UNIQUE
);

CREATE TABLE "categories" (
  id SERIAL PRIMARY KEY,
  category_name VARCHAR(255) NOT NULL
);

CREATE TABLE "customers" (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(255) UNIQUE,
  address VARCHAR(255)
);

CREATE TABLE "orders" (
  id SERIAL PRIMARY KEY,
  customerId INT NOT NULL,
  FOREIGN KEY (customerId) REFERENCES "customers" (id) ON DELETE CASCADE,
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(30) CHECK (status IN ('pending', 'shipped', 'completed'))
);

CREATE TABLE "order_items" (
  id SERIAL PRIMARY KEY,
  order_id INT NOT NULL,
  FOREIGN KEY (order_id) REFERENCES "orders" (id) ON DELETE CASCADE,
  book_id INT NOT NULL,
  FOREIGN KEY (book_id) REFERENCES "books" (id) ON DELETE CASCADE,
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL
);

-- INSERTIONS
 INSERT INTO "publishers" (name, address, phone, email) VALUES
('Penguin Random House', '1745 Broadway, New York, NY', '212-782-9000', 'contact@penguinrandomhouse.com'),
('HarperCollins', '195 Broadway, New York, NY', '212-207-7000', 'info@harpercollins.com'),
('Simon & Schuster', '1230 Avenue of the Americas, New York, NY', '800-223-2336', 'support@simonandschuster.com');

INSERT INTO "categories" (category_name) VALUES
('Fiction'),
('Science Fiction'),
('Biography'),
('History'),
('Fantasy'),
('Self-Help');

INSERT INTO "authors" (first_name, last_name, bio) VALUES
('George', 'Orwell', 'English novelist, essayist, journalist and critic.'),
('J.K.', 'Rowling', 'British author, best known for the Harry Potter series.'),
('Isaac', 'Asimov', 'American writer and professor of biochemistry, known for sci-fi.'),
('Michelle', 'Obama', 'Former First Lady of the United States and author.');

INSERT INTO "books" (title, publisherId, publication_year, isbn, price, categoryId, stock_quantity) VALUES
('1984', 1, 1949, '978-0451524935', 9.99, 1, 50),
('Harry Potter and the Sorcerer''s Stone', 2, 1997, '978-0590353427', 12.99, 5, 100),
('Foundation', 3, 1951, '978-0553293357', 8.99, 2, 30),
('Becoming', 2, 2018, '978-1524763138', 16.99, 3, 20);
INSERT INTO "book_authors" (bookId, authorId) VALUES
(1, 1), 
(2, 2),  
(3, 3),
(4, 4); 

INSERT INTO "customers" (first_name, last_name, phone, email, address) VALUES
('John', 'Doe', '555-1234', 'john.doe@example.com', '123 Main St, Springfield'),
('Alice', 'Smith', '555-5678', 'alice.smith@example.com', '456 Oak St, Metropolis'),
('Bob', 'Johnson', '555-8765', 'bob.johnson@example.com', '789 Pine St, Gotham');

INSERT INTO "orders" (customerId, order_date, status) VALUES
(1, '2024-02-15 14:30:00', 'pending'),
(2, '2024-02-16 10:15:00', 'shipped'),
(3, '2024-02-17 16:45:00', 'completed');

INSERT INTO "order_items" (order_id, book_id, quantity, unit_price) VALUES
(1, 1, 2, 9.99), 
(1, 3, 1, 8.99), 
(2, 2, 1, 12.99), 
(3, 4, 1, 16.99); 

