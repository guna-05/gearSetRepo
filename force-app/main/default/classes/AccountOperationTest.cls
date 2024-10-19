@isTest
public class AccountOperationTest {
    
    static testmethod void updateActiveFieldOfAccountTest(){
        //Contact and Account which need to be setup as part of data
        //contact last name should start with demo and contact should have associated account as well
        
        Account acc = new Account();
        acc.Name = 'Test Account';
        INSERT acc;
        Contact con = new Contact();
        con.LastName = 'Demo34';
        con.AccountId = acc.Id;
        INSERT con;
        AccountOperation accOpr = new AccountOperation();
        accOpr.updateActiveFieldOfAccount();
        //to get the updated data in case of SF Object we need to requery everything
        List<Account> accList = [SELECT Id, Active__c FROM Account WHERE Id =:acc.Id];
        System.assertEquals('No', accList.get(0).Active__c);
    }

}