public inherited sharing class TouristAssignmentController {
    
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
    
    @AuraEnabled(cacheable = true)
    public static List<Trip__c> getTrip(Id tripId) {
        List<Trip__c> result = TripManager.getName(tripId);
        return result;
    }
    
    @AuraEnabled(cacheable = true)
    public static Weather_Daily_Forecast__c getTemperature(Id tripId) {
        Trip__c trip = TripManager.getSpacePoint(tripId)[0];
        Id spacePoint = trip.Departure_Space_Point__c;
        Weather_Daily_Forecast__c temperature = WeatherForecastManager.getAverageTemperature(spacePoint);
        return temperature;
    }
    
    @AuraEnabled(cacheable = true)
    public static Space_Point__c getSpacePoint(Id spacePointId) {
        Space_Point__c spacePoint = SpacePointManager.getCityAndCountry(spacePointId)[0];        
        return spacePoint;
    }
}