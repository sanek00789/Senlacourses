public inherited sharing class RegTouristsForTripController {
    
    @AuraEnabled(cacheable = true)
    public static List <Tourist__c> getSuitableForTrip(Id tripId) {        
        List <Tourist__c> result = TouristManager.getSuitableForTrip(tripId);
        return result;
    } 
    
    @AuraEnabled
    public static void createFlights(List<Id> touristIds, Id tripId) {
        TouristService.createFlights(touristIds, tripId);
    }  
}