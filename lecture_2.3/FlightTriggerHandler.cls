public class FlightTriggerWithHandler {       
    
    public static void onBeforeInsert (Set<Flight__c> newFlight) {   
        List<Tourist__c> tourists = TouristManager.getByAges(newFlight);
        List<Trip__c> trips = TripManager.getByStartDate(newFlight);
       
        for (Flight__c flight : newFlight) {
            
            for (Tourist__c tourist : tourists) {
                if (flight.Tourist__c == tourist.Id) {
                    
                    for (Trip__c trip : trips) {
                        if (flight.Trip__c == trip.Id) {
                            if (tourist.Age__c < trip.Minimum_Age__c) {
                                flight.addError(Constans.errorMinAge);
                            }
                            if (flight.Status__c == 'Past' || date.today() > trip.Start_Date__c) {
                                flight.addError(Constans.errorFlightStatus);
                                flight.Status__c.addError(Constans.errorFlightStatus);
                            }
                        }                        
                    }                    
                }
            }       
        }
    }
}