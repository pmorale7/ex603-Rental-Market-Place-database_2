-- Task 5.2 - Part A
-- LEFT JOIN: Return all properties, including properties
-- that have never had a viewing.

SELECT
    p.property_id,
    p.property_label,
    v.viewing_id,
    v.attended_at,
    v.viewing_status
FROM properties AS p
LEFT JOIN viewings AS v
    ON p.property_id = v.property_id
ORDER BY p.property_id, v.attended_at;

-- Task 5.2 A . 2
-- Same as above just a small change
-- INNER JOIN: Return properties that have matching viewing events.

SELECT
    p.property_id,
    p.property_label,
    v.viewing_id,
    v.attended_at,
    v.viewing_status
FROM properties AS p
INNER JOIN viewings AS v
    ON p.property_id = v.property_id
ORDER BY p.property_id, v.attended_at;

-- Task 5.2 A .3
-- Comparison query for both inner and left join
-- Task 5.2 - Part A
-- Compare the number of unique properties returned by
-- the LEFT JOIN and INNER JOIN.

SELECT
    COUNT(DISTINCT p.property_id) AS total_properties,
    COUNT(DISTINCT CASE
        WHEN v.viewing_id IS NOT NULL
        THEN p.property_id
    END) AS properties_in_inner_join,
    COUNT(DISTINCT CASE
        WHEN v.viewing_id IS NULL
        THEN p.property_id
    END) AS properties_excluded_by_inner_join
FROM properties AS p
LEFT JOIN viewings AS v
    ON p.property_id = v.property_id;


-- Task 5.2 A .4
-- Missing producers 
-- They have no viewing history within
-- the table so inner join excludes them
-- left join keeps with a NULL value
SELECT
    p.property_id,
    p.property_label
FROM properties AS p
LEFT JOIN viewings AS v
    ON p.property_id = v.property_id
WHERE v.viewing_id IS NULL
ORDER BY p.property_id;


-- Task 5.2 - Part B - 1
-- RIGHT JOIN: Return all properties, including properties
-- that have never had a viewing.
-- This should produce the same result as the LEFT JOIN in Part A just reversed.

SELECT
    p.property_id,
    p.property_label,
    v.viewing_id,
    v.attended_at,
    v.viewing_status
FROM viewings AS v
RIGHT JOIN properties AS p
    ON v.property_id = p.property_id
ORDER BY
    p.property_id,
    v.attended_at;

-- ###############################################
-- Task 5.2 - Part B -2 
-- Comparison results from left join to right join
-- previous Task 5. 1 above
-- Results look consistent with left join.  
-- preserving the properties tables even though
-- we reversed the side of the join.
-- SQL query is in Task 5.2 A
-- this is the first Left join above
-- ##############################################

-- Task 5.2 - Part B - 3
-- FULL OUTER JOIN: Show matching and unmatched records
-- from both properties and viewings.
-- this sql list all both side left and right on 
-- a full join

SELECT
    p.property_id,
    p.property_label,
    v.viewing_id,
    v.property_id AS viewing_property_id,
    v.attended_at,
    v.viewing_status
FROM properties AS p
FULL OUTER JOIN viewings AS v
    ON p.property_id = v.property_id
ORDER BY
    p.property_id,
    v.property_id,
    v.attended_at;

-- Task 5.2 - Part B - 3 & 4
-- Which records are unmatched on either side of the FULL OUTER JOIN?
-- this shows two records unmatched and both show NULL
-- Property 14 and 15
-- this sql verifies the unmatched records that 
-- both Left join or right join alone cannot

SELECT
    p.property_id,
    p.property_label,
    v.viewing_id,
    v.property_id AS viewing_property_id
FROM properties AS p
FULL OUTER JOIN viewings AS v
    ON p.property_id = v.property_id
WHERE p.property_id IS NULL
   OR v.viewing_id IS NULL
ORDER BY p.property_id, v.property_id;


-- Task 5.2 - Part B - 4
-- A full outer join can reveal unmatched recoredsd from both
-- tables at the same time. In our results, we show properties 14 and 15
-- as properties with no matching viewing events.  It also allowed
-- us to check for viewing events that had no matching property, but none were 
-- found.




























