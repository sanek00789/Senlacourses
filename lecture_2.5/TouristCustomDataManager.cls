public class TouristCustomDataManager {
    
    public static List<Tourist_data__mdt> getEmail () {
        List<Tourist_data__mdt> data = [
            SELECT Email__c 
            FROM Tourist_data__mdt
        ];
        return data;
    }
}