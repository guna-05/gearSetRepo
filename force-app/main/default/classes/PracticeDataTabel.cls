public class PracticeDataTabel {
    
    @AuraEnabled(cacheable = true)
    public static List<Opportunity> getAccountOpportunities(String accountId){
        List<Opportunity> oppList = new List<Opportunity>();
        oppList = [SELECT Id, Name, StageName, Amount
                    FROM Opportunity
                    WHERE AccountId =: accountId];
        return oppList;
    }

    @AuraEnabled
    public static List<Contact> getContactDetails(String accountId){
        List<Contact> conList = new List<Contact>();
        conList = [SELECT Id, Name, Email, Phone, Title
                   FROM Contact
                   WHERE AccountId =: accountId];
        return conList;
    }
}