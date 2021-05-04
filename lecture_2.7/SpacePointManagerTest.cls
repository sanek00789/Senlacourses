@isTest
public class SpacePointManagerTest {
    @isTest
    static void TestGetLatitudeAndLongitude() {
        Space_Point__c spacePoint = new Space_Point__c();
        insert spacePoint;
        List<Space_Point__c> spasePoints = SpacePointManager.getLatitudeAndLongitude();        
        System.assertEquals(1, spasePoints.size());
    }
}