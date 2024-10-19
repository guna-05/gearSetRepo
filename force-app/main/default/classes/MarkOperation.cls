public class MarkOperation {
    public Mark__c getMarkDetails(ID markId){
       return [SELECT Id, Name, Student__c, Student__r.First_Name__c, Student__r.Last_Name__c 
               FROM Mark__c
               WHERE Id =: markId];
    }
    
    public Mark__c getMarkDetails2(ID markId){
        return [SELECT Id, Name, Student__c, Student__r.First_Name__c, 
                       Student__r.Last_Name__c, Student__r.College__c, 
                       Student__r.College__r.Name
               FROM Mark__c
               WHERE Id =: markId];
    }

}