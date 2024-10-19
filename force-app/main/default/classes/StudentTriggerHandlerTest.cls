@isTest
public class StudentTriggerHandlerTest {
    
    @testsetup
    static void setup(){
        List<College__c> clgList = new List<College__c>();
        List<Student__c> studentList = new List<Student__c>();
        clgList = TestUtils.createCollegeRecord('TestCollege', 5, 'OH', true);
        studentList = TestUtils.createStudentRecord('fName', 'lName', 50, false);
        for(Integer i=0; i<50; i++){
            studentList.get(i).College__c = clgList.get(Math.mod(i,5)).Id; 
            studentList.get(i).Student_State__c = clgList.get(Math.mod(i,5)).State__c;
            
        }
        INSERT studentList;
    }
    
    static testmethod void testStudentUnDetele(){
        List<College__c> clgList = [SELECT Id, Name FROM College__c];
        List<Student__c> studentList = [SELECT Id, Name FROM Student__c];
        List<Student__c> tempStudentList = [SELECT Id 
                                            FROM Student__c 
                                            WHERE College__c =:clgList.get(0).Id];
        delete tempStudentList;
        List<Student__c> undeleteStudentList = new List<Student__c>();
        undeleteStudentList = [SELECT Id 
                               FROM Student__c 
                               WHERE College__c =:clgList.get(0).Id 
                               AND IsDeleted = true 
                               LIMIT 7 ALL ROWS];
        undelete undeleteStudentList;
        List<College__c> collegeList = [SELECT Id, Student_Count__c FROM College__c WHERE Id IN :clgList];
        System.assertEquals(5, collegeList.size());
        for(Integer i=0; i<5; i++){
            if(i == 0){
                System.assertEquals(7, collegeList.get(i).Student_Count__c);
            }
            else{
                System.assertEquals(10, collegeList.get(i).Student_Count__c);
            }
        }
    }
    
    static testmethod void testStudentDetele(){
        List<College__c> clgList = [SELECT Id, Name FROM College__c];
        List<Student__c> studentList = [SELECT Id, Name FROM Student__c];
        List<Student__c> tempStudentList = [SELECT Id FROM Student__c WHERE College__c =:clgList.get(0).Id
                                            OR College__c =:clgList.get(1).Id];
        Test.startTest();
        delete tempStudentList;
        Test.stopTest();
        List<College__c> tempCollegeList = new List<College__c>();
        List<College__c> collegeList = [SELECT Id, Student_Count__c FROM College__c WHERE Id IN :clgList];
        System.assertEquals(5, collegeList.size());
        for(Integer i=0; i<5; i++){
            if(i == 0 || i ==1){
                System.assertEquals(0, collegeList.get(i).Student_Count__c);
            }
            else{
                System.assertEquals(10, collegeList.get(i).Student_Count__c);
            }
        }
        
    }
    
    static testmethod void testStudentUpdate(){
        List<College__c> clgList = [SELECT Id, Name, State__c FROM College__c];
        List<Student__c> studentList = [SELECT Id, Name FROM Student__c];
        for(Integer i=0; i<50; i++){
            studentList.get(i).College__c = clgList.get(0).Id;
            studentList.get(i).Student_State__c = clgList.get(0).State__c;
        }
        Test.startTest();
        UPDATE studentList;
        Test.stopTest();
        List<College__c> tempClgList = [SELECT Id, Student_Count__c FROM College__c WHERE Id IN :clgList];
        System.assertEquals(5,tempclgList.size());
        for(Integer i=0;i<5;i++){
            if(i==0){
                System.assertEquals(50,tempclgList.get(i).Student_Count__c);
            }
            else{
                System.assertEquals(0,tempclgList.get(i).Student_Count__c);
            }
        }
        
    }
    
    static testmethod void testStudentInsert(){
        List<College__c> clgList = [SELECT Id, Name FROM College__c];
        List<Student__c> studentList = [SELECT Id, Name FROM Student__c];
        List<College__c> collegeList = [SELECT Id, Student_Count__c FROM College__c WHERE Id IN :clgList];
        System.assertEquals(5, collegeList.size());
        for(College__c clg : collegeList){
            System.assertEquals(10, clg.Student_Count__c);
        }
    }

}