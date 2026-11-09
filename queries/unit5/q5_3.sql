
-- Task 5.3 - Part A
-- Count rows in candidate tables to select two small tables
-- for the CROSS JOIN.

SELECT 'renters' AS table_name, COUNT(*) AS row_count
FROM renters

UNION ALL

SELECT 'amenities', COUNT(*)
FROM amenities

UNION ALL

SELECT 'properties', COUNT(*)
FROM properties;



-- Task 5.3 - Part A
-- CROSS JOIN: What combinations result when every property
-- the results for each small table is 
-- amenities - 5 and properties 15
-- this gives us a total of 75 cross joins

SELECT
    p.property_id,
    p.property_label,
    a.amenity_id,
    a.amenity_name
FROM properties AS p
CROSS JOIN amenities AS a
ORDER BY
    p.property_id,
    a.amenity_id;


-- Task 5.3 - Part A
-- validation part
-- Verify the number of rows produced by the CROSS JOIN.
-- 15 properties x 5 amenities should produce 75 rows.

SELECT
    COUNT(*) AS cross_join_rows
FROM properties AS p
CROSS JOIN amenities AS a;


-- Task 5.3 - Part A - Question 3
-- Verify that the CROSS JOIN row count equals
-- properties count multiplied by amenities count.

SELECT
    (SELECT COUNT(*) FROM properties) AS property_count,
    (SELECT COUNT(*) FROM amenities) AS amenity_count,
    (SELECT COUNT(*)
     FROM properties
     CROSS JOIN amenities) AS cross_join_count;

-- Task 5.3 - Part A - 4 Cartesian Product
-- ####################################################
-- the CP is useful if you intentionally want to create every possible
-- combination for each property to amenity combination.  However, it may be to
-- much for leadership to look at instead of just showing each property 
-- with it listed amenity, which would be an easier viewing. 
-- #####################################################
