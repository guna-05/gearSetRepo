public class AccountOperation {
    public ID createAccountRecord(){
        Account account = new Account(Name = 'New Account #1');
        insert account;
        return account.Id;
    }
    
    public ID createAccountRecord2(String name, String type, String industry, String rating){
        Account account = new Account(Name=name, Type=type, Industry=industry, Rating=rating);
        insert account;
        return account.id;
    }
    
    //Create multiple contact records for an Account Record
    public void createContactRecord(){
        Account account = new Account(Name = 'New Account # 3');
        insert account;
        ID newAccId = account.Id;
        //Contact contact;
        for(Integer i = 1; i <= 2; i++){
            Contact contact = new Contact(FirstName = 'Name'+i, LastName = 'Name'+i);
            contact.AccountId = newAccId;
            INSERT contact;
            
        }
    }
    
    public void getAllAccountDetails(){
        List<Account> accountList = [SELECT Id, Name, Type, Industry, Rating 
                                           FROM Account];
        for(Account account : accountList){
            System.debug('Account Details');
            System.debug('Id: '+ account.Id);
            System.debug('Name: ' + account.Name);
            System.debug('Type: '+ account.Type);
            System.debug('Industry: '+ account.Industry);
            System.debug('Rating: '+ account.Rating);
        }
    }
    
    public List<Account> getAllAccountDetails2(){
        List<Account> accountList = [SELECT Id, Name, Type, Industry, Rating 
                                           FROM Account];
        return accountList;
    }
    
    //Use BIND Variable: Variable which holds values to use in WHERE Clause of SOQL
    //Use : (Colon) as a prefix to this variable 'Id = :accountId'
    public Account getAccountDetails(ID accountId){
        Account account = [SELECT Id, Name, Industry, Type, Rating
                          FROM Account
                          WHERE Id = :accountId];
        return account;
    }
    
    //Write a method using parameter to update Rating field of all the Banking Account to Hot.
    public List<Account> updateBankingAccountDetails(String type){
        List<Account> accList = [SELECT Id, Name, Industry, Type, Rating 
                                 FROM Account
                                 WHERE Industry = :type];
        return accList;
    }
    
    //Alternate way to update
    public void updateBankingRecords(String industry){
        List<Account> accountList = [SELECT Id, Name, Industry, Type, Rating
                                     FROM Account
                                     WHERE Industry = :industry];
        for(Account acc : accountList){
            acc.Rating = 'Hot';
        }
        UPDATE accountList;
    }
    
    //Write a method to Insert and Update a record
    public void insertAndUpdateRecord(){
        List<Account> accountList = new List<Account>();
        accountList.add(new Account(Name = 'Test Account # 1'));
        accountList.add(new Account(Name = 'Test Account # 2'));
        System.debug('Account List Size: '+ accountList.size());
        Account account = [SELECT Id, Name, Rating
                           FROM Account
                           WHERE Id = '001ak00000Nd406AAB'];
        account.Rating = 'Warm';
        account.Type = 'Prospect';
        
        accountList.add(account);
        System.debug('Account List Size: '+ accountList.size());
        UPSERT accountList;
    }
    
    //Write a method to pass AccountId as a Paramete and retrieve all its contacts
    public List<Contact> getAllContactsofAccount(ID accountId){
        List<Contact> contactList = [SELECT Id, Name, Title, Email, Phone, Account.Name, Account.Rating
                                     FROM Contact
                                     WHERE AccountId = :accountId];
        return contactList;
    }
    
    public Account getAccountContacts(ID accountId){
        Account account = [SELECT Name, (SELECT Name, Email, Phone FROM Contacts) FROM Account WHERE Id =: accountId];
        return account;
    }
    
    public ID createSingleRecord(String accName){
        Account acc = new Account(Name = accName);
        INSERT acc;
        return acc.Id;
    }
    
    //Governor Limit : DML - 150
    public void createMultipleRecords(){
        Account acc = new Account();
        List<Account> accountList = new List<Account>();
        for(Integer i=1; i<=151; i++ ){
            acc = new Account(Name = 'Account '+ i);   //As DML Statement execution is exceeding more than 150 time the method execution thorws exception 
            accountList.add(acc);
            //INSERT acc;
        }
        INSERT accountList;
    }
    
    public static void polyTest(sObject obj){
        if(obj instanceof Account){
            System.debug('Account Details: '+ obj);
        }
        else{
            System.debug('Contact Details: '+ obj);
        }
    }
    
    public void updateActiveFieldOfAccount(){
        Map<ID, Account> mapAccountId = new Map<ID, Account>();
        for(Contact contact : [SELECT Id, Name, AccountId 
                				FROM Contact 
               			 		WHERE LastName Like 'Demo%'
               					AND AccountId != null]){
            
            if(!mapAccountId.containsKey(contact.AccountId)){
                Account account = new Account();
            	account.Id = contact.AccountId;
            	account.Active__c = 'No';
                mapAccountId.put(contact.AccountId, account);                      
            }  
        }
        List<Account> accountList = mapAccountId.values();
        UPDATE accountList;
        //Below statement also works
        //UPDATE mapAccountId.values();
    }
    
    //Write a method to Store Account and All contacts of that account
    //Write a query on account, get all contacts and store them
    public void getAccountAndContacts(){
        Map<Id, List<Contact>> accountContactMap = new Map<Id, List<Contact>>();
        for(Account account : [SELECT Id, Name, (SELECT Id, Name, Title FROM Contacts)
                FROM Account]){
                    if(!accountContactMap.containsKey(account.Id)){
                        accountContactMap.put(account.Id, account.Contacts);
                    }
        }
        //System.debug(accountContactMap);
        //As we have limitation on console to display the debug statement,
        //we need to iterate on to map 
        for(ID accountId : accountContactMap.keySet()){
            Integer count = 0;
            System.debug('Contact for Account Id: ' + accountId);
            for(Contact contact : accountContactMap.get(accountId)){
                count++;
                System.debug(contact.Name);
            }
            System.debug('Total Contacts of Account: '+ count);
        }
    }
    
    
    //Write a query on contact, get all accounts and store them
    public void getContactAccount(){
        Map<ID, List<Contact>> contactAccountMap = new Map<ID, List<Contact>>();
        for(Contact contact : [SELECT Name, Title, Account.Name 
                FROM Contact]){
                    
                    if(!contactAccountMap.containsKey(contact.AccountId)){
                        contactAccountMap.put(contact.AccountId, new List<Contact>{contact});
                    }
                    else{
                        contactAccountMap.get(contact.AccountId).add(contact);
                    }
                    for(ID accountId : contactAccountMap.keySet()){
            				Integer count = 0;
            				System.debug('Contact for Account Id: ' + accountId);
            				for(Contact contact1 : contactAccountMap.get(accountId)){
                						count++;
                						System.debug(contact1.Name);
            		}
            		System.debug('Total Contacts of Account: '+ count);
        }
        }
    }

}