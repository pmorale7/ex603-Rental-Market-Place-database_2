-- Table 3.2 - Find the Bug
-- Step 1
-- Using the viewings table as that has 166 items labeled NULL
-- on the No_show_reason column. 
-- REquirementss: select * on viewings table
-- This will pull all items from viewings and show on last column
-- all NULL values

SELECT *
FROM viewings

-- Table 3.2 - question 2
-- query the negation and inequality predicate on the no show reason column
-- where is not equal to ' Renter no show' 
-- the total value of nulls is 166 the query return 22 - opposite
-- second query returns the 166 which does not add up to the 200 records in data set.
-- tricky question with changes in where clause it gives totally different data. 

SELECT COUNT(*) AS row_count
FROM viewings
WHERE No_show_reason != 'No data of null';

-- Table 3.2 - Question 3

SELECT COUNT(*) AS omitted_rows
FROM viewings
WHERE no_show_reason IS NULL;

-- Table 3.2 - question 4

SELECT COUNT(*) AS corrected_count
FROM viewings
WHERE no_show_reason != 'No data of null'
   OR no_show_reason IS NULL;


-- Part B - The alias that did not exist yet
-- Table 3.2 - Second part
-- writing and execution order of sql
-- select, from, where 
-- execution order - from, where, select
-- writing query defining an alias in select and referencing it
-- within where.  blows an ,  alias is annual_rent

SELECT
    property_label,
    monthly_rent * 12 AS annual_rent
FROM properties
WHERE annual_rent > 24000;

-- first fix copy
-- working copy with alias fixed
-- remembering the order of execution

SELECT
    property_label,
    monthly_rent * 12 AS annual_rent
FROM properties
WHERE monthly_rent * 12 > 24000;

-- second fix copy
-- ai assistance on this one
-- CTE issues 

WITH rental_costs AS (
    SELECT
        property_label,
        monthly_rent * 12 AS annual_rent
    FROM properties
)
SELECT
    property_label,
    annual_rent
FROM rental_costs
WHERE annual_rent > 24000;

