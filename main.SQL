--CREATE DATBASE
CREATE DATABASE reservation;

--CONNECT TO DATABASE
\c reservation;

--CREATE TABLES BY ORDER
CREATE Table "customer" (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50),
  password VARCHAR(240) UNIQUE,
  email VARCHAR(50) UNIQUE,
  role  VARCHAR(20) CHECK (role IN ('admin', 'user', 'manager'))
);
CREATE Table "location"(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(100),
    capacity INTEGER,
    address VARCHAR(50),
    status VARCHAR(20) CHECK(status IN('available','unavailable'))
);
CREATE Table "reservation"(
    id SERIAL PRIMARY KEY,
    customerId INT NOT NULL,
    FOREIGN KEY (customerId) REFERENCES "customer" (id) ON DELETE CASCADE,
    locationId INT NOT NULL,
    FOREIGN KEY (locationId) REFERENCES "location" (id) ON DELETE CASCADE,
    reservationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    startTime TIMESTAMP,
    endTime TIMESTAMP,
    status VARCHAR(30) CHECK(status IN('pending','confirmed','cancelled'))
);
CREATE Table "payment"(
    id SERIAL PRIMARY KEY,
    reservationId INT NOT NULL,
    FOREIGN KEY (reservationId) REFERENCES "reservation" (id) ON DELETE CASCADE,
    amount DECIMAL(10,2),
    method VARCHAR(30) CHECK(method IN('credit card','bank transfer','paypal')),
    status VARCHAR(30) CHECK(status IN('pending','completed','failed'))
);

--INSERTIONS
INSERT INTO "customer" (username, password, email,role ) VALUES('umid', 'qwer12345', 'umid@gmail.com','user') RETURning*;
INSERT INTO "location" (name, description, capacity,address,status ) VALUES('Homptson Hotel', 'beautiful', 1000,'New-York', 'available') RETURning*;
INSERT INTO "reservation" (customerId, locationId, startTime, endTime, status) VALUES (1, 1, '2025-02-16 14:30:00', '2025-02-16 16:30:00', 'pending');
INSERT INTO "payment" (reservationId, amount, method, status) VALUES (1, 150.00, 'credit card', 'completed');


--LAST STEP:CONNECTIONS IN ORDER TO CONNECT TABLES TO EACH OTHER SO THAT THEY CAN INTERACT.
SELECT 
  r.id AS reservation_id, 
  r.reservationDate, 
  r.startTime, 
  r.endTime, 
  r.status AS reservation_status,
  p.amount AS payment_amount, 
  p.method AS payment_method, 
  p.status AS payment_status
FROM 
  "reservation" r
JOIN 
  "payment" p ON r.id = p.reservationId
WHERE 
  r.id = 1;  
