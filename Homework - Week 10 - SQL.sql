USE sakila;

#1a. Display the first and last names of all actors from the table actor.
Select first_name, last_name
From actor;

#1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
Select upper(CONCAT(first_name, " ", last_name)) as "Actor Name"
From actor;

#2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = "JOE";

#2b. Find all actors whose last name contain the letters GEN:
SELECT first_name, last_name FROM actor
WHERE last_name LIKE "%GEN%";

#2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
SELECT first_name, last_name FROM actor
WHERE last_name LIKE "%LI%"
ORDER BY last_name, first_name;

#2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id, country FROM country
Where country IN ('Afghanistan', 'Bangladesh', 'China')

#3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, so create a column in the table actor named description and use the data type BLOB (Make sure to research the type BLOB, as the difference between it and VARCHAR are significant).
ALTER TABLE actor
ADD COLUMN description blob;

#3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the description column.
ALTER TABLE actor
DROP COLUMN description;

#4a. List the last names of actors, as well as how many actors have that last name.
SELECT last_name, Count(*) FROM actor
group by last_name;

#4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors


#4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
Update actor
Set first_name='HARPO'
where first_name='GROUCHO' AND last_name='WILLIAMS';

#4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.
Update actor
Set first_name='GROUCHO'
where first_name='HARPO' AND last_name='WILLIAMS';

#5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
#Hint: https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html
SHOW CREATE TABLE address;

#6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address ON
staff.address_id=address.address_id;

#6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
#Couldn't get code to work for 6b, commented out bad code...so maybe I can get partial credit?
#Select s.first_name, s.last_name, sum(p.amount)
#FROM staff AS s
#Right JOIN payment as p ON
#s.staff_id=p.staff_id
#where p.payment_date BETWEEN '8/01/2005' AND '8/30/2005';


#6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
SELECT film.title, count(actor_id)
FROM film
INNER JOIN film_actor on film_actor.film_id = film.film_id
Group By title;

#6d. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT title, (SELECT COUNT(*) FROM inventory WHERE film.film_id = inventory.film_id ) AS 'Number of Copies'
FROM film
WHERE title='Hunchback Impossible';

#6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
#![Total amount paid](Images/total_payment.png)

Select customer.first_name, customer.last_name, SUM(amount)
from customer 
join payment on customer.customer_id=payment.customer_id
group by customer.customer_id
Order by customer.last_name;

#7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, 
#films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of 
#movies starting with the letters K and Q whose language is English.
#
#I was unable to get the script down to a single query, but I could get it in 2.
SELECT title
FROM film
WHERE language_id IN
(
  SELECT language_id
  FROM language
  WHERE name="English"
) AND film.title like "K%";

SELECT title
FROM film
WHERE language_id IN
(
  SELECT language_id
  FROM language
  WHERE name="English"
) AND film.title like "Q%";

#7b. Use subqueries to display all actors who appear in the film Alone Trip.

SELECT actor.first_name, actor.last_name
FROM actor
WHERE actor_id IN
(
  SELECT actor_id
  FROM film_actor
  WHERE film_id IN
  (
	Select film_id 
    From film
    where title = 'Alone Trip')
    )
;
    
#7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.


#7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.


#7e. Display the most frequently rented movies in descending order.


#7f. Write a query to display how much business, in dollars, each store brought in.


#7g. Write a query to display for each store its store ID, city, and country.


#7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)


#8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.


#8b. How would you display the view that you created in 8a?


#8c. You find that you no longer need the view top_five_genres. Write a query to delete it.