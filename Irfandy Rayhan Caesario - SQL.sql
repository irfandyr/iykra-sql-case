-- Number of films about astronauts
select count(*)
from film f
where description like '%Astronaut%'

-- Number of films that have "R" rating and replacement cost between $5 and $15
select count(*)
from film f 
where rating = 'R'
and replacement_cost between 5 and 15

-- Find out which staff handled the most payments, and total transactions they handle
select
	p.staff_id,
	s.first_name,
	s.last_name,
	count(p.payment_id) as num_of_transactions,
	sum(p.amount)
from payment p
join staff s 
on p.staff_id = s.staff_id 
group by 1, 2, 3
order by 4 desc, 5 desc

-- Find out average replacement cost by rating
select
	rating,
	round(avg(replacement_cost),2) as avg_replacement_cost 
from film f
group by rating

-- Who has spent the most amount of money?
select
	c.first_name,
	c.last_name,
	c.email,
	sum(p.amount) as total_transaction
from customer c
join payment p 
on c.customer_id = p.customer_id
group by c.customer_id
order by 4 desc
limit 5

-- Find out how many copies of each movies in each store
select
	f.title,
	i.store_id,
	count(i.film_id) as num_of_inventory
from inventory i
join film f 
on i.film_id = f.film_id 
group by 1, 2
order by 2, 1

-- Which customers have made transaction payment more than 40?
select
	c.first_name,
	c.last_name,
	c.email,
	count(p.payment_id) as num_of_transactions
from customer c
join payment p
on c.customer_id = p.customer_id
group by c.customer_id
having count(p.payment_id) > 40