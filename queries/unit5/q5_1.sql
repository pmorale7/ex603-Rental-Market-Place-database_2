-- Task 5.1, Question 1
-- Which Actor(renter) attended each Event(viewing), which Producer(property) did they view,
-- and when did the viewing occur?

SELECT
    r.renter_name,
    p.property_label,
    v.attended_at
FROM viewings AS v
INNER JOIN renters AS r
    ON v.renter_id = r.renter_id
INNER JOIN properties AS p
    ON v.property_id = p.property_id
ORDER BY v.attended_at;


-- Task 5.1 - Question 2
-- Does the high-failure properties identified in Assignment 4
-- share certain catalog amenities or tags?  Properties are labeded
-- with the single numbers, queried from assignment 4

SELECT
    p.property_id,
    p.property_label,
    a.amenity_name
FROM properties AS p
INNER JOIN listing_amenities AS la
    ON p.property_id = la.property_id
INNER JOIN amenities AS a
    ON la.amenity_id = a.amenity_id
WHERE p.property_id IN (11, 9, 2, 3, 6, 1, 7, 5)
ORDER BY
    p.property_id,
    a.amenity_name;


-- Task 5.1 - Question 3
-- How do properties compare with other properties in the same city?
-- This self join compares producers (properties) that share a city
-- so their characteristics can be compared with Assignment 4 performance.

SELECT
    p1.property_id AS property_1_id,
    p1.property_label AS property_1,
    p1.city,
    p1.monthly_rent AS property_1_rent,
    p1.is_available AS property_1_available,

    p2.property_id AS property_2_id,
    p2.property_label AS property_2,
    p2.monthly_rent AS property_2_rent,
    p2.is_available AS property_2_available

FROM properties AS p1

INNER JOIN properties AS p2
    ON p1.city = p2.city
    AND p1.property_id < p2.property_id

ORDER BY
    p1.city,
    p1.property_id,
    p2.property_id;
