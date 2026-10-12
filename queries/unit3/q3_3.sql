-- Table 3.3 - 1
-- Look into the viewings table for data and Renters table for data
-- what will we use from each to determine
-- first question is below using NOT IN

SELECT DISTINCT viewing_status
FROM viewings;

-- select all data from viewings table

SELECT *
FROM viewings


-- first question using NOT IN - part 1

SELECT renter_id, renter_name
FROM renters
WHERE renter_id NOT IN (
    SELECT renter_id
    FROM viewings
    WHERE viewing_status = 'disputed'
      AND renter_id IS NOT NULL
)
ORDER BY renter_id;

-- Next, witha CTE which are the little harder part 2 
-- below is the coding with ai assistance
-- using the WITH 

WITH disputed_renters AS (
    SELECT renter_id
    FROM viewings
    WHERE viewing_status = 'disputed'
      AND renter_id IS NOT NULL
)
SELECT renter_id, renter_name
FROM renters
WHERE renter_id NOT IN (
    SELECT renter_id
    FROM disputed_renters
)
ORDER BY renter_id;

-- using Not exist on part 3 
-- distint from the others. 
-- all return the same answers

SELECT
    renters.renter_id,
    renters.renter_name
FROM renters
WHERE NOT EXISTS (
    SELECT 1
    FROM viewings
    WHERE viewings.renter_id = renters.renter_id
      AND viewings.viewing_status = 'disputed'
)
ORDER BY renters.renter_id;

-- this is a tough one to do
-- ai assistance with this one used
-- it ran it as an if/else statemet
-- it did not run well at all


WITH
not_in_results AS (
    SELECT renter_id, renter_name
    FROM renters
    WHERE renter_id NOT IN (
        SELECT renter_id
        FROM viewings
        WHERE viewing_status = 'disputed'
          AND renter_id IS NOT NULL
    )
),

cte_results AS (
    WITH disputed_renters AS (
        SELECT renter_id
        FROM viewings
        WHERE viewing_status = 'disputed'
          AND renter_id IS NOT NULL
    )
    SELECT renter_id, renter_name
    FROM renters
    WHERE renter_id NOT IN (
        SELECT renter_id
        FROM disputed_renters
    )
),

not_exists_results AS (
    SELECT renters.renter_id, renters.renter_name
    FROM renters
    WHERE NOT EXISTS (
        SELECT 1
        FROM viewings
        WHERE viewings.renter_id = renters.renter_id
          AND viewings.viewing_status = 'disputed'
    )
)

SELECT 'NOT IN vs CTE' AS comparison
FROM (
    (SELECT * FROM not_in_results
     EXCEPT
     SELECT * FROM cte_results)

    UNION ALL

    (SELECT * FROM cte_results
     EXCEPT
     SELECT * FROM not_in_results)
) AS differences

UNION ALL

SELECT 'NOT IN vs NOT EXISTS' AS comparison
FROM (
    (SELECT * FROM not_in_results
     EXCEPT
     SELECT * FROM not_exists_results)

    UNION ALL

    (SELECT * FROM not_exists_results
     EXCEPT
     SELECT * FROM not_in_results)
) AS differences;


-- question 5
-- I would say the NULL value which 
-- leads back to the logue paper on 
-- returning bad results.
-- NOT EXISTS returns what we needed / TRUE value
-- NOT IN prevents the issue by using IS NOT NULL
-- Any value with the 'null' could cause problems.



