public class TouristService {
    
    public static void markDuplicates(List<Tourist__c> newTourists) {       
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