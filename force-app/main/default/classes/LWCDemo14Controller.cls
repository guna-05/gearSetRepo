public class LWCDemo14Controller {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(){
        return [SELECT Id, Name
                FROM Account 
                ORDER BY CreatedDate
                LIMIT 15];
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(String selectedAccountId){
        //System.assert(false,'Adding an error');
        return [SELECT Id, Name, Email
                FROM Contact
                WHERE AccountId = :selectedAccountId];
    }
}