
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


-- Task 5.3 - B Examine Query Execution Plan

Q1
-- Capture the full execution plan:
-- screenshot will be places within th e screenshots folder for this query

Q2
-- Identify the join algorithm or algorithms used, such as Nested Loop, Hash Join, or Merge Join.
-- I see Hash Join, Has Cond: (v.renter_id = r.renter_id), that is the viewings to renters
-- a Nested loop also where the total 200 properties set to be connected it shows. 
-- it also uses a  index scan on the properties using pk on property id
-- to match properties.  
-- is it cached in memory as well

Q3 
-- Explain why PostgreSQL may have selected these algorithms, considering table sizes and available indexes.
-- It is a small dataset to use on the viewings and properties, and renters.
-- the hash join is efficient to use to build a small hash table from the renters quickly.
-- uses the property id postgres can be efficient for each viewing on the look up quickly.
-- memoize makes this quicker and more efficient because it can reference it at this point the same 
-- property. and cache the findings. 

Q4
-- Predict which part of the query might become less efficient as the dataset grows.
-- with only 200 sets to views, now if the dataset grew to 100,000 or 1, 000,000 
-- the dataset will have many more records to join and sort.  the efficienciy gets less
-- important and processing power becomes expensive.  For nested loop it would have more records
-- as it increases costing more.  There may be a different way to execute this query.




























