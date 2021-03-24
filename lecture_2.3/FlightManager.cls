public class FlightManager {
    
    public static List<Flight__c> getByStatus () {
        List<Flight__c> listFlights = [
            SELECT Tourist__c, 
            		Status__c 
            FROM Flight__c];
        return listFlights;        
    }
}