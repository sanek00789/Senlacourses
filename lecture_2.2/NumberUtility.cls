public class NumberUtility {
    
    public static List<Integer> sampleNumber (Integer inputNum) {
        List<Integer> results = new List<Integer> ();
        
        for (Integer i = 2; i < inputNum; i++) {
            Integer k = 0;
            for (Integer j = 1; j <= i; j++) {
                if (math.mod(i, j) == 0) {
                    k++;
                }
            }
            if (k == 2) {
                results.add(i);
            }
        }        
        return results;
    }
    
    public static List<Integer> numbersFibanachi (Integer inputNum) {
        List<Integer> listResults = new List<Integer> ();
        Integer i = 1;
        Integer sum = 0;
        Integer sum1 = 0;
        while (i < inputNum) {
            if (sum < inputNum) {
                listResults.add(sum);
            }
            sum = sum1 + i;
            sum1 = i;
            i = sum;
        }        
        return listResults;
    }
    
    public static Boolean palindrom (Integer numToCheck) {        
        String varText = numToCheck.format();
        String revNumber = varText.reverse();
        if (varText == revNumber) {            
            return true;
        } else {            
            return false;
        }        
    }
}