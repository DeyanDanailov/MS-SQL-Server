UPDATE  Tickets
SET Price*=1.13
where FlightId in (SELECT Id
    from Flights
    where Destination='Carlsbad')
