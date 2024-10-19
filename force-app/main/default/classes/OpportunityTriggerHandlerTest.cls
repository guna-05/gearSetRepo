@isTest
public class OpportunityTriggerHandlerTest {
	
    @isTest
    static void findDuplicateTest(){
        Id recordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Mobile Record Type').getRecordTypeId();
        List<Account> accountList = TestUtils.createAccountRecords('Test Account', 5, true);
        List<Opportunity> oppList = TestUtils.createOpportunityRecord('Test Opp', 50, false);
        Integer count = 0;
        for(Opportunity opp : oppList){
            if(count <= 5){
                opp.Name = 'Test';
            }
            opp.AccountId = accountList.get(Math.mod(count,5)).Id;
            opp.RecordTypeId = recordTypeId;
            count++;
        }
        try{
            INSERT oppList;
        }
        catch(exception e){
            Application_Message__mdt mc = Application_Message__mdt.getInstance('OpportunityError');
            Boolean result = e.getMessage().contains(mc.Message__c);
            System.assertEquals(true, result);
        }
    }
    
    //We need to test if the "Default Account Test" record is exist inside the database or not
    //If we write a normal test class, test class is not able to get any data which is present inside the database
    //we need to test the record inside the database for which we need to get the data from database in the test class
    //to get the data from database we will use seeAllData = true
    @isTest(seeAllData = true)
    static void updateDefaultAccountTest(){
        List<Account> accountList = new List<Account>();
        accountList = [SELECT Id FROM Account WHERE Name = 'Default Account Test' LIMIT 1];
        System.assertEquals(1, accountList.size());
        List<Opportunity> oppList = TestUtils.createOpportunityRecord('Tests Opportunity', 5, true);
        List<Opportunity> tempList = [SELECT Id 
                                      FROM Opportunity 
                                      WHERE AccountId =:accountList.get(0).Id
                                      AND Name LIKE 'Tests Opportunity%'
                                      AND CreatedDate = TODAY];
        System.assertEquals(5, tempList.size());
    }
}