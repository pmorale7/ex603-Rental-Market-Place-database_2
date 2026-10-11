-- Task 3.1 - Query 1
-- Looking for properties (producers), sorted and up to 10 
-- Where the monthly rent is less than $2,000
-- Requirement: SELECT, FROM, WHERE, ORDER BY AND LIMIT

SELECT property_id, property_label, city, monthly_rent
FROM properties
WHERE is_available = TRUE
and monthly_rent <= 2000
ORDER BY monthly_rent ASC, property_id
LIMIT 10;

-- Task 3.1  - Query 2
-- Select all event statuses and display the distinct ones
-- Also, are there more status than expected.
-- returned three statuses. all that appeared and one
-- disputed status not mentioned in any other area
-- Requirements - select distinct, from, order by

SELECT DISTINCT viewing_status
FROM viewings
ORDER BY viewing_status;


-- Task 3.1  - Query 3
-- Events = Viewings
-- Select viewing_id and duration_min from viewings
-- using 30 min to 60 min of viewing of properties to understand metric
-- order by ascending order
-- Several properties show (33) in total under 60 min and greater than 30 min
-- Part II of question 3 using the IN operator
-- Requirements - select, from, where, between, and, order by, asc

SELECT viewing_id, duration_min
FROM viewings
WHERE duration_min BETWEEN 30 AND 60
ORDER BY duration_min ASC;

-- Task 3.1 - Query 3a
-- selected two columns to see the 
-- interest score on the scheduled time of viewing
-- very low scores on many time frames
-- Requirements - select, from, where, order by 

SELECT scheduled_at, interest_score
FROM viewings
WHERE interest_score IN (1, 2)
ORDER BY scheduled_at;

-- Task 3.1 - Query 4
-- Working with text and missing values, 
-- Section: producers = properties
-- using producers whose names match a text pattern
-- does not produce anything on the properties, they have the same name
-- only a different number on the end. Not a good query
-- used a capital P to pull data. 
-- second query we can use the viewing table as it has data for null 
-- properties does not have it when we checked. 
-- Requirements - select, from, where, order by, like


SELECT property_id, property_label
FROM properties
WHERE property_label LIKE 'P%'
ORDER BY property_label;

-- Table 3.1 - 4a - Second part of question
-- Second part of question substitute the NULL values for No Reason Provided
-- using the viewings table as we had the data there for it. 
-- Requirements: select, coalesce, from , where, as, where, is null

SELECT viewing_id, 
COALESCE (no_show_reason, 'No reason provided') AS reason
FROM viewings
WHERE no_show_reason IS NULL;


-- Table 3.1 - Query 5
-- Requirements - select, case, when, then, else, from, order by, asc
-- rental properties monthly cost is calculated by 12 month period
-- and categorized by either budget and moderate.

SELECT property_label, monthly_rent, monthly_rent * 12 AS annual_rent,
CASE 
WHEN monthly_rent < 1500 THEN 'Budget'
WHEN monthly_rent <= 2000 THEN 'Moderate'
ELSE 'Premium'
END AS rental_category
FROM properties
ORDER BY monthly_rent ASC;
