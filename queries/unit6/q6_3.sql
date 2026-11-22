
-- Task 6.3 - Part A
-- What are the top three longest viewing events for each property?
-- RANK() is used so tied viewing durations receive the same rank.
-- If multiple events tie at third place, all tied events are included.

WITH ranked_viewings AS (
    SELECT
        property_id,
        viewing_id,
        scheduled_at,
        duration_min,

        RANK() OVER (
            PARTITION BY property_id
            ORDER BY duration_min DESC
        ) AS duration_rank,

        FIRST_VALUE(duration_min) OVER (
            PARTITION BY property_id
            ORDER BY duration_min DESC
        ) AS longest_viewing_duration

    FROM viewings
)

SELECT
    property_id,
    viewing_id,
    scheduled_at,
    duration_min,
    duration_rank,
    longest_viewing_duration

FROM ranked_viewings

WHERE duration_rank <= 3

ORDER BY
    property_id,
    duration_rank,
    viewing_id;


-- Task 6.3 - Part B
-- Is the platform's viewing failure rate getting better or worse
-- from one month to the next?
-- A failure is defined as a cancelled viewing.

WITH monthly_performance AS (
    SELECT
        DATE_TRUNC('month', scheduled_at)::date AS month,

        COUNT(*) AS total_events,

        SUM(
            CASE
                WHEN viewing_status = 'cancelled' THEN 1
                ELSE 0
            END
        ) AS failed_events

    FROM viewings

    GROUP BY DATE_TRUNC('month', scheduled_at)
),

monthly_rates AS (
    SELECT
        month,
        total_events,
        failed_events,

        ROUND(
            100.0 * failed_events / NULLIF(total_events, 0),
            2
        ) AS failure_rate

    FROM monthly_performance
),

monthly_comparison AS (
    SELECT
        month,
        total_events,
        failed_events,
        failure_rate,

        LAG(failure_rate) OVER (
            ORDER BY month
        ) AS previous_month_failure_rate,

        LAG(month) OVER (
            ORDER BY month
        ) AS previous_month

    FROM monthly_rates
)

SELECT
    month,
    total_events,
    failed_events,
    failure_rate,
    previous_month_failure_rate,

    ROUND(
        100.0 *
        (failure_rate - previous_month_failure_rate)
        / NULLIF(previous_month_failure_rate, 0),
        2
    ) AS percent_change,

    CASE
        WHEN previous_month IS NULL THEN 'First month'
        WHEN month = previous_month + INTERVAL '1 month'
            THEN 'Consecutive'
        ELSE 'Missing month'
    END AS month_check

FROM monthly_comparison

ORDER BY month;













