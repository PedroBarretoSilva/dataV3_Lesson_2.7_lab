USE sakila;


-- checking the content of the relevante tables: 

SELECT * FROM film_category;
SELECT * FROM category;
SELECT * FROM payment;

-- 1) How many films are there for each of the categories in the category table. Use appropriate join to write this query.

-- We cannot get all the information we need from the table category, because it doesn´t include information about each movie
-- so, we need to JOIN this table with the table film_category, in order to get from this second the toal films per category


SELECT c.name AS genre, count(DISTINCT fc.film_id) AS nr_of_films
FROM sakila.category c
JOIN sakila.film_category fc
USING (category_id)
GROUP BY c.category_id;



-- 2) Display the total amount rung up by each staff member in August of 2005.


SELECT p.staff_id, sum(p.amount) AS 'Sales'
FROM sakila.payment p
-- WHERE date_format(p.payment_date, '%d-%m-%y') BETWEEN '01-08-05' AND '31-08-05'
WHERE DATE(p.payment_date) BETWEEN '2005-08-01' AND '2005-08-31'
GROUP BY p.staff_id; 


-- 3) Which actor has appeared in the most films?
SELECT fa.actor_id, count(DISTINCT fa.film_id) AS nr_films
FROM sakila.film_actor fa
GROUP BY fa.actor_id
ORDER BY nr_films DESC
LIMIT 1;

-- identifying the actor's name:

SELECT  a.first_name, a.last_name 
FROM sakila.actor a
WHERE actor_id = 107;



-- 4) Most active customer (the customer that has rented the most number of films)
SELECT r.customer_id, count(DISTINCT r.rental_id) AS nr_films
FROM sakila.rental r
GROUP BY r.customer_id
ORDER BY nr_films DESC
LIMIT 1;


-- identifying the customer's name:

SELECT  c.first_name, c.last_name 
FROM sakila.customer c
WHERE customer_id = 148;



-- 5)  Display the first and last names, as well as the address, of each staff member.

-- the adress is stored in a diffent table, so we have to join two tables in order to answer this question

SELECT s.first_name, s.last_name, a.address AS address_part1, a.address AS address_part2, a.district
FROM sakila.staff s
JOIN sakila.address a
USING (address_id);


-- 6) List each film and the number of actors who are listed for that film.
SELECT f.title, count(fa.actor_id) AS nr_actors
FROM sakila.film_actor fa 
-- JOIN sakila.actor a
-- USING (address_id);
JOIN sakila.film f
USING (film_id)
GROUP BY f.title;




-- 7) Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name

SELECT c.first_name, c.last_name, sum(p.amount) AS 'amount_paid'
FROM sakila.payment p
JOIN sakila.customer c
USING (customer_id)
GROUP BY c.last_name
ORDER BY c.last_name ASC;


-- 8) List number of films per category.

-- same as 1) done above


