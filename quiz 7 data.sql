select*
from payment
where amount >= 9.99;

select max(rental_rate)
from film;

select title
from Film
where rental_rate = (select max(rental_rate) from film);

select staff.first_name, staff.last_name, staff.email, address.address, city.city, country.country
from staff
left join address on staff.address_id = address.address_id
left join city on address.city_id = city.city_id
left join country on city.country_id = country.country_id;

-- I would say that im interested in working for a company doing financial analyzation for them whether that be a big or small company. But I would enjoy looking at data for it.





