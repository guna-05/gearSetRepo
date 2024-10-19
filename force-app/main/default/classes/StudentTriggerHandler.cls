public class StudentTriggerHandler {
    
    public static void updateCollegeName(List<Student__c> newList, Map<Id, Student__c> oldMap){
        Set<Id> clgIdSet = new Set<Id>();
        
        for(Student__c stu : newList){
           clgIdSet.add(stu.College__c);
        }
        
        if(clgIdSet.size()>0){
            Map<Id,String> clgIdToNameMap = new Map<Id,String>();
            for(College__c clg : [SELECT Id, Name FROM College__c WHERE Id IN: clgIdSet]){
                clgIdToNameMap.put(clg.Id,clg.Name);
            }  
            
            for(Student__c stu : newList){
                stu.College_Name__c = clgIdToNameMap.get(stu.College__c);
            }
        }
    }
    
    public static void updateStudentCount3(List<Student__c> newList, Map<Id, Student__c> oldMap){
        Set<Id> collegeIdSet = new Set<Id>();
        Map<Id, Integer> collegeToStudentCountMap = new Map<Id, Integer>();
        if(newList != Null){
            for(Student__c stud : newList){
                if(oldMap == Null || (stud.College__c != oldMap.get(stud.Id).College__c)){
                    if(stud.College__c != Null){
                        collegeIdSet.add(stud.College__c);
                        collegeToStudentCountMap.put(stud.College__c, 0);
                    }
                    if(oldMap != Null && oldMap.get(stud.Id).College__c != Null){
                        collegeIdSet.add(oldMap.get(stud.Id).College__c);
                        collegeToStudentCountMap.put(oldMap.get(stud.Id).College__c,0);
                    }
                }
            }
        }
        else{
            for(Id studentId : oldMap.keySet()){
                if(oldMap.get(studentId).College__c != Null){
                    collegeIdSet.add(oldMap.get(studentId).College__c);
                    collegeToStudentCountMap.put(oldMap.get(studentId).College__c,0);
                }
            }
        }
        
        if(collegeIdSet.size() > 0){
            for(AggregateResult aggr : [SELECT College__c, COUNT(Id) 
                                        FROM Student__c
                                        WHERE College__c IN :collegeIdSet
                                        GROUP BY College__c]){
                                            String collegeId = String.valueOf(aggr.get('College__c'));
                                            Integer totalCount = Integer.valueOf(aggr.get('expr0'));
                                            collegeToStudentCountMap.put(collegeId, totalCount);
                
            }
            List<College__c> collegeList = new List<College__c>();
            for(ID collegeId : collegeToStudentCountMap.keySet()){
                College__c clg = new College__c();
                clg.id = collegeId;
                clg.Student_Count__c = collegeToStudentCountMap.get(collegeId);
                collegeList.add(clg);
            }
            if(collegeList.size()>0){
                UPDATE collegeList;
            }
        }
    }
    
    public static void updateStudentCount2(List<Student__c> newList, Map<Id, Student__c> oldMap){
        Set<Id> collegeIdSet = new Set<Id>();
        Map<Id, Integer> collegeToStudentCountMap = new Map<Id, Integer>();
        if(newList != Null){
            for(Student__c stud : newList){
                if(oldMap == Null || (stud.College__c != oldMap.get(stud.Id).College__c)){
                    if(stud.College__c != Null){
                        collegeIdSet.add(stud.College__c);
                        //collegeToStudentCountMap.put(stud.College__c, 0);
                    }
                    if(oldMap != Null && oldMap.get(stud.Id).College__c != Null){
                        collegeIdSet.add(oldMap.get(stud.Id).College__c);
                        //collegeToStudentCountMap.put(oldMap.get(stud.Id).College__c,0);
                    }
                }
            }
        }
        else{
            for(Id studentId : oldMap.keySet()){
                if(oldMap.get(studentId).College__c != Null){
                    collegeIdSet.add(oldMap.get(studentId).College__c);
                    //collegeToStudentCountMap.put(oldMap.get(studentId).College__c,0);
                }
            }
        }
        if(collegeIdSet.size() > 0){
            for(College__c college : [SELECT Id, (SELECT Id FROM Students__r)
                    FROM College__c
                    WHERE Id IN :collegeIdSet]){
                        collegeToStudentCountMap.put(college.Id, college.Students__r.size());
                
            }
            List<College__c> collegeList = new List<College__c>();
            for(ID collegeId : collegeToStudentCountMap.keySet()){
                College__c clg = new College__c();
                clg.id = collegeId;
                clg.Student_Count__c = collegeToStudentCountMap.get(collegeId);
                collegeList.add(clg);
            }
            if(collegeList.size()>0){
                UPDATE collegeList;
            }
        }
    }
    
    public static void updateStudentCount1(List<Student__c> newList, Map<Id, Student__c> oldMap){
        
        Set<Id> collegeIdSet = new Set<Id>();
        Map<Id, Integer> collegeToStudentCountMap = new Map<Id, Integer>();
        if(newList != Null){
            for(Student__c stud : newList){
                if(oldMap == Null || (stud.College__c != oldMap.get(stud.Id).College__c)){
                    if(stud.College__c != Null){
                        collegeIdSet.add(stud.College__c);
                        collegeToStudentCountMap.put(stud.College__c, 0);
                    }
                    if(oldMap != Null && oldMap.get(stud.Id).College__c != Null){
                        collegeIdSet.add(oldMap.get(stud.Id).College__c);
                        collegeToStudentCountMap.put(oldMap.get(stud.Id).College__c,0);
                    }
                }
            }
        }
        else{
            for(Id studentId : oldMap.keySet()){
                if(oldMap.get(studentId).College__c != Null){
                    collegeIdSet.add(oldMap.get(studentId).College__c);
                    collegeToStudentCountMap.put(oldMap.get(studentId).College__c,0);
                }
            }
        }
        
        
        if(collegeIdSet.size() > 0){
            for(Student__c stud : [SELECT Id, College__c
                                   FROM Student__c
                                   WHERE College__c IN :collegeIdSet]){
                                       /*if(!collegeToStudentCountMap.containsKey(stud.College__c)){
                                           collegeToStudentCountMap.put(stud.College__c, 0);
                                       }*/
                                       Integer temp = collegeToStudentCountMap.get(stud.College__c);
                                       temp = temp + 1;
                                       collegeToStudentCountMap.put(stud.College__c, temp);
                                       //System.debug(collegeToStudentCountMap);
                                   }
            List<College__c> collegeList = new List<College__c>();
            for(ID collegeId : collegeToStudentCountMap.keySet()){
                College__c clg = new College__c();
                clg.id = collegeId;
                clg.Student_Count__c = collegeToStudentCountMap.get(collegeId);
                collegeList.add(clg);
            }
            if(collegeList.size()>0){
                UPDATE collegeList;
            }
        }
    }
    
    
    
}