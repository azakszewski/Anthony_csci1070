--1
select customer.last_name, customer.first_name
from customer
where last_name like 'T%'
order by first_name asc;

--2
select rental.rental_id, rental.rental_date, rental.return_date 
from rental
where return_date between '2005-05-28' and '2005-06-01';

--3 
Select film.title, count(film.film_id) as rental_count
from rental
left join inventory on inventory.inventory_id = rental.inventory_id
left join film on film.film_id = inventory.film_id
group by film.title
order by rental_count desc
limit 10;

--4
select customer.first_name,sum((payment.amount)) as total_payment
from customer
left join payment on payment.customer_id = customer.customer_id
group by customer.first_name
order by total_payment asc;

--5
select CONCAT( actor.first_name,'',actor.last_name), count(actor.actor_id) as movie_actor_count
from actor
left join film_actor on film_actor.actor_id = actor.actor_id
left join film on film.film_id = film_actor.actor_id
where film.release_year = '2006'
group by CONCAT( actor.first_name,'',actor.last_name)
order by movie_actor_count desc;
--6
-- explaining 4
explain select customer.first_name, count(payment.amount) as total_payment
from customer
left join payment on payment.customer_id = customer.customer_id
group by customer.first_name
order by total_payment asc;
-- explaining 5
explain select CONCAT( actor.first_name,'',actor.last_name), count(actor.actor_id) as movie_actor_count
from actor
left join film_actor on film_actor.actor_id = actor.actor_id
left join film on film.film_id = film_actor.film_id
where film.release_year = '2006'
group by CONCAT( actor.first_name,'',actor.last_name)
order by movie_actor_count asc
-- 4 - here we are finding the link between customer name and the payment which is the customer id. 
 -- Then from there we can list the customers by first name and take the sum of the payments and put them in accending order.
 -- 5- here we want the list of actors in movies so we can go from actor so we can use the name to film actor to film all with film and actor id
 -- from there we can use the concat function to combine the names and list them in accending order of movies they were in.

--7
select avg(rental_rate),(category.name) as average_rental_per_category
from film
left join film_category on film_category.film_id = film.film_id
left join category on category.category_id = film_category.category_id
group by category.name;

--8
select sum(payment.amount), (category.name) as total_price
from category
left join film_category on film_category.last_update = category.last_update
left join film on film.last_update = film_category.last_update
group by category.name
limit 5;


select sum(payment.amount), (category.name) as total_price
from payment
left join rental on rental.rental_id = payment.rental_id
left join inventory on inventory.inventory_id = rental.inventory_id
left join film on film.film_id = inventory.film_id
left join film_category on film_category.film_id = film.film_id
left join category on category.category_id = film_category.category_id
group by category.name
limit 5;

--ec
SELECT category.name, TO_CHAR(rental.rental_date, 'Month') AS month, COUNT(rental.rental_id) AS total_rentals
FROM rental
left join inventory on inventory.inventory_id = rental.inventory_id
left join film on film.film_id = inventory.film_id
left join film_category on film_category.film_id = film.film_id
left join category on category.category_id = film_category.category_id
GROUP BY category.name, TO_CHAR(rental.rental_date, 'Month')
ORDER BY  category.name, TO_CHAR(rental.rental_date, 'Month');

-- to_char function is used to convert dates into strings 