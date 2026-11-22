## Unit 6 Write UP Section 1

A question to ask would be: Which viewings within the dataset, who have durations that area high or low compared with the average viewings duration for that property? 

Using the window function can answer this because it keeps every individual viewing row while also displaying the properties average viewing duration on the same row.  That means all 200 events are populated and show.  If we use GROUP BY the returned will only give you the 13 summed up property level rows, GROUP BY calculates the property average but removes the individual viewing records which is show on the window function (200), so we can no longer compare a specific viewing with its property averages or even by row.


Using a property activity leaderboard could rank properties based on the number of viewing events they receive.  I would use the three to make that distinction.  Rank() because properties with the same number of viewing events should receive the same rankings.  Looking at the output for properties 5 and 7 they were both ranked 4 and both had 18 events.  Row_number() placed them at ranks 4 and 5 even though their activity was equal. Lastly, Rank() provides a fairer representation of tied properties, even though it leaves a gap in the next ranking position.   


## Section 2 

A large delta means that the duration of viewing changed compared with the previous viewing for the same property.  For example property 1 had an increase from 7:40 min to 29.07 min, a delta of +21.67 min.  A larg change does not tell us the cause, but it can identify activity that should be investigated.  Management could  review the viewing status, renter activity, property availability, or other event details to determine why the viewing duration changed so much.

A plain SUM tells us the total number of viewing events for the entire period, but it does not show how tha total was reached over time.  A running total keeps each date visible and shows the cumulative number of viewings as activity progresses.  this allows leadership to see the pace of the platform activity,  when the right number is reached, and whether progress toward a target is speeding up or slowing down, 

I chose the seven row moving average to smooth out short term changes in viewing activity while still shoiwng recent trends.  Seven rows provide more context than looking at a single activty date without allowing older activity to dominate the result.  Because our data does not contain viewing events on every calendar date, seven rows do not necessarily represent seven consecutive days.  A larger window would produce a smoother long-term trend, while a smaller window would react more quickly to short term changes

A gap means a property had no recorded viewing event for a period of time and then viewing activity resumed.   We need to investigate whether the property was unavailable or inactive during that period, whether renters simply scheudled no viewings, or whether viewing records were missing.  therefore, the gap should be treated as an item requiring further invesigation rather than automatically classifield as a platform or data quailty problem.











