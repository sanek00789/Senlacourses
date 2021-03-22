public class ExceptionsPlayground {
    
    public class CustomException extends Exception {}
    
    public static void generateCustomException (Integer a, Integer b) {
        try {
            if (a == b) throw new CustomException('Сannot be equal');
        } catch(CustomException e) {
            throw e; 
            
        }        
    }
    
    public static void generateRegularException() {
        Trip__c tripTest = new Trip__c ();
        tripTest = [
            SELECT Name 
            FROM Trip__c
        ];      
    }
    
    public static void handleExceptions() {
        try {            
            ExceptionsPlayground.generateRegularException();
        }
        catch (QueryException qe) {
            System.debug(qe.getMessage());
            System.debug('Сaught a standard exception');
        }
        try {            
            ExceptionsPlayground.generateCustomException(5, 5);
        }
        catch (CustomException ce) {
            
            System.debug('Сaught a custom exception');
        }
        
        System.debug('the program ended successfully');
    }
}