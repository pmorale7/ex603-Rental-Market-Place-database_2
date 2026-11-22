# Rental Marketplace Analytics Project

**Author:** Philip Morales  
**Database:** PostgreSQL / pgAdmin  
**Theme:** Cargo Van Rental Marketplace

## Project Summary

This project analyzes a Rental Marketplace relational database using PostgreSQL. I adapted the provided marketplace dataset to represent a **cargo van rental platform**, where rental vehicle listings are represented by the database's `properties` table, customers are represented by `renters`, customer interactions with vehicle listings are represented by `viewings`, and vehicle features are represented by `amenities`.

The project progresses from basic database queries to business-focused analytics involving aggregations, joins, common table expressions, query execution plans, and window functions. The primary goal is to understand customer viewing activity, identify vehicle listings with unusually high cancellation rates or no activity, compare listing performance, and determine whether marketplace performance is improving or worsening over time.

## Domain

The business scenario is a cargo van rental marketplace where customers can browse available vehicle listings before deciding which vehicle to rent. Vehicle listings may represent cargo vans such as Ford Transit or Ram ProMaster models with different prices, locations, availability, and equipment.

The database uses generic Rental Marketplace terminology. For this project, the `properties` table represents **rental vehicle listings**, rather than real-estate properties. The `renters` table represents customers, while the `viewings` table records customer activity involving those listings. The `amenities` table represents features or equipment associated with a vehicle, and `listing_amenities` connects vehicle listings with those features through a many-to-many relationship.

The analytical portion of the project focuses primarily on viewing activity. Viewing duration provides one measure of customer interaction with a listing, while viewing status allows cancelled events to be analyzed as failures. The analysis examines activity by vehicle listing, identifies listings with unusually high failure rates, finds listings with no recorded viewing activity, compares monthly performance, and uses window functions to examine trends over time.

## Database Terminology

Because the project uses the database structure provided for the course, the SQL retains the original table and column names.

| Database Name | Cargo Van Marketplace Meaning |
|---|---|
| `properties` | Rental vehicle listings |
| `renters` | Customers |
| `viewings` | Customer viewing/interactions with vehicle listings |
| `amenities` | Vehicle features or equipment |
| `listing_amenities` | Relationship between vehicles and their features |
| `property_id` | Vehicle-listing identifier |
| `property_label` | Vehicle-listing label |
| `is_available` | Whether the listing is currently available |
| `city` | Listing/market location |

Keeping the original database names ensures that the SQL queries remain consistent with the provided dataset while allowing the analysis to be interpreted within the cargo van rental marketplace theme. 

## Database Overview

The project uses the PostgreSQL relational database provided in Unit 3. The original database table and column names are retained throughout the project so that all SQL queries remain consistent with the provided dataset.

For the Cargo Van Rental Marketplace theme, the generic marketplace terminology is interpreted as follows:

- **`properties`** represents cargo van rental listings. Each listing contains information such as its listing label, location, rental-price field, and availability.
- **`renters`** represents customers using the marketplace to browse rental vehicle listings.
- **`viewings`** represents customer interactions with vehicle listings. This table contains the event data used throughout much of the analysis, including viewing duration, scheduled and attended times, viewing status, and the renter and property associated with each event.
- **`amenities`** represents features or equipment associated with rental vehicle listings.
- **`listing_amenities`** is the junction table connecting rental vehicle listings to their available features.
- **`property_features`** contains additional feature information associated with the marketplace listings.

The `viewings` table became the primary event table for the analytical portion of the project. It allowed viewing activity to be measured by property, customer, time, duration, and status. A cancelled viewing was used as the failure metric when analyzing property performance.

The database relationships also made it possible to connect viewing activity with customer information, vehicle-listing information, and amenities. These relationships were used in later units to identify high-failure listings, listings with no activity, differences between properties, and changes in marketplace performance over time.

### Entity Relationship Diagram

The ERD below documents the relationships among the core marketplace tables. Although the database uses the name `properties`, this project interprets those records as cargo van rental listings.

The database structure and DDL were provided as part of the Unit 3 dataset and were used as the foundation for the analytical SQL developed in later units.




**ERD Image Drawio:** 

![App ex603-Rental-Market-Place-database](schema/rentalMarketERD_2026.png)


**ERD Image pgAdmin - postgreSQL:**

![App ex603-Rental-Market-Place-database](schema/pgadmin.png)



## Query Catalogue

The SQL analysis developed throughout the course progresses from basic database exploration to performance analysis, joins, execution plans, and window-function reporting.

### Unit 3 — Querying and Validating Marketplace Data

| Query | Business / Analytical Question |
|---|---|
| `q3_1.sql` | What properties are available at different price levels, what viewing statuses and customer-interest patterns exist, and how can marketplace data be filtered and categorized? |
| `q3_2.sql` | How can NULL values and SQL execution order cause unexpected query results, and how can conditions and CTEs be used to correct those problems? |
| `q3_3.sql` | Which renters have never had a disputed viewing, and how do NOT IN, NOT EXISTS, CTEs, and EXCEPT compare when identifying those renters? |

