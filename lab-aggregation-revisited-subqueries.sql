USE sakila;

-- Select the first name, last name, and email address of all the customers who have rented a movie
SELECT first_name, last_name, email
FROM customer;

-- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made)
SELECT C.customer_id, CONCAT(C.first_name, ' ', C.last_name) AS full_name, ROUND(AVG(P.amount), 2) as avg_payment
FROM customer AS C
INNER JOIN payment AS P
ON C.customer_id = P.customer_id
GROUP BY customer_id;

-- Select the name and email address of all the customers who have rented the "Action" movies.
-- Write the query using multiple join statements

SELECT DISTINCT C.customer_id, CONCAT(C.first_name, ' ', C.last_name) AS name, C.email, CA.name
FROM customer AS C
INNER JOIN rental AS R ON C.customer_id = R.customer_id
INNER JOIN inventory AS I ON R.inventory_id = I.inventory_id
INNER JOIN film as F ON I.film_id = F.film_id
INNER JOIN film_category AS FC ON F.film_id = FC.film_id
INNER JOIN category AS CA ON FC.category_id = CA.category_id
WHERE CA.name = 'Action';

-- Select the name and email address of all the customers who have rented the "Action" movies.
-- Write the query using sub queries with multiple WHERE clauses and IN conditions
SELECT DISTINCT C.customer_id, CONCAT(C.first_name, ' ', C.last_name) AS name, C.email
FROM customer AS C
WHERE 'Action' IN (
	SELECT DISTINCT name
    FROM category CA
    INNER JOIN film_category AS FC ON CA.category_id = FC.category_id
    INNER JOIN film as F ON FC.film_id = F.film_id
    INNER JOIN inventory AS I ON F.film_id = I.film_id
    INNER JOIN rental AS R ON R.inventory_id = I.inventory_id
    WHERE R.customer_id = C.customer_id
);

-- Verify if the above two queries produce the same results or not
-- Answer: they produce the same result

-- Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high

SELECT payment_id, customer_id, amount,
  CASE
    WHEN amount BETWEEN 0 AND 2 THEN 'low'
    WHEN amount BETWEEN 2 AND 4 THEN 'medium'
    WHEN amount > 4 THEN 'high'
    ELSE 'unknown'
  END AS transaction_value
FROM payment;