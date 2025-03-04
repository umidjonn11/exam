

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

/*
--CREATE TABLES
CREATE TABLE groups (
    id SERIAL PRIMARY KEY,
    group_name VARCHAR(50) UNIQUE NOT NULL,
    max_students INT CHECK (max_students BETWEEN 5 AND 30)
);

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE CHECK (birth_date < '2010-01-01'),
    group_id INT NOT NULL REFERENCES groups(id)
    ON DELETE CASCADE 
    ON UPDATE CASCADE
);

CREATE TABLE teachers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F'))
);

CREATE TABLE subjects (
    id SERIAL PRIMARY KEY,
    subject_name VARCHAR(100) UNIQUE NOT NULL,
    teacher_id INT NOT NULL REFERENCES teachers(id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

CREATE TABLE enrollment (
    id SERIAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES students(id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    subject_id INT NOT NULL REFERENCES subjects(id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    enroll_date DATE NOT NULL,
    grade INT CHECK (grade BETWEEN 1 AND 5)
);

--INSERTIONS
  INSERT INTO groups (group_name, max_students) VALUES
('Group A', 25),
('Group B', 20),
('Group C', 15);
INSERT INTO teachers (first_name, last_name, gender) VALUES
('John', 'Smith', 'M'),
('Emily', 'Johnson', 'F'),
('Michael', 'Brown', 'M');
INSERT INTO subjects (subject_name, teacher_id) VALUES
('Mathematics', 1),
('History', 2),
('Physics', 3);
INSERT INTO students (first_name, last_name, birth_date, group_id) VALUES
('Alice', 'Walker', '2008-05-14', 1),
('Bob', 'Davis', '2009-07-21', 2),
('Charlie', 'Evans', '2007-12-10', 3);
INSERT INTO enrollment (student_id, subject_id, enroll_date, grade) VALUES
(1, 1, '2024-01-15', 4),
(2, 2, '2024-01-16', 5),
(3, 3, '2024-01-17', 3);


-- UPDATE USERS GROUP
UPDATE students
SET group_id = 2
WHERE id = 1;


--DELETE SUBJECT
DELETE FROM subjects
WHERE id = 3;


--DUPLICATE
INSERT INTO groups (group_name, max_students) VALUES ('Group A', 15);--RETURNS AN ERROR BECAUSE GROUP_NAME IS UNIQUE 


--CONSTRAINT CHECK
INSERT INTO teachers (first_name, last_name, gender) VALUES('John', 'Smith', 'X');-- RETURNS AN ERROR BECAUSE ONLY M OR F IS ALLOWED


--INNER JOIN
SELECT students.first_name, students.last_name, subjects.subject_name, enrollment.grade
FROM enrollment
INNER JOIN students ON enrollment.student_id = students.id
INNER JOIN subjects ON enrollment.subject_id = subjects.id;
--RETURNS
 first_name | last_name | subject_name | grade
------------+-----------+--------------+-------
 Alice      | Walker    | Mathematics  |     4
 Bob        | Davis     | History      |     5


--LEFT JOIN
SELECT students.first_name, students.last_name, subjects.subject_name, enrollment.grade
FROM students
LEFT JOIN enrollment ON students.id = enrollment.student_id
LEFT JOIN subjects ON enrollment.subject_id = subjects.id;
--RETURNS
 first_name | last_name | subject_name | grade
------------+-----------+--------------+-------
 Alice      | Walker    | Mathematics  |     4
 Bob        | Davis     | History      |     5
 Charlie    | Evans     |              |


--RIGHT JOIN 
SELECT students.id, students.first_name, students.last_name, groups.group_name
FROM students
RIGHT JOIN groups ON students.group_id = groups.id;
--RETURNS
first_name | last_name | subject_name | grade
------------+-----------+--------------+-------
 Alice      | Walker    | Mathematics  |     4
 Bob        | Davis     | History      |     5
            |           | Geography    |


--GROUP BT, HAVING
select first_name, count(*) from students group by first_name having count(*)>1;--DOES NOT RETURNS ANYTHING BECAUSE EACH NAME COMES ONLY ONE TIME


--ON DELETE CASCADE
DELETE FROM subjects
WHERE id = 3; --THIS SUBJECT AUTOMATICALLY DELETES FROM ENROLLMENT BECAUSE OF ON DELETE CASCADE;

--ON UPDATE CASCADE
UPDATE students
SET group_id = 2
WHERE id = 1;

--ORDER BY, LIMIT
 SELECT last_name FROM students ORDER BY last_name LIMIT 2;
 --RETURNS
  last_name
-----------
 Davis
 Evans


 --LIMIT, OFFSET
 SELECT last_name FROM students  LIMIT 2 OFFSET 1;
--RETURNS
 last_name
-----------
 Evans
 Walker
--SKIPS THE FIRST ONE AND RETURNS NEXT 2 STUDENTS


--LIKE,ILIKE
SELECT last_name FROM students WHERE last_name LIKE '%a%';
SELECT last_name FROM students WHERE last_name ILIKE '%a%';--DIFFERS FROM LIKE,ONLY BECAUSE IT MATCHES BOTH UPPERCASE AND LOWERCASE CHARACTERS
--RETURNS
 last_name
-----------
 Davis
 Evans
 Walker

 --IN
  SELECT id FROM students WHERE id IN(1,3);
--RETURNS
 id
----
  1
  3


--BETWEEN
SELECT id FROM students WHERE id BETWEEN 1 AND 3;
--RETURNS
 id
----
  1
  2
  3


--EXISTS
SELECT * FROM students WHERE EXISTS (SELECT * FROM enrollment WHERE students.id = enrollment.student_id AND grade = 5);
--RETURNS 
 id | first_name | last_name | birth_date | group_id
----+------------+-----------+------------+----------
  2 | Bob        | Davis     | 2009-07-21 |        2



CREATE TABLE departments(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE workers(
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  role VARCHAR(100) NOT NULL,
  salary INT NOT NULL,
  department_id INT NOT NULL, 
  FOREIGN KEY (department_id) REFERENCES "departments" (id) ON DELETE CASCADE
);
*/