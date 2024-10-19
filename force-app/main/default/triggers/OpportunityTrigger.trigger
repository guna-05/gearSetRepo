trigger OpportunityTrigger on Opportunity (before insert, after insert, before update, after update, after delete, after undelete) {
    /*if(Constants.runOpportunityTrigger){
        System.assert(false, 'Opp Trigger is Executing');
    }
    
    for(Opportunity opp : Trigger.New){
        System.debug('Opportunity Name: ' + opp.Name);
        System.debug('Opportiunity Id: ' + opp.Id);
        System.debug('Account Id: ' + opp.AccountId);
        System.debug('Account Name: ' + opp.account.Name);
        System.debug('Account Id: ' + opp.account.Id);
        System.debug('Record Type Id: ' + opp.RecordTypeId);
        List<Account> acc = [SELECT Id, Name FROM Account WHERE Id = :opp.AccountId LIMIT 1];
        System.debug('Acc Id: ' + acc.get(0).Id + 'Acc Name: '+ acc.get(0).Name);
    }*/
    
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        OpportunityTriggerHandler.findDuplicate(Trigger.New, Trigger.OldMap);
    }
    
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete)){
        //System.debug('Upodate trigger handler');
        OpportunityTriggerHandler.dealsOwnedByUser(Trigger.New, Trigger.OldMap);
    }
    
    if(Trigger.isBefore && Trigger.isInsert ){
        OpportunityTriggerHandler.updateDefaultAccount(Trigger.New, Trigger.OldMap);
    }
}