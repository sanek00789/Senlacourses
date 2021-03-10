public class FlightTriggerWithHandler {
    public static void onBeforeInsert (List<Flight__c> newFlight) {
        
        for (Flight__c flight : newFlight) {
            Tourist__c touristToFlight = [
                SELECT Age__c 
                FROM Tourist__c 
                WHERE id =: flight.Tourist__c];
            Trip__c tripToFlight = [
                SELECT Minimum_Age__c, Start_Date__c 
                FROM Trip__c 
                WHERE id =: flight.Trip__c];
            if (touristToFlight.Age__c < tripToFlight.Minimum_Age__c) {
                flight.addError('Insufficient minimum age');
            }
            if (flight.Status__c == 'Past' && date.today() > tripToFlight.Start_Date__c) {
                flight.addError('The flight has already departed');
                flight.Status__c.addError('The flight has already departed');
            }
        }        
    }
}

/*(TODAY() > Trip__r.Start_Date__c) || ISPICKVAL(Status__c , "Past")
The flight has already departed
Tourist__r.Age__c < Trip__r.Minimum_Age__c
Insufficient minimum age*/