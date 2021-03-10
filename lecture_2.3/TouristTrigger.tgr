trigger TouristTrigger on Tourist__c (before insert) {
    TouristService.markDuplicates(Trigger.new);
}