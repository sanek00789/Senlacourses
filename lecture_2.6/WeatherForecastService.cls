public class WeatherForecastService {
    public class WeatherForecastException extends Exception {}
    
    public static Map<Date, Decimal> getForecasts(Decimal latitude, Decimal longitude) {        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Map<Date, Decimal> dateAndTemperature = new Map<Date, Decimal>();
        String url =
            'https://api.weatherbit.io/v2.0/forecast/daily?lang=ru' +
            '&key=' + Constans.KEY_WEATHERBIT +
            '&lat=' + latitude +
            '&lon=' + longitude;
        request.setMethod('GET');
        request.setEndpoint(url);        
        try {
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                List<Object> days = (List<Object>) results.get('data');
                                
                for (Object day :days) {                    
                    Map<String, Object> dailyData = (Map<String, Object>) day;
                    dateAndTemperature.put(date.valueOf(string.valueOf(dailyData.get('datetime'))),(decimal) (dailyData.get('temp')));                
                }
            } else {
                throw new WeatherForecastException(Constans.ERROR_RECEIVING_REQUEST);
            }
        } catch (WeatherForecastException wfe) {
            System.debug(wfe.getMessage());
        } catch (CalloutException ce) {
            System.debug(ce.getMessage());
        }        
        return dateAndTemperature;
    }
}