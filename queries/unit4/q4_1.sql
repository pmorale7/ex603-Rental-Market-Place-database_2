-- Task 4.1 Measure the platform
-- What is the statistics for the entire event table (viewings table - Rental Marketplace)
-- We calculate count, total(sum), average, min, max of accross the whole table
-- using DISTINCT we can get all unique renters there are in total
-- on the duration_min metric

SELECT
    COUNT(duration_min) AS total_count,
    SUM(duration_min) AS total_duration,
    AVG(duration_min) AS average_duration,
    MIN(duration_min) AS minimum_duration,
    MAX(duration_min) AS maximum_duration,
    COUNT(DISTINCT renter_id) AS unique_renters
FROM viewings;


-- Task 4.1 - Data Quality Check for first Query
-- Which viewings have a duration of zero,
-- and what is their viewing status?
-- What we found is viewing_status all Actors(renters)
-- cancelled in the following reasons: Propery withdrawn
-- renter no show, agent unavailable, or renter cancelled
-- which validates the 0.00 on minimum duration of viewing

SELECT
    viewing_id,
    renter_id,
    property_id,
    duration_min,
    viewing_status,
    no_show_reason
FROM viewings
WHERE duration_min = 0;


-- Task 4.1 - Question 2
-- How many events(viewings) does each property receive,
-- and what is its average viewing duration?
-- property_id is the producer, events (viewings)
-- sort desc from producer most events, to least

SELECT
    property_id,
    COUNT(*) AS total_viewings,
    AVG(duration_min) AS average_duration
FROM viewings
GROUP BY property_id
ORDER BY total_viewings DESC;


-- Task 4.1 - Question 3
-- we picked 10 as our minimum event count threshold
-- We looked at which properties have at least 10 viewings,
-- We used the same sql query above and added one line for having()
-- and we looked for what is the average viewing duration?
-- we selected 10 but shows more as total_viewings is counted once.

SELECT
    property_id,
    COUNT(*) AS total_viewings,
    AVG(duration_min) AS average_duration
FROM viewings
GROUP BY property_id
HAVING COUNT(*) >= 10
ORDER BY total_viewings DESC;

-- Task 4.1 - Question 4
-- we worked within two dimensions (two geographic areas)
-- We validate performance of each region as well.
-- we describe some different regions where no viewership is 
-- happening, due to min duration at 0.00
-- How do viewing counts and average viewing
-- durations vary by city and property we show

SELECT
    properties.city,
    properties.property_id,
    COUNT(*) AS total_viewings,
    AVG(viewings.duration_min) AS average_duration,
    MIN(viewings.duration_min) AS minimum_duration,
    MAX(viewings.duration_min) AS maximum_duration
FROM viewings
JOIN properties
    ON viewings.property_id = properties.property_id
GROUP BY
    properties.city,
    properties.property_id
ORDER BY
    properties.city,
    total_viewings DESC;

