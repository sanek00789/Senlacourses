public class TouristAssignmentController {
    
    @AuraEnabled
    public static List <Trip__c> getTripsById(Id touristId) {
        if (touristId == null) {
            return new List<Trip__c> ();
        }
        List<Trip__c> trips = TripManager.getById(touristId);
        return trips;
    }
    
    @AuraEnabled
    public static void createFlight(Id touristId, Id tripId) {
        Flight__c newFlight = new Flight__c();                                
        newFlight.Trip__c = tripId;            
        newFlight.Tourist__c = touristId;
        newFlight.Status__c = Constans.FLIGHT_STATUS_REQUSTED; 
        insert newFlight;
    }
    
    @AuraEnabled
    public static List<Trip__c> getTrip(Id tripId) {
        List<Trip__c> result = TripManager.getName(tripId);
        return result;
    }
    
    @AuraEnabled
    public static Weather_Daily_Forecast__c getTemperature(Id tripId) {
        Trip__c trip = TripManager.getSpacePoint(tripId)[0];
        Id spacePoint = trip.Departure_Space_Point__c;
        Weather_Daily_Forecast__c temperature = WeatherForecastManager.getAverageTemperature(spacePoint);
        return temperature;
    }
    
}