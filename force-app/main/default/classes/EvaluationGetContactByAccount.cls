public class EvaluationGetContactByAccount {
    
    @AuraEnabled
    public static List<Contact> getContactDetails(String accountId){
        return [SELECT Id, Name, Title
                FROM Contact 
                WHERE AccountId =: accountId];
    }
}