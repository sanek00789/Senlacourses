public class TripManager {
    
    public static List<Trip__c> getByIds (Set<Id> tripIds) {        
        List<Trip__c> trips = [
            SELECT Name,
            		Minimum_Age__c,
            		Start_Date__c 
            FROM Trip__c 
            WHERE Id IN : tripIds];
        return trips;
    }
}