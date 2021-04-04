public class FlightDeleteBatch implements Database.Batchable<sObject>{
    public Map <String, Integer> countFlights = new Map<String, Integer>();    
    private Date dateLimit = System.today() - 30;
    private final String query = 'SELECT Name, (SELECT CreatedDate, Status__c FROM Flights__r WHERE Status__c =: constans.FLIGHT_STATUS_DECLINED OR CreatedDate <: dateLimit) FROM Tourist__c';
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }
    
    public void execute (Database.BatchableContext BC, List<Tourist__c> touristsWithFlights) {
        if (touristsWithFlights == null || touristsWithFlights.isEmpty()) return;
        List <Flight__c> flightsToDelete = new List<Flight__c>();
        
        for (Tourist__c tourist :touristsWithFlights) {
            if (tourist.Flights__r.size() != 0) {
                flightsToDelete.addAll(tourist.Flights__r);
                countFlights.put(tourist.Name, tourist.Flights__r.size());
            }
        }            
        delete flightsToDelete;
    }
    
    public void finish (Database.BatchableContext BC) {
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();         
        List<Tourist_data__mdt> data = [SELECT Email__c FROM Tourist_data__mdt]; 
        String textEmail = '';
        
        for (String touristName : countFlights.keyset()) {  
            String Name = touristName;
            Integer countFlights = (countFlights.get(touristName));
            textEmail += countFlights + ' flights were deletet from tourist ' + Name + '. \n';
        }
        
        for (Tourist_data__mdt touristData : data) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List<String> emailAddress = new List<String>();
            emailAddress.add(touristData.Email__c);
            mail.setSubject('Delete Tourist');
            mail.setToAddresses(emailAddress);        	
            mail.setHtmlBody(textEmail);
            mails.add(mail);
        }        
        Messaging.sendEmail(mails);  
    }    
}