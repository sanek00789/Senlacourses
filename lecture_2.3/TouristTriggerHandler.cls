public class TouristTriggerHandler {
    
    public static Boolean wasExecuted = true;
    
    public static void onAfterUpdate (Map<Id, Tourist__c> touristMap) {        
        if (touristMap != null || !touristMap.isEmpty()) {            
            Set<Id> idNewTourist = touristMap.keySet();
            List<Flight__c> flights = FlightManager.getByStatus(idNewTourist);        
            List<Flight__c> listFlightToUpdate = new List<Flight__c> ();
            
            for (Flight__c flight : flights) {            
                if(flight.Tourist__r.Active__c != true) { 
                    flight.Status__c = 'Declined';
                    listFlightToUpdate.add(flight);                       
                }                    
            }     
            update listFlightToUpdate;   
        }    
    }
    
    public static void onBeforeInsert (List<Tourist__c> newTourists) {
        TouristService.markDuplicates(newTourists);
    }
}