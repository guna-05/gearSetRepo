public class AccountUpdateBatch implements Database.Batchable<sObject>, Database.Stateful {
    
    public Integer count;
    public List<String> errorString;
    public String industryValue;
    public AccountUpdateBatch(){
        count = 0;
        errorString = new List<String>();
    }
    public AccountUpdateBatch(String tempIndustryValue){
        industryValue = tempIndustryValue;
        count = 0;
        errorString = new List<String>();
    }
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = '';
        query = 'SELECT Id, Name, Industry, Active__c, Description FROM Account';
        if(industryValue != 'All'){
            query = query + ' WHERE Industry =:industryValue';
        }
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc, list<Account> accountList){
        Integer tempCount = 0;
        for(Account acc : accountList){
            count++;
            if(tempCount < 3){
                acc.Name = '';
            }
            tempCount++;
            acc.Description = 'Technology Industry Records';
            if(acc.Industry == Null){
                if(count < 10){
                    acc.Industry = 'Technology';
                }else{
                    acc.Industry = 'Banking';
                }
            }
            
        }
        Database.SaveResult[] srList = Database.update(accountList, false);
        for(Database.SaveResult sr : srList){
            if(!sr.isSuccess()){
                for(Database.Error err : sr.getErrors()){
                    String error = sr.getId()+ '---' + err.getMessage();
                    errorString.add(error);
                }
            }
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('>>>>>> Total Records Processed are '+count);
        for(String error : errorString){
            System.debug('---'+error);
        }
        
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] { 'narendra.uf159@gmail.com' };
        message.subject = 'Records Failed during Batch Processing';
        String htmlString = '<table border = \'1\'><tr><th>Record Id</th><th>Error Message</th></tr>';
        for(String error : errorString){
            htmlString = htmlString + '<tr>';
            List<String> tempError = error.split('---');
            for(String temp : tempError){
                htmlString = htmlString + '<td>' + temp + '</td>';
            }
            htmlString = htmlString + '</tr>';
        }
        htmlString = htmlString + '</table>';
        message.setHtmlBody(htmlString);
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
    }
}