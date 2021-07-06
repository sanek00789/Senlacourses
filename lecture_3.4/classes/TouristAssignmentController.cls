public without sharing class TouristAssignmentController {
    
    @AuraEnabled(cacheable = true)
    public static List <Trip__c> getTripsById(Id touristId) {        
        List<Trip__c> trips = TripManager.getById(touristId);
        return trips;
    }
    
    @AuraEnabled
    public static void createFlight(Id touristId, Id tripId) {
        List<Id> touristIds = new List<Id> {touristId};
        TouristService.createFlights(touristIds, tripId);        
    }   
}