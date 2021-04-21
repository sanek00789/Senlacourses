@RestResource(urlMapping='/Tourist/*')
global with sharing class TouristRestService {
    
    @HttpGet
    global static void getTourists() {        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;        
        Map<String,String> paramsMap = req.params;
        String fuzzyname = '%' + paramsMap.get('fuzzyname') + '%';
        String ageString = paramsMap.get('age');
        Integer age;	
        try {
            age = Integer.valueOf(ageString);
        }
        catch (TypeException te) {
            System.debug(te.getMessage()); 
        }        
        if (String.isBlank(paramsMap.get('fuzzyname'))) {
            res.responseBody = Blob.valueOf(Constans.THE_NAME_MUST_BE_NOT_EMPRY);
            res.statusCode = 404;
            return;            
        }  
        if (String.isNotBlank(ageString) && !ageString.isNumeric()) {
            res.responseBody = Blob.valueOf(Constans.THE_AGE_MUST_BE_A_NUMBER);
            res.statusCode = 404;
            return;
        } else {
            List<Tourist__c> tourists = [
                SELECT Name, 
                Age__c 
                FROM Tourist__c
                WHERE Name LIKE :fuzzyname OR Age__c =:age
            ];    
            res.statusCode = 200;
            res.responseBody = Blob.valueOf(JSON.serializePretty(tourists));
        }         
    }
    
    @HttpPost
    global static void createTourist(String name, Date birthdate, String email) {
        RestResponse res = RestContext.response;
        Tourist__c newTourist = new Tourist__c();
        newTourist.Name = name;
        newTourist.Birthdate__c = birthdate;
        newTourist.Email__c = email;
        List<Tourist__c> tourists = TouristManager.getByNameAndEmail(name, email);
        if(!tourists.isEmpty()){
            res.statusCode = 409;
        } else {
            insert newTourist;    
        }
    }
}