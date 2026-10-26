-- Task 4.2 - Build the breakdown leadership asked for
-- Status Check (attended, cancelled, or disputed)
-- We picked cancelled as it more concrete to use as a metric
-- What viewing statuses exist in the database?

SELECT
    viewing_status,
    COUNT(*) AS total_viewings
FROM viewings
GROUP BY viewing_status
ORDER BY total_viewings DESC;

-- Task 4.2 - Part A
-- How many total viewing events and failed events
-- does each property have?
-- our producers are named by their property id and name
-- A failure is defined as a cancelled viewing.
-- Disputed events are not classified as failures
-- because their outcomes are uncertain.


SELECT
    properties.property_id,
    properties.property_label,
    COUNT(*) AS total_events,
    SUM(
        CASE
            WHEN viewings.viewing_status = 'cancelled'
                THEN 1
            ELSE 0
        END
    ) AS failed_events
FROM viewings
JOIN properties
    ON viewings.property_id = properties.property_id
GROUP BY
    properties.property_id,
    properties.property_label
ORDER BY failed_events DESC;


-- Task 4.2 - Part B
-- this give regional director subtotals per region and grand total
-- each broken down to totals 200 and failed events 34.  
-- How are viewing events and cancellations (failed events)
-- distributed across cities and the platform?

SELECT
    CASE
        WHEN GROUPING(properties.city) = 1
            THEN 'PLATFORM TOTAL'
        ELSE properties.city
    END AS region,

    COUNT(*) AS total_events,

    SUM(
        CASE
            WHEN viewings.viewing_status = 'cancelled'
                THEN 1
            ELSE 0
        END
    ) AS failed_events,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN viewings.viewing_status = 'cancelled'
                    THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS failure_rate_percent

FROM viewings
JOIN properties
    ON viewings.property_id = properties.property_id

GROUP BY ROLLUP(properties.city)

ORDER BY
    GROUPING(properties.city),
    properties.city;


-- Task 4.2 - Part C
-- What is the individual performance of each producer - listed
-- by property id, shows total events, what failed(cancelled)
-- percentages listed.

WITH property_performance AS (
    SELECT
        property_id,
        COUNT(*) AS total_events,
        SUM(
            CASE
                WHEN viewing_status = 'cancelled'
                    THEN 1
                ELSE 0
            END
        ) AS failed_events
    FROM viewings
    GROUP BY property_id
)

SELECT
    property_id,
    total_events,
    failed_events,
    ROUND(
        100.0 * failed_events / total_events,
        2
    ) AS failure_rate
FROM property_performance
WHERE total_events >= 10
ORDER BY failure_rate DESC;


