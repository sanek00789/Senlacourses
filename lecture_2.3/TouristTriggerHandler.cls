public class TouristTriggerHandler {
    public static Boolean flag;
    
    public static void onAfterUpdate (Map<id, Tourist__c> newTourists) {        
        List<Tourist__c> listNewTourist = newTourists.values();
        List<Flight__c> listFlights = [
            SELECT Tourist__c, Status__c FROM Flight__c
        ];
        List<Tourist__c> listTourists = [
            SELECT Id, Active__c 
            FROM Tourist__c
        ];
        List<Flight__c> listFlightToUpdate = new List<Flight__c> ();
        
        for (Tourist__c newtour : listNewTourist) {
            for (Tourist__c tourist : listTourists) {
                if(newtour.id == tourist.id) {
                    for (Flight__c fli : listFlights) {
                        if (tourist.id == fli.Tourist__c && tourist.Active__c != true) {
                            fli.Status__c = 'Declined';
                            listFlightToUpdate.add(fli);
                        }
                    }
                    
                }     
                
            }
            
        }
        update listFlightToUpdate;
    }
}