USE sakila;

# JOINS 

SELECT city,country
FROM city
INNER JOIN country
ON city.country_id = country.country_id;

SELECT *
FROM city
INNER JOIN country
ON city.country_id = country.country_id;

# retrieve the film_id and the name of the category it belongs to
SELECT film_id,name
FROM film_category
INNER JOIN category
ON film_category.category_id = category.category_id;

# otra forma de hacerlo, con join
SELECT film_id,name
FROM film_category
INNER JOIN category
USING (category_id);

# all of the columns of the join:
SELECT *
FROM film_category
INNER JOIN category
USING (category_id);

#retrieve number of movies per category, with the name of the cateegoriu
SELECT category_id,  name, COUNT(film_id)
FROM category
INNER JOIN film_category
USING (category_id)
GROUP BY name, category_id;

#retrieve the number of addresses per city 

SELECT city, COUNT(address_id) #ALSO COUNT(*)
FROM address
INNER JOIN city
USING (city_id)
GROUP BY city
ORDER BY COUNT(address_id) DESC;

#retrieve the number of addresses per country

SELECT country, COUNT(*)

# A COMPLETE FROM BLOCK FROM
FROM address
INNER JOIN city 
USING (city_id)
INNER JOIN country
USING (country_id)
# A COMPLETE FROM BLOCK FROM

GROUP BY country
ORDER BY COUNT(*)DESC;

# SUBQUERIES: 

#1ST QUERY:
SELECT first_name,last_name
FROM actor
WHERE actor_id IN ("1", "2", "3");

#2ND QUERY:
SELECT actor_id
FROM film_actor
WHERE film_id = 2;


#1 Y 2 COMBINED
SELECT first_name,last_name  #PARENT QUERY
FROM actor
WHERE actor_id IN (SELECT actor_id
					FROM film_actor
					WHERE film_id = 2);  #BABY QUERY... TO FILTER THE PARENT QUERY


#3rd query
SELECT film_id
FROM film
WHERE title = "Academy Dinosaur"; 


SELECT first_name,last_name  #PARENT QUERY
FROM actor
WHERE actor_id IN (SELECT actor_id   #actor_id MUST match actor_id
					FROM film_actor
					WHERE film_id = (SELECT film_id  #film_id MUST match film_id
										FROM film
										WHERE title = "Academy Dinosaur"));  


# retrieve category name in sports films:
SELECT first_name,last_name  #PARENT QUERY
FROM actor
WHERE actor_id IN (SELECT actor_id   #actor_id MUST match actor_id
					FROM film_actor
					WHERE film_id IN (SELECT film_id  #film_id MUST match film_id
										FROM film_category
										WHERE category_id IN (SELECT category_id
																FROM category
																WHERE name = "Sports")));  
                                                                
# retrieve all the inventry ids of the movies in english (using subqueries)


SELECT inventory_id
FROM inventory
WHERE  film_id IN (SELECT film_id # it is importat the indentantion with the subqueries!!!
				FROM film
				WHERE language_id IN (SELECT language_id
									FROM language
									WHERE name = "English"));


# the same, but with JOIN:

SELECT inventory_id
FROM inventory
INNER JOIN film
USING (film_id)
INNER JOIN language
USING (language_id)
WHERE name = "English";
                                        
                                        
                                        
                                        