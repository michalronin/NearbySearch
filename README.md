# NearbySearch

A simple app pulling nearby cafes, bars and restaurants from Google Places API. 

# Design considerations
* Programmatic UI
* No external frameworks
* MVC
* Singleton for network calls
* Table View for presenting result list
* View controller for presenting place details

# Note:
As Google Places API does not allow for searching multiple place types, three separate calls are being made.
