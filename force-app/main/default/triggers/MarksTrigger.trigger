trigger MarksTrigger on Mark__c (after insert, after update, after delete, after undelete) {
    MarksHandler.topperOfCollege(Trigger.New, Trigger.OldMap);
}