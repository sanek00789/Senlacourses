public class RegTouristsForTripController {
    
    @AuraEnabled
    public static List <Tourist__c> getSuitableForTrip(Id tripId) {        
        List <Tourist__c> result = TouristManager.getSuitableForTrip(tripId);
        return result;
    } 
    
    @AuraEnabled
    public static void createFlights(List<Id> touristsIds, Id tripId) {
        List<Flight__c> newFlights = new List<Flight__c>();
        for(Id touristId :touristsIds) {
            Flight__c newFlight = new Flight__c ();            
            newFlight.Trip__c = tripId;            
            newFlight.Tourist__c = touristId;
            newFlight.Status__c = Constans.FLIGHT_STATUS_OFFER_PENDING;           
            newFlights.add(newFlight);
        }
        insert newFlights;
    }
    
    @AuraEnabled
    public static Integer countFreeSeats(Id tripId) {
        Integer occupiedSeats = FlightManager.getNumberOfRegisteredTourists(tripId);
        Integer numberSeats = TripManager.getNumberSeats(tripId);
        Integer result = numberSeats - occupiedSeats;
        return result; 
    }
    
    @AuraEnabled
    public static Date getStartDate(Id tripId) {        
        return TripManager.getStartDate(tripId); 
    }    
}