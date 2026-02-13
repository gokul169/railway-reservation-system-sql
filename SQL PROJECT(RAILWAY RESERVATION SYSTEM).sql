--   RAILWAY RESERVATION SYSTEM – SQL PROJECT --

CREATE DATABASE railway_db;
USE railway_db;

CREATE TABLE trains (
    train_id INT PRIMARY KEY,
    train_name VARCHAR(50),
    source VARCHAR(50),
    destination VARCHAR(50)
);
CREATE TABLE passengers (
    passenger_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10)
);

CREATE TABLE tickets (
    ticket_id INT PRIMARY KEY,
    passenger_id INT,
    train_id INT,
    journey_date DATE,
    seat_no VARCHAR(10),
    status VARCHAR(20),

    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    FOREIGN KEY (train_id) REFERENCES trains(train_id)
);


CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    ticket_id INT,
    amount DECIMAL(10,2),
    payment_status VARCHAR(20),

    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id)
);


INSERT INTO trains VALUES
(101, 'Chennai Express', 'Chennai', 'Delhi'),
(102, 'Coimbatore Superfast', 'Coimbatore', 'Chennai'),
(103, 'Bangalore Mail', 'Bangalore', 'Hyderabad');
INSERT INTO passengers VALUES
(1, 'Arun', 22, 'Male'),
(2, 'Priya', 21, 'Female'),
(3, 'Rahul', 30, 'Male');
INSERT INTO tickets VALUES
(1001, 1, 101, '2026-03-01', 'S1-23', 'Confirmed'),
(1002, 2, 102, '2026-03-02', 'B2-10', 'Confirmed'),
(1003, 3, 101, '2026-03-01', 'S1-24', 'Cancelled');
INSERT INTO payments VALUES
(501, 1001, 1250.00, 'Paid'),
(502, 1002, 850.00, 'Paid'),
(503, 1003, 1250.00, 'Refunded');

-- Q1: Display all trains 
SELECT * FROM trains;

-- Q2: Find trains between Chennai and Delhi 
SELECT train_name
FROM trains
WHERE source = 'Chennai'
AND destination = 'Delhi';

-- Q3: Display passenger details with train info 
SELECT p.name, t.train_name, tk.seat_no, tk.journey_date
FROM passengers p
JOIN tickets tk ON p.passenger_id = tk.passenger_id
JOIN trains t ON tk.train_id = t.train_id;

-- Q4: Show all confirmed tickets 
SELECT *
FROM tickets
WHERE status = 'Confirmed';

-- Q5: Show all cancelled tickets 
SELECT *
FROM tickets
WHERE status = 'Cancelled';

-- Q6: Calculate total revenue generated 
SELECT SUM(amount) AS total_revenue
FROM payments
WHERE payment_status = 'Paid';

-- Q7: Calculate revenue per train (VERY IMPORTANT) 
SELECT t.train_name, SUM(py.amount) AS revenue
FROM payments py
JOIN tickets tk ON py.ticket_id = tk.ticket_id
JOIN trains t ON tk.train_id = t.train_id
WHERE py.payment_status = 'Paid'
GROUP BY t.train_name;

-- Q8: List passengers traveling on 2026-03-01 
SELECT p.name, tk.journey_date, t.train_name
FROM passengers p
JOIN tickets tk ON p.passenger_id = tk.passenger_id
JOIN trains t ON tk.train_id = t.train_id
WHERE tk.journey_date = '2026-03-01';

-- Q9: Count passengers per train 
SELECT t.train_name, COUNT(tk.passenger_id) AS total_passengers
FROM tickets tk
JOIN trains t ON tk.train_id = t.train_id
GROUP BY t.train_name;

-- Q10: Show non-paid / problematic payments 
SELECT *
FROM payments
WHERE payment_status <> 'Paid';

-- END OF PROJECT -- 
