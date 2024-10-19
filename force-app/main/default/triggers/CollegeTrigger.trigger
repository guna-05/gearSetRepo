trigger CollegeTrigger on College__c (before insert, before update, before delete, after undelete) {
    //This is not a best practise tp write query in loop 
    if(Trigger.IsInsert){
        for(Integer i=1; i<=60; i++){
            List<Account> accountList = [SELECT Id FROM Account LIMIT 1];
        }
    }
    
    if(Trigger.IsUpdate){
        for(Integer i=1; i<=50; i++){
            List<Account> accountList = [SELECT Id FROM Account LIMIT 1];
        }
    }
    
    if(Trigger.IsDelete){
        for(Integer i=1; i<=45; i++){
            List<Account> accountList = [SELECT Id FROM Account LIMIT 1];
        }
    }

}