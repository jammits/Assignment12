CREATE SCHEMA IF NOT EXISTS `Assignment12` DEFAULT CHARACTER SET utf8mb4;
USE `Assignment12`;

DROP TABLE IF EXISTS `Assignment12`.`Pizzas`;

CREATE TABLE IF NOT EXISTS `Assignment12`.`Pizzas`(
	pizza_id INT NOT NULL AUTO_INCREMENT,
    pizza_type VARCHAR(255) NOT NULL,
    price DECIMAL(6,2) NOT NULL,
    PRIMARY KEY (pizza_id)
);

DROP TABLE IF EXISTS `Assignment12`.`Customers`;

CREATE TABLE IF NOT EXISTS `Assignment12`.`Customers`(
	customer_id INT NOT NULL AUTO_INCREMENT,
    customer_first_name VARCHAR(255) NOT NULL,
    customer_last_name VARCHAR(255) NOT NULL,
    customer_phone_number VARCHAR(255) NOT NULL,
    PRIMARY KEY(customer_id)
    );


DROP TABLE IF EXISTS `Assignment12`.`Orders`;

CREATE TABLE IF NOT EXISTS `Assignment12`.`Orders`(
	order_id INT NOT NULL AUTO_INCREMENT,
    order_time DATETIME NOT NULL,
    PRIMARY KEY(order_id)
);
    
DROP TABLE IF EXISTS `Assignment12`.`CustomersOrders`;

CREATE TABLE IF NOT EXISTS `Assignment12`.`CustomersOrders`(
	customer_id INT NOT NULL,
    order_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES `Assignment12`.`Customers` (customer_id),
    FOREIGN KEY (order_id) REFERENCES `Assignment12`.`Orders` (order_id)
);

DROP TABLE IF EXISTS `Assignment12`.`OrdersPizzas`;

CREATE TABLE IF NOT EXISTS `Assignment12`.`OrdersPizzas`(
	order_id INT NOT NULL,
    pizza_id INT NOT NULL,
    FOREIGN KEY (pizza_id) REFERENCES `Assignment12`.`Pizzas` (pizza_id),
    FOREIGN KEY (order_id) REFERENCES `Assignment12`.`Orders` (order_id)
);

-- Populating tables Q3

INSERT INTO `Assignment12`.`Customers`(customer_first_name, customer_last_name, customer_phone_number)
VALUES ('Trevor', 'Page', '226-555-4982'),
('John', 'Doe', '555-555-9498');

INSERT INTO `Assignment12`.`Orders`(order_time)
VALUES ('2014/9/10 09:47:00'),
('2014/9/10 13:20:00'),
('2014/9/10 09:47:00');

INSERT INTO `Assignment12`.`Pizzas` (pizza_type, price)
VALUES ('Pepperoni & Cheese', 7.99),
('Vegetarian', 9.99),
('Meat Lovers', 14.99),
('Hawaiian', 12.99);

INSERT INTO `Assignment12`.`CustomersOrders` (customer_id, order_id)
VALUES(1,1),
(2,2),
(1,3);

INSERT INTO `Assignment12`.`OrdersPizzas` (order_id, pizza_id)
VALUES (1,1),
(1,3),
(2,2),
(2,3),
(2,3),
(3,3),
(3,4);


-- Q4

SELECT c.*, SUM(PRICE) AS total_spent
FROM Customers c join CustomersOrders co ON c.customer_id = co.customer_id
join Orders o ON o.order_id = co.order_id
join OrdersPizzas op ON op.order_id = o.order_id
join Pizzas p on p.pizza_id = op.pizza_id
GROUP BY c.customer_id
ORDER BY SUM(PRICE) DESC
LIMIT 1;

-- Q5 

SELECT c.*, SUM(PRICE) AS total_spent, o.order_time
FROM Customers c join CustomersOrders co ON c.customer_id = co.customer_id
join Orders o ON o.order_id = co.order_id
join OrdersPizzas op ON op.order_id = o.order_id
join Pizzas p on p.pizza_id = op.pizza_id
GROUP BY c.customer_id, o.order_time
ORDER BY SUM(PRICE) DESC;