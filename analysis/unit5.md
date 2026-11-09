# Task 5.1 Connect Producers to Their Data

The features or report that can be used the viewing activity report as it uses a three-table join to show who is viewing properties and when the viewing occur.  The report would have the renter, viewing, and the property tables to display the renter's name, the property they viewed, and the data and time of that viewing.  This would help management monitor viewing activity and understand which renters are viewing which properties.

The junction table for the amenities is important because it connects properties to their amenities provided.  A property can have many amenities, and the same amenity can belong to many properties, which would essentially create a many to many relationship.  The junction table gave us insight on which amenities were associated with the high failure properties from assignment 4.  Without this I was not able to make the direct connection to properties on multiple amenities, which would make it difficult to determine if the high failure rate properties shared any common characteristics.

# Task 5.2 (A | B | C)

The first question and sql code which was an inner join excluded both property 14 and property 15.  The were not in the total set due to not having any views or viewing events on the viewing table.

The second question data results were that a property that does not have any viewing but still exists in the viewing table, is basically stating property exist but no one is looking at it and has no activity.  The queries show property 14 and 15 have no viewing.  However, we do not see why?  The only thing we can ascertain is the property is not of interest to a renter, its unavailable, newly listed, or not been on the market long. 

The report for leadership would show the inner join will only view activity with properties that have viewing but no viewing for properties that disappear from the report entirely.  This give leadership a false sense of data and all data is not showing and they can only see the viewed properties.

Leadership may want to identify properties that have never had viewing activity so they can determine whether those listings need attention or removal.  It could represent a mis opportunity for the platform.  Leadership could look for data on why but the data does not establish which of these factors caused the lack of activity.

Leadership can determine if both 14 and 15 property set are available, correctly priced, accurately listed, and are being properly marketed to renters.  Leadership should improve that and adjust prices if necessary, or remove the listing for inactivity.  There will still need more investigation on the sql results to determine that. 





# Task 5.3 Understand Join Performance and Execution Plans

A cartesian product could be useful on my rental marketplace if I wanted to calculate every possible combination from the properties and amenities tables.  The cross join combined the 5 amenities and 15 properties calling for 75 total combinations.  This could be used for every possible assigned or missing amenities to every properties.  This is why is may be useful to use. 

The algorithms used for postgres were two of them of them.  The hash join to connect the viewings and renters tables using the renter id.  Then the nested loop to connect those results to the properties table using the property id.  The execution plan showed an index scan on the properties pk and memoize to cache it all for reference on look up later on. 

The execution plan shows that viewings table had 200 rows and renters table had 100 rows. The choice to use scans on those small tables and a hash join to match their renter id values.  The properties table showed an index scan using the properties pk and memoize to repeat property lookup.  This is why postgressql used them due to table estimates, and estimated costs.

Understanding why the join algorithms helps use determine how postgresql processes a query and to see if as the dataset grows will it continue to remain efficient.  It can help find and show performance problems, like repeated lookups, or whether indexes, queries, or other database improvements may be needed as more viewing data is added.

As this rental marketplace grows, the viewing table could increase from hundreds of records to thousands or millions as stated before.  At scale, postgressql may chose something else and no longer support using nested loops. It can chose a different join or merge.  Anything this is addition to a dataset there is always a change on how to execute it queries and the cost attached to it.

