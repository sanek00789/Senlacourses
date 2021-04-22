public class WeatherForecastManager {
    public static List<Space_Point__c> getLatitudeAndLongitude() {
        List<Space_Point__c> spasePoints = [
            SELECT Latitude__c, 
            		Longitude__c 
            FROM Space_Point__c LIMIT 1
        ];        
        return spasePoints;		
    }
}