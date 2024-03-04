/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */
SELECT
    af.actor_id,
    a.first_name,
    a.last_name,
    af.film_id,
    af.film_title AS title,
    af.revenue_rank AS rank,
    af.total_revenue AS revenue
FROM (
    SELECT
        a.actor_id,
        f.film_id,
        f.title AS film_title,
        SUM(p.amount) AS total_revenue,
        ROW_NUMBER() OVER (PARTITION BY a.actor_id ORDER BY SUM(p.amount) DESC) AS revenue_rank
    FROM
        actor a
    JOIN
        film_actor fa ON a.actor_id = fa.actor_id
    JOIN
        film f ON fa.film_id = f.film_id
    JOIN
        inventory i ON f.film_id = i.film_id
    JOIN
        rental r ON i.inventory_id = r.inventory_id
    JOIN
        payment p ON r.rental_id = p.rental_id
    GROUP BY
        a.actor_id, f.film_id, f.title
) AS af
JOIN
    actor a ON af.actor_id = a.actor_id
WHERE
    af.revenue_rank <= 3
ORDER BY
    af.actor_id, af.revenue_rank;

