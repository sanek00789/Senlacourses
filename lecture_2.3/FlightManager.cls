public class FlightManager {
    
    public static List<Flight__c> getStatus (Set<Id> idTourists) {
        List<Flight__c> flights = [
            SELECT Tourist__c, 
            		Tourist__r.Active__c, 
            		Status__c 
            FROM Flight__c 
            WHERE Tourist__c IN : idTourists];
        return flights;        
    }
}