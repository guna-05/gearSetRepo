@isTest
public class CollegeTriggerTest {
    
    static testmethod void testInsert(){
        List<College__c> clgList = new List<College__c>();
        clgList = TestUtils.createCollegeRecord('TestCollege', 5, 'OH', true);
    }
    
    static testmethod void testUpdate(){
        List<College__c> clgList = new List<College__c>();
        clgList = TestUtils.createCollegeRecord('TestCollege', 5, 'OH', true);
        for(College__c college : clgList){
            college.State__c = 'TX';
        }
        //Total SOQL before this statement execution will be 60
        Test.startTest();
        //After executing above all Governor limit will be 0
        UPDATE clgList;
        //Total SOQL before this statement execution will be 50
        Test.stopTest();
        //After executing above all Governor limit will again be 60 - original limit before start test was called
        
    }
    
    static testmethod void testDelete(){
        List<College__c> clgList = new List<College__c>();
        clgList = TestUtils.createCollegeRecord('TestCollege', 5, 'OH', true);
        for(College__c college : clgList){
            college.State__c = 'TX';
        }
        //Total SOQL before this statement execution will be 60
        Test.startTest();
        //After executing above all Governor limit will be 0
        DELETE clgList;
        //Total SOQL before this statement execution will be 45
        Test.stopTest();
        //After executing above all Governor limit will again be 0
    }

}