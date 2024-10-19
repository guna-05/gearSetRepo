trigger UserTrigger on User (after update) {
    
    Set<ID> userId = new Set<ID>();
    for(User usr : Trigger.New){
        if(usr.Favorite_Color__c != Trigger.OldMap.get(usr.Id).Favorite_Color__c){
            userId.add(usr.Id);
        }
    }
    
    List<Account> accountList = new List<Account>();
    if(userId.size() > 0 ){
        
        for(Account acc : [SELECT Id, Favorite_Color__c, OwnerId FROM Account WHERE OwnerId IN :userId]){
      	
            acc.Favorite_Color__c = Trigger.NewMap.get(acc.OwnerId).Favorite_Color__c;
            accountList.add(acc);
        }
        //System.assert(false, 'This is a Test Message');
    }
    UPDATE accountList;
    

}