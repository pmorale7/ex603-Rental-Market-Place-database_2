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
