public class LWCDemo26WrapperController {
    
    @AuraEnabled
    public static String getAccountDetailsWithRelatedData(String accountId){
        List<Account> accountList = new List<Account>();
        List<Contact> contactList = new List<Contact>();
        List<Opportunity> opportunityList = new List<Opportunity>();

        accountList = [SELECT Id, Name, Active__c, Industry
                        FROM Account
                        WHERE Id =: accountId];
        
        contactList = [SELECT Id, FirstName, LastName, Name, Email, Title
                        FROM Contact
                        WHERE AccountId =: accountId];
        
        opportunityList = [SELECT Id, Name, StageName, Amount, CloseDate                            
                            FROM Opportunity
                            WHERE AccountId =: accountId];
        
        AccountWrapper accWrap = new AccountWrapper();
        accWrap.accountId = accountList.get(0).Id;
        accWrap.accountName = accountList.get(0).Name;
        accWrap.accountActive = accountList.get(0).Active__c;
        //accWrap.conList = contactList;
        List<ContactWrapper> conWrapperList = new List<ContactWrapper>();
        for(Contact tempcon : contactList){
            conWrapperList.add(new ContactWrapper(tempcon));
        }
        List<OpportunityWrapper> oppWrapList = new List<OpportunityWrapper>();
        for(Opportunity tempOpp : opportunityList){
            oppWrapList.add(new OpportunityWrapper(tempOpp));
        }
        accWrap.conList = conWrapperList;
        accWrap.oppList = oppWrapList;
        String data = JSON.serialize(accWrap);
        return data;
    }

    @AuraEnabled
    public static String updateContactRecords(String jsonString){
        AccountWrapper accWrap = new AccountWrapper();
        accWrap = (AccountWrapper)JSON.deserialize(jsonString, AccountWrapper.class);
        List<ContactWrapper> conWrapperList = new List<ContactWrapper>();
        conWrapperList = accWrap.conList;
        List<Contact> updateContactList = new List<Contact>();
        for(ContactWrapper conWrap : conWrapperList){
            updateContactList.add(conWrap.contactObject); //Extracting contact record from wrapper list
        }
        //updateContactList = accWrap.conList;
        if(updateContactList.size()>0){
            UPSERT updateContactList;
        }
        String jsonData = getAccountDetailsWithRelatedData(accWrap.accountId);
        return jsonData;
        //return null;
    }

    @AuraEnabled
    public static String updateOpportunityRecords(String jsonString){
        AccountWrapper accWrap = new AccountWrapper();
        accWrap = (AccountWrapper)JSON.deserialize(jsonString, AccountWrapper.class);
        List<OpportunityWrapper> oppWrapperList = new List<OpportunityWrapper>();
        oppWrapperList = accWrap.oppList;
        List<Opportunity> updateOpportunityList = new List<Opportunity>();
        for(OpportunityWrapper oppWrap : oppWrapperList){
            updateOpportunityList.add(oppWrap.opportunityObject);
        }
        if(updateOpportunityList.size()>0){
            UPSERT updateOpportunityList;
        }
        String jsonData = getAccountDetailsWithRelatedData(accWrap.accountId);
        return jsonData;
    }

    @AuraEnabled
    public static String updateSingleContact(String jsonString){
        ContactWrapper conWrap = new ContactWrapper();
        conWrap = (ContactWrapper)JSON.deserialize(jsonString, ContactWrapper.class);
        UPSERT conWrap.contactObject;
        Contact con = [SELECT Id, FirstName, LastName, Name, Email, Title
                        FROM Contact
                        WHERE Id =: conWrap.contactObject.Id];
        ContactWrapper tempConWrapper = new ContactWrapper(con);        
        String jsonData = JSON.serialize(tempConWrapper);
        return jsonData;
    }

    @AuraEnabled
    public static string updateSingleOpportunity(String jsonString){
        OpportunityWrapper oppWrapper = new OpportunityWrapper();
        System.debug('apex '+jsonString);
        oppWrapper = (OpportunityWrapper)JSON.deserialize(jsonString, OpportunityWrapper.class);
        UPSERT oppWrapper.opportunityObject;
        String jsonData = JSON.serialize(oppWrapper);
        return jsonData;
    }

    public Class AccountWrapper{
        String accountId;
        String accountName;
        String accountActive;

        List<ContactWrapper> conList;
        List<OpportunityWrapper> oppList;

        public AccountWrapper(){
            conList = new List<ContactWrapper>();
            oppList = new List<OpportunityWrapper>();
        }
    }

    public class ContactWrapper{
        Boolean isEditable;
        Boolean isSelected;
        Contact contactObject;

        public ContactWrapper(){
            isEditable = false;
            isSelected = false;
            contactObject = new Contact();
        }

        public ContactWrapper(Contact con){
            isEditable = false;
            isSelected = false;
            contactObject = con;
        }
    }

    public class OpportunityWrapper{
        Boolean isEditable;
        Boolean isSelected;
        Opportunity opportunityObject;

        public OpportunityWrapper(){
            isEditable = false;
            isSelected = false;
            opportunityObject = new Opportunity();
        }

        public OpportunityWrapper(Opportunity opp){
            isEditable = false;
            isSelected = false;
            opportunityObject = opp;
        }
    }
    
}