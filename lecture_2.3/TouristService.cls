public class TouristService {
    
    public static void markDuplicates(List<Tourist__c> newTourists) {          
        if (newTourists == null || newTourists.isEmpty()) return;
        Set<String> names =  new Set<String> ();
        Set<String> emails = new Set<String> ();
        
        for (Tourist__c tour : newTourists) {
            names.add(tour.Name);
            emails.add(tour.Email__c);
        }        
        List<Tourist__c> recordsTourists = TouristManager.getEmail(names, emails);        
        List<Tourist__c> revisedTourists = new List<Tourist__c> ();
        List<Tourist__c> insertList = new List<Tourist__c> ();
        if (!recordsTourists.isEmpty()) {
            
            for (Tourist__c newTourist : newTourists) {
                
                for (Tourist__c tourist : recordsTourists) {
                    Boolean isSameName = (tourist.Name == newTourist.Name);
                    Boolean isSameEmail = (tourist.Email__c == newTourist.Email__c);
                    if (isSameName && isSameEmail) {
                        newTourist.IsDuplicate__c = true;
                        revisedTourists.add(newTourist);
                    } 
                }
            }        
            insertList.addall(revisedTourists); 
		} 
    }
    
    @future
    public static void markDuplicates(Set<Id> touristIds) {          
        if (touristIds == null || touristIds.isEmpty()) return;
        List<Tourist__c> newTourists = TouristManager.getByIds(touristIds);
        Set<String> names =  new Set<String> ();
        Set<String> emails = new Set<String> ();
        
        for (Tourist__c tour : newTourists) {
            names.add(tour.Name);
            emails.add(tour.Email__c);
        }        
        List<Tourist__c> recordsTourists = TouristManager.getEmail(names, emails);        
        List<Tourist__c> revisedTourists = new List<Tourist__c> ();
        List<Tourist__c> insertList = new List<Tourist__c> ();
        if (!recordsTourists.isEmpty()) {
            
            for (Tourist__c newTourist : newTourists) {
                
                for (Tourist__c tourist : recordsTourists) {
                    Boolean isSameName = (tourist.Name == newTourist.Name);
                    Boolean isSameEmail = (tourist.Email__c == newTourist.Email__c);
                    if (isSameName && isSameEmail) {
                        newTourist.IsDuplicate__c = true;
                        revisedTourists.add(newTourist);
                    } 
                }
            }        
            insertList.addall(revisedTourists); 
        }
    }
}