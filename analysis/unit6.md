## Unit 6 Write UP

A question to ask would be: Which viewings within the dataset, who have durations that area high or low compared with the average viewings duration for that property? 

Using the window function can answer this because it keeps every individual viewing row while also displaying the properties average viewing duration on the same row.  That means all 200 events are populated and show.  If we use GROUP BY the returned will only give you the 13 summed up property level rows, GROUP BY calculates the property average but removes the individual viewing records which is show on the window function (200), so we can no longer compare a specific viewing with its property averages or even by row.
