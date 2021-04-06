public class FlightDeleteBatch implements Database.Batchable<sObject>, Database.Stateful {
    private Map <Tourist__c, Integer> countFlights = new Map<Tourist__c, Integer>();
	 
    private Date dateLimit = System.today() - 30;
    private final String query = 'SELECT Name, ' +
        + '(SELECT CreatedDate, Status__c FROM Flights__r WHERE Status__c =: constans.FLIGHT_STATUS_DECLINED OR CreatedDate <: dateLimit) FROM Tourist__c';    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }
    
    public void execute (Database.BatchableContext BC, List<Tourist__c> touristsWithFlights) {
        if (touristsWithFlights == null || touristsWithFlights.isEmpty()) return;
        List <Flight__c> flightsToDelete = new List<Flight__c>();
        
        for (Tourist__c tourist :touristsWithFlights) {
            if (tourist.Flights__r.size() != 0) {
                flightsToDelete.addAll(tourist.Flights__r);
                countFlights.put(tourist, tourist.Flights__r.size());                
            }
        }            
        delete flightsToDelete;
    }
    
    public void finish (Database.BatchableContext BC) {
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();         
        List<Tourist_data__mdt> emails = TouristCustomDataManager.getEmail(); 
        String textEmail = '';
        
        for (Tourist__c tourist : countFlights.keyset()) {  
            String Name = tourist.Name;
            Integer countFlights = (countFlights.get(tourist));
            //textEmail += amount + ' flights were deletet from tourist ' + tourist.Name + '. \n';
            textEmail += + '<a href='+ URL.getSalesforceBaseUrl().toExternalForm()+'/'+ tourist.Id +'> ' + Name + '</a> - removed ' + countFlights + ' flights. <br/>';
        }
        
        for (Tourist_data__mdt touristData : emails) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List<String> emailAddress = new List<String>();
            emailAddress.add(touristData.Email__c);
            mail.setSubject('Delete Flights');
            mail.setToAddresses(emailAddress);        	
            mail.setHtmlBody('Hello<br/>' + textEmail);
            mails.add(mail);
        }        
        Messaging.sendEmail(mails);  
    }    
}