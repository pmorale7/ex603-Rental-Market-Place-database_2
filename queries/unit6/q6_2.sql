
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
