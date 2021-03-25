public class TripManager {
    
    public static List<Trip__c> getByStartDate (Set<Flight__c> newFlights) {
        Set<Id> trips = new Set<Id>();        
        
        for (Flight__c  flight : newFlights) {
            trips.add(flight.Trip__c);           
        }  
        List<Trip__c> recordsTrips = [
            SELECT Name,
            		Minimum_Age__c,
            		Start_Date__c 
            FROM Trip__c 
            WHERE Id IN : trips];
        return recordsTrips;
    }
}