/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */
SELECT title
FROM (
    SELECT f2.title, count(f2.title)
    FROM film f1
    JOIN film_category fc1 ON (f1.film_id = fc1.film_id)
    JOIN film_category fc2 ON (fc1.category_id = fc2.category_id)
    JOIN film f2 ON (f2.film_id = fc2.film_id)
    WHERE f1.title = 'AMERICAN CIRCUS'
    GROUP BY f2.title
) t
WHERE count>=2
INTERSECT
SELECT f2.title
FROM film f1
JOIN film_actor fa1 ON (f1.film_id = fa1.film_id)
JOIN film_actor fa2 ON (fa1.actor_id = fa2.actor_id)
JOIN film f2 ON (f2.film_id = fa2.film_id)
WHERE f1.title = 'AMERICAN CIRCUS'
ORDER BY title;
