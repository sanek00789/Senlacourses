public class TouristManager {
    public static List<Tourist__c> Query1 (String varName) {
        List<Tourist__c> ListQuery1 = [Select Name, Age__c From Tourist__c WHERE Name = :varName];
        System.debug(ListQuery1);
        return ListQuery1;
    }
    
    public static List<Tourist__c> Query2 (Integer varAge) {
        List<Tourist__c> ListQuery2 = [Select Name, Age__c From Tourist__c WHERE Age__c =: varAge];
        System.debug(ListQuery2);
        return ListQuery2;
    }
    
    public static List<Flight__c> Query3 (Integer varStartYear) {
        List<Flight__c> ListQuery3 = 
            [SELECT Tourist__r.Name, Tourist__r.Age__c 
             FROM Flight__c 
             WHERE CALENDAR_YEAR(Trip__r.Start_Date__c) =: varStartYear];
        System.debug(ListQuery3);
        return ListQuery3;
    }
    
    public static void Query4 () {
        List<Tourist__c> ListQuery4 = [SELECT Name, Age__c, (SELECT Trip__r.Start_Date__c, Name FROM Flights__r)  
                                       FROM Tourist__c];        
    }
    
    public static void Query5 () {
        List<Tourist__c> ListQuery5 = [SELECT Name, Age__c, (SELECT Trip__r.Start_Date__c, Name FROM Flights__r)  
                                       FROM Tourist__c];
    }
}