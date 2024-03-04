/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
*/
SELECT country.country, SUM(payment.amount) AS total_payments
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
GROUP BY country.country
ORDER BY total_payments DESC, country;

