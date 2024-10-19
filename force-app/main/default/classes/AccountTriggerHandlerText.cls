@isTest
public class AccountTriggerHandlerText {
    
    @isTest
    static void updateOpportunityTest(){
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Demo Profile'];
        List<User> userList = new List<User>();
        string uid ='ng';
        User u = new User(Alias = uid, Email= uid + '@testdomain.com', 
                          EmailEncodingKey='UTF-8', LastName='Guna', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = profile.Id, 
                          TimeZoneSidKey='America/New_York', UserName= uid + '@testdomain.com');      
        userList.add(u);
        insert userList;
        Account acc = new Account();
        acc.Name = 'My Test';
        INSERT acc;
        System.runAs(userList.get(0)){
            Account accTemp = new Account();
            accTemp.Id = acc.Id;
            accTemp.Active__c = 'No';
            update accTemp;
            String tempName = acc.Name+ '- Default Opp';
            List<Opportunity> oppList = [SELECT Id, Name, StageName 
                                        FROM Opportunity 
                                        WHERE Name = :tempName];
            System.assertEquals('Closed Lost', oppList.get(0).StageName);
        }
    }
    
    static testmethod void createDefaultOpportunityTest(){
        Account acc = new Account();
        acc.Name = 'My Test';
        INSERT acc;
        String tempName = acc.Name + '- Default Opp';
        List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE Name = :tempName];
        System.assertEquals(1, oppList.size());
    }

}