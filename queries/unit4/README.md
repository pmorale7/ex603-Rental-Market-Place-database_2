## SQL queries for Unit 4

# READ.md

Conditional aggregation allows SQL to calculate multiple results plenty of times especially with a single query.  Additionally, you do not have to run separate queries for each condition.  Within our RentalMarket place database, we used COUNT(*) to calculate total viewings events and SUM(CASE WHEN viewing_status= "cancelled' THEN 1 ELSE0 END) to count failed events.  This allowed us to calculate both results while grouping the data by property. This gave us an deep dive of the actual cancelled viewing against the producers(properties).  

We could have done it separate by running queries for viewing purposes and using the WHERE clause for cancelled events.  Both of these approaches would have gotten use to the same place in terms of shedding light on our the data.  We just did not go about querying the data multiple times, in different ways.  It was a lot easier to do it quick and to the point with the SQL we created instead of separately. 

If we did this a million times, hitting the database or backend, it would take more processing time, memory usage, and give the backend a workload we did not want.  Conditional aggregation as better and faster in design which reduces that workload, and memory usage.  

A huge advantage if its simplicity and consistency.  Calculating queries in one proves it based on one dataset, reducing the possibility of errors or differences in data records.  Lastly, conditional aggregation makes SQL better suited for large data sets and business reporting for dashboard analytics. 
