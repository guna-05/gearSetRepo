public class MarksHandler {
    
    public static void topperOfCollege(List<Mark__c> newList, Map<Id, Mark__c> oldMap){
        Set<Id> studentIdSet = new Set<Id>();
        Set<ID> collegeIdSet = new Set<Id>();
        if(newList != Null){
            for(Mark__c mark : newList){
                if(oldMap == Null || mark.Total_Mark__c != oldMap.get(mark.Id).Total_Mark__c){
                    studentIdSet.add(mark.Student__c);
                }
            }
        }
        else{
            for(Id markId : oldMap.keySet()){
                studentIdSet.add(oldMap.get(markId).Student__c);
            }
        }
        
        if(studentIdSet.size()>0){
            for(Student__c collegeId : [SELECT College__c FROM Student__c WHERE Id IN :studentIdSet]){
                collegeIdSet.add(collegeId.College__c);
            }
        }
        System.debug(studentIdSet);
        System.debug(collegeIdSet);
        
        Map<Id, Mark__c> markToCollegeMap = new Map<Id, Mark__c>();
        for(Mark__c mark  : [SELECT Total_Mark__c, Maths__c, Student__r.First_Name__c, Student__r.Last_Name__c, Student__r.College__c
                             FROM Mark__c 
                             WHERE Student__r.College__c IN :collegeIdSet 
                             ORDER BY Total_Mark__c DESC]){
                                 if(!markToCollegeMap.containsKey(mark.Student__r.College__c)){
                                     markToCollegeMap.put(mark.Student__r.College__c, mark);
                                 }
                                 else if(markToCollegeMap.containsKey(mark.Student__r.College__c) && 
                                         (mark.Total_Mark__c == markToCollegeMap.get(mark.Student__r.College__c).Total_Mark__c) && 
                                         (mark.Maths__c > markToCollegeMap.get(mark.Student__r.College__c).Maths__c)){
                                             markToCollegeMap.put(mark.Student__r.College__c, mark);
                                         }
                                 
                             }
        
        System.debug(markToCollegeMap);
        List<College__c> collegeList = new List<College__c>();
        for(ID clgId : markToCollegeMap.keySet()){
            String name = markToCollegeMap.get(clgId).Student__r.First_Name__c + ' ' + markToCollegeMap.get(clgId).Student__r.Last_Name__c;
            College__c college = new College__c();
            college.Id = clgId;
            college.Topper_Student_Name__c = name;
            collegeList.add(college);
        }
        
        UPDATE collegeList;
        
    }
}