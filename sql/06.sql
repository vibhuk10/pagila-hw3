/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */
-- List all actors with Bacall Number 1
SELECT DISTINCT a.first_name || ' ' || a.last_name as "Actor Name"
FROM actor a
JOIN film_actor fa ON (a.actor_id = fa.actor_id)
JOIN film f ON (fa.film_id = f.film_id)
JOIN film_actor fa_russell ON (f.film_id = fa_russell.film_id)
JOIN actor russell ON (fa_russell.actor_id = russell.actor_id)
WHERE russell.first_name = 'RUSSELL' AND russell.last_name = 'BACALL' AND a.actor_id <> russell.actor_id
order by "Actor Name";
