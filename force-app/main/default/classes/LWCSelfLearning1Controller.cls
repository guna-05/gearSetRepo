public class LWCSelfLearning1Controller {
    
    @AuraEnabled(cacheable = true)
    public static List<College__c> getCollegeList(){
        return [SELECT Id, Name 
                FROM College__c
                WHERE Active__c = true
                AND Student_Count__c > 0
                ORDER BY Name];
    }

    @AuraEnabled(cacheable = true)
    public static List<Student__c> getStudentList(String selectedCollegeId){
        return [SELECT Id, First_Name__c, Last_Name__c
                FROM Student__c
                WHERE College__c = :selectedCollegeId
                ORDER BY First_Name__c];
    }

    @AuraEnabled(cacheable = true)
    public static List<Mark__c> getAllMarks(String studentId){
        return [SELECT Id, Biology__c, 	Chemistry__c, Civics__c, Economics__c, History__c, Maths__c, Physics__c, Total_Mark__c
                FROM Mark__c
                WHERE Student__c = :studentId
                ORDER BY Total_Mark__c DESC];
    }

}