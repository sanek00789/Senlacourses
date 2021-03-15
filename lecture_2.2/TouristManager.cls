public class TouristManager {
    
    public static List<Tourist__c> getByName (String Name) {
        List<Tourist__c> tourists = [
            SELECT Name, 
            	   Age__c 
            FROM Tourist__c
            WHERE Name = :Name
        ];
        return tourists;
    }
    
    public static List<Tourist__c> getByAge (Integer Age) {
        List<Tourist__c> tourists = [
            SELECT Name, 
            	   Age__c 
            FROM Tourist__c 
            WHERE Age__c =: Age
        ];        
        return tourists;
    }
    
    public static List<Flight__c> getByStartYear (Integer StartYear) {
        List<Flight__c> flights = [
            SELECT  Tourist__r.Name,
            		Tourist__r.Age__c 
            FROM Flight__c 
            WHERE CALENDAR_YEAR(Trip__r.Start_Date__c) =: StartYear
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
}