public class RegTouristsForTripController {
    
    @AuraEnabled
    public static List <Tourist__c> getSuitableForTrip(Id recordId) {        
        List <Tourist__c> result = TouristManager.getSuitableForTrip(recordId);
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
    public static Integer countSeats(Id tripId) {
        Integer occupiedSeats = FlightManager.getNumberOfRegisteredTourists(tripId);
        Integer numberSeats = TripManager.getNumberSeats(tripId);
        Integer countFreeSeats = numberSeats - occupiedSeats;
        return countFreeSeats; 
    }
}