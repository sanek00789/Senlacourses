public class TouristService {
    public static void markDuplicates(List<Tourist__c> newTourists) {       
        List<Tourist__c> insertList = new List<Tourist__c> {};
        Set<Tourist__c> revisedTourist = new Set<Tourist__c> {};    
        List<Tourist__c> recordsTourists = [SELECT Name, Email__c, IsDuplicate__c FROM Tourist__c];
                
        for (Tourist__c a : newTourists) {
            String nameTourist = a.Name;
            String email = a.Email__c;
            
            for (Tourist__c b : recordsTourists) {
                if (b.Name == nameTourist && b.Email__c == email) {
                    a.IsDuplicate__c = true; 
                } else {
                    revisedTourist.add(a);                    
                }
            }
        }        
        insertList.addall(revisedTourist);        
        insert insertList;        
        // check 
        List<Tourist__c> finalRecordsTourists = [SELECT Name, Email__c, IsDuplicate__c FROM Tourist__c];
        System.debug(finalRecordsTourists);       
    }
}