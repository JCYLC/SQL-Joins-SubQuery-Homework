-- 1. List all customers who live in Texas (use JOINS)
SELECT *
FROM customer 
FULL JOIN address 
ON customer.address_id = address.address_id 
WHERE district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT customer.first_name, customer.last_name 
FROM customer 
FULL JOIN payment 
ON customer.customer_id = payment.customer_id 
WHERE amount > 6.99

-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT store_id, first_name, last_name
FROM customer 
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment 
	GROUP BY customer_id 
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC 
)
GROUP BY store_id,FIRST_NAME,LAST_NAME; 


-- 4. List all customers that live in Nepal (use the city table)
SELECT store_id, first_name, last_name, address, country
FROM customer 
FULL JOIN address 
ON customer.address_id = address.address_id 
FULL JOIN city 
ON address.city_id = city.city_id 
FULL JOIN country 
ON city.country_id = country.country_id 
WHERE country = 'Nepal'; 

-- 5. Which staff member had the most transactions? --JON sTEPHENS
SELECT staff.first_name, staff.last_name, COUNT(payment.payment_id)
FROM staff 
FULL JOIN payment 
ON staff.staff_id = payment.staff_id 
GROUP BY staff.staff_id; 


-- 6. How many movies of each rating are there?
-- 195 R, 209 NC-17, 178 G, 223 PG-13, 194 PG
SELECT COUNT(film_id), rating
FROM film 
GROUP BY rating; 

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT customer.customer_id, last_name, first_name
FROM customer 
FULL JOIN payment 
ON customer.customer_id = payment.customer_id
WHERE payment.amount IN(
	SELECT payment.amount 
	FROM payment
	WHERE amount > 6.99
)
GROUP BY customer.customer_id 
HAVING COUNT(amount) =1;

-- 8. How many free rentals did our stores give away? --0
SELECT COUNT(payment.rental_id)
FROM payment
FULL JOIN rental on payment.rental_id = rental.rental_id
WHERE amount = 0;