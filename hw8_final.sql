--1
alter table rental
add column status varchar(20);
update rental
set status = case
    when extract(day from (rental.return_date - rental.rental_date)) > film.rental_duration then 'late'
    when extract(day from (rental.return_date - rental.rental_date)) < film.rental_duration then 'early'
    else 'on time'
end
from inventory
join film on inventory.film_id = film.film_id
where rental.inventory_id = inventory.inventory_id;

-- https://www.sqltutorial.org/sql-date-functions/how-to-extract-day-from-date-in-sql/ used this to get the date from the subtraction 
-- https://www.simplilearn.com/tutorials/sql-tutorial/add-column-in-sql how to add the column

--2
select sum(payment.amount), city.city, concat(customer.first_name, ' ', customer.last_name) as name
from payment
left join customer on customer.customer_id = payment.customer_id
left join address on address.address_id = customer.address_id
left join city on city.city_id = address.city_id
where city.city = 'Saint Louis' or city.city = 'Kansas City'
group by concat(customer.first_name, ' ', customer.last_name), city.city;





--3 
select count(category.category_id) as category_count, category.name
from film_category
left join category on category.category_id = film_category.category_id
group by category.name 
order by count(category.category_id) desc;

--4 
-- one big reason why there is film_category and category is there is no connection between film and category, so the film_category acts as a bridge between the two when you need to join into it


--5 
select film.film_id as film_id, film.length as length_of_movie, film.title
from film
left join inventory on inventory.film_id = film.film_id
left join rental on rental.inventory_id = inventory.inventory_id
where rental.return_date between '2005-05-15' and '2005-05-31';

--6 
select film.title 
from film 
where film.rental_rate < (select avg(film.rental_rate) from film);

--7 *
select status, count(status)
from rental
group by status

--8 
select film.title, film.length,
percent_rank() over (order by film.length)
				as percent_rank
from film


--9
explain select film.film_id as film_id, film.length as length_of_movie, film.title
from film
left join inventory on inventory.film_id = film.film_id
left join rental on rental.inventory_id = inventory.inventory_id
where rental.return_date between '2005-05-15' and '2005-05-31';
-- expaling 5 - this is organizing all the films by the return date between may 15th and 31st. We need to join into rental in order to
-- get the return date so we see that we are joining inventory then joining rental with the hashes. From there we filter the data and get our answer.

explain select count(category.category_id) as category_count, category.name
from film_category
left join category on category.category_id = film_category.category_id
group by category.name 
order by count(category.category_id) desc;
-- explaining 3 - here we need to get to category so that we can have the name listed in the table. We are counting the category ids
-- so that we can get a number on how many films are in each. From there we joing with the hash and then group by category name.
-- the conditions are what we are joining on. then we order by the count of categories and put it in desc so that it simply looks better.

--ec
