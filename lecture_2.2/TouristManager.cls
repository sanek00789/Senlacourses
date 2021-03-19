public class TouristManager {
    
    public static List<Tourist__c> getByName (String name) {
        List<Tourist__c> tourists = [
            SELECT Name, 
            	   Age__c 
            FROM Tourist__c
            WHERE Name = :name
        ];
        return tourists;
    }
    
    public static List<Tourist__c> getByAge (Integer age) {
        List<Tourist__c> tourists = [
            SELECT Name, 
            	   Age__c 
            FROM Tourist__c 
            WHERE Age__c =: age
        ];        
        return tourists;
    }
    
    public static List<Flight__c> getByStartYear (Integer startYear) {
        List<Flight__c> flights = [
            SELECT  Tourist__r.Name,
            		Tourist__r.Age__c 
            FROM Flight__c 
            WHERE CALENDAR_YEAR(Trip__r.Start_Date__c) =: startYear
        ];        
        return flights;
    }
    
    public static void getTouristsWithFlights () {
        List<Tourist__c> tourists = [
            SELECT Name, 
            	   Age__c, 
            	   (SELECT Trip__r.Start_Date__c, Name FROM Flights__r)
            FROM Tourist__c
        ];        
    }
    
    public static void getTouristsWithoutFlights () {
        List<Tourist__c> tourists = [
            SELECT Name, 
            	   Age__c 
            FROM Tourist__c 
            WHERE Upcoming_Flights_Count__c = 0
        ];
    }
    
    public static List<Tourist__c> getTouristsByEmail (List<Tourist__c> newTourists) {
        Set<String> setName = new Set<String>();
        Set<String> setEmail = new Set<String>();
        
        for (Tourist__c  tourist : newTourists) {
            setName.add(tourist.Name);
            setEmail.add(tourist.Email__c);
        }        
        Set<Tourist__c> revisedTourist = new Set<Tourist__c> {};    
           List<Tourist__c> recordsTourists = [
                SELECT Name,
                		Email__c,
                		IsDuplicate__c 
                FROM Tourist__c 
                WHERE Name =: setName AND Email__c =: setEmail];
        return recordsTourists;
    }
}