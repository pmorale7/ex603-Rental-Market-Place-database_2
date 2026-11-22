-- Task 6.1 - Question 1
-- How does each viewing's duration compare with the
-- average viewing duration for its property?
-- all 200 examples are printed out show each row up to 13

SELECT
    viewing_id,
    property_id,
    duration_min,

    AVG(duration_min) OVER (
        PARTITION BY property_id
    ) AS property_average_duration

FROM viewings

ORDER BY
    property_id,
    viewing_id;


-- Task 6.1 - Question 1
-- GROUP BY comparison:
-- What is the average viewing duration for each property?
-- shows the average up to 1-13 and its averages only. 
-- not all 200 rows.

SELECT
    property_id,
    AVG(duration_min) AS property_average_duration
FROM viewings
GROUP BY property_id
ORDER BY property_id;


-- Task 6.1 - Question 2
-- How do properties rank by number of viewing events,
-- and how do different ranking functions handle ties?
-- provides the three columns for viewing purpose on 
-- rank, row count, and dense rank

WITH property_event_counts AS (
    SELECT
        property_id,
        COUNT(*) AS total_events
    FROM viewings
    GROUP BY property_id
)

SELECT
    property_id,
    total_events,

    ROW_NUMBER() OVER (
        ORDER BY total_events DESC
    ) AS row_number_rank,

    RANK() OVER (
        ORDER BY total_events DESC
    ) AS rank_position,

    DENSE_RANK() OVER (
        ORDER BY total_events DESC
    ) AS dense_rank_position

FROM property_event_counts

ORDER BY
    total_events DESC,
    property_id;



-- Task 6.1 - Question 3
-- How are properties divided into four activity bands
-- based on their total number of viewing events?
-- breaks each property into 4 activity band on last column

WITH property_event_counts AS (
    SELECT
        property_id,
        COUNT(*) AS total_events
    FROM viewings
    GROUP BY property_id
)

SELECT
    property_id,
    total_events,

    NTILE(4) OVER (
        ORDER BY total_events DESC
    ) AS activity_band

FROM property_event_counts

ORDER BY
    total_events DESC,
    property_id;


























