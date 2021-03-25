public class FlightManager {
    
    public static List<Flight__c> getByStatus (Set<Id> idTourists) {
        List<Flight__c> listFlights = [
            SELECT Tourist__c, 
            		Tourist__r.Active__c, 
            		Status__c 
            FROM Flight__c 
            WHERE Tourist__c IN : idTourists];
        return listFlights;        
    }
}