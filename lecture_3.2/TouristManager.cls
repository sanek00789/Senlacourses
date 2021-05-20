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
    
    public static void getWithFlights () {
        List<Tourist__c> tourists = [
            SELECT Name, 
            	   Age__c, 
            	   (SELECT Trip__r.Start_Date__c, Name FROM Flights__r)
            FROM Tourist__c
        ];        
    }
    
    public static void getWithoutFlights () {
        List<Tourist__c> tourists = [
            SELECT Name, 
            	   Age__c 
            FROM Tourist__c 
            WHERE Upcoming_Flights_Count__c = 0
        ];
    }
    
    public static List<Tourist__c> getByNamesAndEmails (Set<String> names, Set<String> emails) {                   
        List<Tourist__c> recordsTourists = [
            SELECT Name,
            Email__c,
            IsDuplicate__c 
            FROM Tourist__c 
            WHERE Name =: names AND Email__c =: emails];
        return recordsTourists;
    }
    
    public static List<Tourist__c> getActive () {
        List<Tourist__c> listTourists = [
            SELECT Id, 
            		Active__c 
            FROM Tourist__c];
        return listTourists;        
    }
    
    public static List<Tourist__c> getByIds (Set<Id> touristIds) {
        List<Tourist__c> recordsTourists = [
            SELECT Name,
            Age__c,
            Email__c
            FROM Tourist__c 
            WHERE Id IN : touristIds];
        return recordsTourists;
    }
	
	public static List<Tourist__c> getByNameAndEmail (String name, String email) {                   
        List<Tourist__c> recordsTourists = [
            SELECT Name,
            Email__c,
            IsDuplicate__c 
            FROM Tourist__c 
            WHERE Name =: name AND Email__c =: email];
        return recordsTourists;
    }
    
    public static List<Tourist__c> getByFuzzynameAndAge (String fuzzyname, Integer age) {                   
        List<Tourist__c> recordsTourists = [
                SELECT Name, 
                Age__c 
                FROM Tourist__c
                WHERE Name LIKE :fuzzyname OR Age__c =:age];
        return recordsTourists;
    }
    
    public static List<Tourist__c> getByFuzzyname (String fuzzyname ) {                   
        List<Tourist__c> recordsTourists = [
                SELECT Name, 
                Age__c 
                FROM Tourist__c
                WHERE Name LIKE :fuzzyname];
        return recordsTourists;
    }
    
    public static List<Tourist__c> getNotRelatedTourist(Id tripId) {
        List<Tourist__c> result = [
            SELECT Name,
                    Birthdate__c,
                    Age__c,
                    Email__c,
                    Upcoming_Flights_Count__c
            FROM Tourist__c
            WHERE Id NOT IN (SELECT Tourist__C 
                             FROM Flight__c 
                             WHERE Tourist__c != :tripId
                            )
            ORDER BY Upcoming_Flights_Count__c ASC NULLS FIRST
            LIMIT 10
        ];
        return result;
    }
}