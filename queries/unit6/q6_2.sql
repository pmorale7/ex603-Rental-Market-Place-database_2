
-- Task 6.2 - Part A
-- How does viewing duration change from one event to the next
-- for Property 1?
-- this looks at the before, after and what is the difference.  delta

SELECT
    viewing_id,
    property_id,
    scheduled_at,
    duration_min,

    LAG(duration_min) OVER (
        PARTITION BY property_id
        ORDER BY scheduled_at
    ) AS previous_duration,

    LEAD(duration_min) OVER (
        PARTITION BY property_id
        ORDER BY scheduled_at
    ) AS next_duration,

    duration_min - LAG(duration_min) OVER (
        PARTITION BY property_id
        ORDER BY scheduled_at
    ) AS duration_delta

FROM viewings

WHERE property_id = 1

ORDER BY scheduled_at;



-- Task 6.2 - Part B
-- How is viewing activity changing over time?
-- Show daily viewings, the cumulative total,
-- and a recent 7-row moving average.
-- looks at the running total to see what 
-- the next date did on viewings, by date viewed...

WITH daily_viewings AS (
    SELECT
        scheduled_at::date AS viewing_date,
        COUNT(*) AS daily_viewings
    FROM viewings
    GROUP BY scheduled_at::date
)

SELECT
    viewing_date,
    daily_viewings,

    SUM(daily_viewings) OVER (
        ORDER BY viewing_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total,

    AVG(daily_viewings) OVER (
        ORDER BY viewing_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS seven_row_moving_average

FROM daily_viewings

ORDER BY viewing_date;
