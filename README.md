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

**ERD Image Drawio:** 

![App ex603-Rental-Market-Place-database](schema/rentalMarketERD_2026.png)


**ERD Image pgAdmin - postgreSQL:**

![App ex603-Rental-Market-Place-database](schema/pgadmin.png)



















