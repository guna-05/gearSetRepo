public class LWCDemo25DataTabelController {
    
    @AuraEnabled(cacheable = true)
    public static List<Contact> getContactList() {
        return [SELECT Id, Name, Phone, Title, AccountId, Account.Name 
                FROM Contact 
                LIMIT 10];
    }
}