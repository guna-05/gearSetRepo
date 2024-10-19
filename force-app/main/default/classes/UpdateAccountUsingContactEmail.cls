public class UpdateAccountUsingContactEmail {
    
    public static void updateAccount(){
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact con : [SELECT Id, Name, Email, AccountId
                           FROM Contact
                           WHERE Email LIKE '%@mtx.com']){
            accountIdSet.add(con.AccountId);
        }
        
        List<Account> accList = new List<Account>();
        for(Id id : accountIdSet){
            Account acc = new Account();
            acc.Id = id;
            acc.Active__c = 'Yes';
            accList.add(acc);
        }
        UPDATE accList;
    }

}