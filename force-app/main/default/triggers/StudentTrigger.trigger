trigger StudentTrigger on Student__c (before insert, after insert, before update, after update, after delete, after undelete) {
    
    /*if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete)){
        StudentTriggerHandler.updateStudentCount1(Trigger.New, Trigger.OldMap);
    }*/
    
    /*if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete)){
        StudentTriggerHandler.updateStudentCount2(Trigger.New, Trigger.OldMap);
    }*/
    
    if(Trigger.isBefore && Trigger.isInsert){
        StudentTriggerHandler.updateCollegeName(Trigger.New, Trigger.OldMap);
    }
    
    /*if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete)){
        StudentTriggerHandler.updateStudentCount3(Trigger.New, Trigger.OldMap);
    }*/

}