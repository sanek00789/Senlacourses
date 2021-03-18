public class ExceptionHw {
    
    public class CustomException extends Exception {}
    
    public static void customException (Integer a, Integer b) {
        try {
            if (a == b) throw new CustomException('Сannot be equal');
        } catch(CustomException e) {
            throw e;
            
        }        
    }
    
    public static void standartException() {
        Trip__c tripTest = new Trip__c ();
        tripTest = [
            SELECT Name 
            FROM Trip__c
        ];      
    }
    
    public static void withoutException() {
        try {            
            ExceptionHw.standartException();
        }
        catch (QueryException qe) {
            System.debug(qe.getMessage());
            System.debug('Сaught a standard exception');
        }
        try {            
            ExceptionHw.customException(5, 5);
        }
        catch (customException ce) {
            
            System.debug('Сaught a custom exception');
        }
        
        System.debug('the program ended successfully');
    }
}