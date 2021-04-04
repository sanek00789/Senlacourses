public class FlightDeleteSchedulable implements Schedulable {
    
    public void execute (SchedulableContext SC) {
        FlightDeleteBatch myBatch = new FlightDeleteBatch();
        Id batchId = Database.executeBatch(myBatch);
    }
}