public class TouristService {
    
    public static void markDuplicates(List<Tourist__c> newTourists) {       
        List<Tourist__c> recordsTourists = TouristManager.getTouristsByEmail(newTourists);        
        Set<Tourist__c> revisedTourist = new Set<Tourist__c> {};
        List<Tourist__c> insertList = new List<Tourist__c> {};
            if (recordsTourists.isEmpty() != true) {
                
                for (Tourist__c a : newTourists) {
                    String nameTourist = a.Name;
                    String email = a.Email__c;
                    
                    for (Tourist__c b : recordsTourists) {
                        if (b.Name == nameTourist && b.Email__c == email) {
                            a.IsDuplicate__c = true;
                            revisedTourist.add(a);
                        } 
                    }
                }        
                insertList.addall(revisedTourist);                        
                insert insertList;        
            } else {                
                insert newTourists;
            } 
    }
}