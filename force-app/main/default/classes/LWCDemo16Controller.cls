public class LWCDemo16Controller {
    
    @AuraEnabled(cacheable = true)
    public static List<Account> getAccountList(){
        return [SELECT Id, Name, Active__c
                FROM Account
                WHERE Industry = 'Technology'
                ORDER BY Name
                LIMIT 20];
    }

    @AuraEnabled
    public static void updateAccountList(){
        List<Account> accountList = new List<Account>();
        accountList = [SELECT Id, Name, Active__c
                        FROM Account
                        WHERE Industry = 'Technology'
                        ORDER BY Name
                        LIMIT 20];
        for(Account acc : accountList){
            acc.Active__c = 'Yes';
        }
        update accountList;
    }
}