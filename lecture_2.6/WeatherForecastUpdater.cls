public with sharing class WeatherForecastUpdater {
    public static void updateForecasts() {
        List<Space_Point__c> coordinates = WeatherForecastManager.getLatitudeAndLongitude();
        
        for(Space_Point__c coordinate : coordinates) {            
            WeatherForecastService.getForecasts(coordinate.Latitude__c, coordinate.Longitude__c);
        }
    }
}