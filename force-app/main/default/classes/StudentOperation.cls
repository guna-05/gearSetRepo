public class StudentOperation {
    public Student__c getStudentMarks(ID studentId){
        return [SELECT First_Name__c, Last_Name__c, (SELECT Name, History__c, Civics__c FROM Marks__r)
                FROM Student__c
                WHERE Id =: studentId];
    }

}