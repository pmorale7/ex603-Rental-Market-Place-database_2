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













