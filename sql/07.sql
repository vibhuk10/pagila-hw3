/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
*/
SELECT first_name || ' ' || last_name AS "Actor Name"
FROM actor
JOIN (
    SELECT DISTINCT actor_id
    FROM film_actor
    WHERE film_id IN (
        SELECT film_id
        FROM film_actor
        WHERE actor_id IN (
            SELECT DISTINCT actor_id
            FROM film_actor
            WHERE film_id IN (
                SELECT film_id
                FROM film_actor
                WHERE actor_id IN (
                    SELECT actor_id
                    FROM actor
                    WHERE first_name='RUSSELL' AND last_name='BACALL'
                )
            )
            AND actor_id NOT IN (
                SELECT actor_id
                FROM actor
                WHERE first_name='RUSSELL' AND last_name='BACALL'
            )
        )
    )
    AND actor_id NOT IN (
        SELECT DISTINCT actor_id
        FROM film_actor
        WHERE film_id IN (
            SELECT film_id
            FROM film_actor
            WHERE actor_id IN (
                SELECT actor_id
                FROM actor
                WHERE first_name='RUSSELL' AND last_name='BACALL'
            )
        )
    )
) t USING (actor_id)
ORDER BY "Actor Name";
