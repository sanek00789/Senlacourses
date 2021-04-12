public class FlightDeleteBatch implements Database.Batchable<sObject>, Database.Stateful {
    private Map <Id, Integer> countFlights = new Map<Id, Integer>();
    private Set<Id> flightIds = new Set<Id>();    
    private Date dateLimit = System.today() - Constans.FLIGHT_DELETION_PERIOD_DAYS;
    private String status = Constans.FLIGHT_STATUS_DECLINED;
    private final String query = 'SELECT CreatedDate, ' + 
        'Status__c, ' + 
        'Tourist__r.Name, ' +
        'Tourist__r.Id ' +
        'FROM Flight__c ' +
        'WHERE CreatedDate <=: dateLimit AND Status__c =: status';    
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    public void execute (Database.BatchableContext bc, List<Flight__c> flightsToDelete) {        
        List<Database.DeleteResult> delResultFlights = Database.delete(flightsToDelete, false);
        
        for (Database.DeleteResult delresultflight :delResultFlights) {
            if(delresultflight.isSuccess()) {
                flightIds.add(delresultflight.getId());
            }
        }
        
        for (Flight__c flight :flightsToDelete) {
            for(Id flightId :flightIds) {
                if (flight.Id == flightId) {
                    if(countFlights.containsKey(flight.Tourist__c)) {
                        Integer count = countFlights.get(flight.Tourist__c) + 1;
                        countFlights.put(flight.Tourist__c, count);
                    } else {
                        countFlights.put(flight.Tourist__c, 1);
                    }
                }                
            }
        }
    }    
    public void finish (Database.BatchableContext bc) {
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();         
        List<Email__mdt> emails = TouristCustomDataManager.getEmail(); 
        List<Tourist__c> tourists = TouristManager.getByIds(countFlights.keyset());
        String textEmail = '';
        
        for (Tourist__c tourist : tourists) {  
            String Name = tourist.Name;
            Integer countFlights = (countFlights.get(tourist.Id));            
            textEmail += + '<a href='+ URL.getSalesforceBaseUrl().toExternalForm()+'/'+ tourist.Id +'> ' + Name + '</a> - removed ' + countFlights + ' flights. <br/>';
        }
        
        for (Email__mdt email : emails) {            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List<String> emailAddress = new List<String>();
            emailAddress.add(email.Email_to_inform_you_about_the_removal_of__c);
            mail.setSubject('Email to inform you about the removal of');
            mail.setToAddresses(emailAddress);        	
            mail.setHtmlBody('Hello!<br/>' + 'The following entries have been removed from the organization:<br/>' + textEmail);
            mails.add(mail);
        }        
        Messaging.sendEmail(mails);  
    }    
}