Unit 3 established the foundation for analyzing the Rental Marketplace dataset. The queries explored properties, renters, viewing activity, pricing, viewing status, duration, interest scores, and missing values. The unit also demonstrated how NULL values can affect query results and compared several approaches for identifying records that do not meet a particular condition.


### Unit 4 — Platform Performance

| Query | Business Question |
|---|---|
| `q4_1.sql` | How much viewing activity exists on the platform, and how do viewing counts and average durations vary by property and city? |
| `q4_2.sql` | Which properties have the highest cancellation rates, and how does their performance compare with the platform baseline? |

Unit 4 established the primary performance measures used later in the project. A cancelled viewing was defined as a failed event, and properties with at least 10 viewing events were analyzed individually.

### Unit 5 — Connecting and Finding Missing Data

| Query | Business Question |
|---|---|
| `q5_1.sql` | Who is behind each viewing event, what amenities are associated with high-failure properties, and how do similar properties compare? |
| `q5_2.sql` | Which properties have never had a viewing event, and what information is lost when only matching records are reported? |
| `q5_3.sql` | How do Cartesian products and PostgreSQL execution plans affect query results and performance? |

Unit 5 connected viewing activity with renters, properties, and amenities. It also identified Property_14 and Property_15 as listings with no recorded viewing events.

### Unit 6 — Trends and Window Functions

| Query | Business Question |
|---|---|
| `q6_1.sql` | How does each viewing compare with its property's average, how should properties be ranked, and how can they be divided into activity bands? |
| `q6_2.sql` | How does viewing activity change from event to event and over time, and where do extended gaps in property activity occur? |
| `q6_3.sql` | What are the top viewing events for each property, and is the platform's cancellation rate improving or worsening month over month? |

Unit 6 uses window functions to preserve individual records while calculating averages, rankings, running totals, moving averages, event-to-event changes, and month-over-month performance.


## Technical Highlights

### 1. Aggregation — Property Failure Rates

In Unit 4, aggregation was used to measure the performance of individual property listings. `COUNT()`, `SUM()`, `CASE`, and `GROUP BY` were combined to count total viewing events and cancelled events for each property. This allowed a failure rate to be calculated for high-volume properties. For example, Property 11 had 16 viewing events, 5 cancelled events, and a 31.25% failure rate. Aggregation was useful because it transformed individual viewing records into property-level performance measures that leadership could compare.

### 2. JOINs — Finding Properties With No Activity

In Unit 5, joins were used to connect property listings with their viewing events. Comparing a `LEFT JOIN` with an `INNER JOIN` revealed that Property_14 and Property_15 existed in the marketplace but had no matching viewing events. The `LEFT JOIN` preserved these properties while the `INNER JOIN` excluded them. This demonstrated why the choice of join matters when building reports: using only an `INNER JOIN` could hide inactive listings and give leadership an incomplete picture of the marketplace.

### 3. Window Functions — Comparing Events With Property Averages

In Unit 6, window functions allowed individual viewing events to be analyzed without collapsing the underlying rows. `AVG(duration_min) OVER (PARTITION BY property_id)` displayed each viewing's duration beside the average duration for that property. The window-function query preserved all 200 viewing events, while the equivalent `GROUP BY` query reduced the results to 13 property-level rows. This made it possible to identify individual viewing events that were unusually long or short compared with the normal activity for their property.



## Findings and Recommendations

### 1. Some Listings Have High Cancellation Rates

The property-level analysis found meaningful differences in cancellation performance. Property 11 had the highest failure rate among the high-volume properties, with 5 cancelled events out of 16 total viewing events, resulting in a 31.25% failure rate. Property 9 followed at 28.57%, and Property 2 had a 25.00% failure rate.

**Recommendation:** Leadership should investigate the properties with the highest cancellation rates to determine whether cancellations are related to property availability, renter behavior, scheduling, or other operational factors. The SQL identifies where the problems are occurring, but additional information is needed to determine their cause.

### 2. Two Listings Had No Viewing Activity

The outer-join analysis identified Property_14 and Property_15 as listings with no recorded viewing events. These properties appeared when using a `LEFT JOIN` but disappeared from an `INNER JOIN` because there were no matching records in the `viewings` table.

**Recommendation:** These listings should be reviewed separately from high-failure properties. Leadership should verify their availability, pricing, listing visibility, and market interest to determine why they have generated no viewing activity.

### 3. Failure Rates Improved Overall but Remained Unstable

The month-over-month analysis showed that the platform's failure rate decreased from 23.81% in January to 18.75% in December. However, performance was not consistently improving. Failure rates varied substantially during the year, including 27.27% in March, 0.00% in April, 25.00% in June, and 11.11% in October.

**Recommendation:** Leadership should focus next quarter on reducing month-to-month volatility. Large increases in cancellation rates should trigger a review of the affected properties and viewing events so that problems can be identified and addressed before they continue into later months.








