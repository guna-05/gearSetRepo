public class PracticeDataTable2 {
    
    @AuraEnabled(cacheable = true)
    public static List<Student__c> getStudentRecords(String clgId){
        return [SELECT Id, First_Name__c, Last_Name__c 
                FROM Student__c
                WHERE College__c =: clgId];
    }
}