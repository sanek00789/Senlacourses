@isTest
public class FlightDeleteBatchTest {
    @testSetup
    static void testSetup () {
        List<Trip__c> trips = TestDataFactory.tripsData(5);
        List<Tourist__c> tourists = TestDataFactory.touristsData(5);        
        List<Flight__c> newFlights = new List<Flight__c>();        
        
        for (Trip__c trip : trips) {
            newFlights.add(
                new Flight__c(Trip__c = trip.Id, 
                              Tourist__c = tourists.get(0).Id, 
                              Status__c = 'Declined')
            );
        }        
        insert newFlights;
    }
    
    @isTest
    static void testFlightDeleteBatch () {
        Test.startTest();
        FlightDeleteBatch flightDeleteBatch = new FlightDeleteBatch();
        Database.executeBatch(flightDeleteBatch);
        List<Flight__c> flights = [SELECT Id FROM Flight__c];
        System.debug(flights);
        
        Test.stopTest();
        Integer beforeInvocations = Limits.getEmailInvocations();
        System.assertEquals(0, beforeInvocations);
    }    
}