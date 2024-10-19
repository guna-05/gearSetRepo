public class TestUtils {
    
    public static List<Opportunity> createOpportunityRecord(String name, Integer count, Boolean isInsert){
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=1; i<=count; i++){
            Opportunity opp = new Opportunity();
            opp.Name = name + i;
            opp.CloseDate = Date.today() + 30;
            opp.StageName = 'Prospecting';
            oppList.add(opp);
        }
        if(isInsert){
            INSERT oppList;
        }
        return oppList;
    }
    
    public static List<Account> createAccountRecords(String name,Integer count,Boolean isInsert){
        List<Account> accountList=new List<Account>();
        for(Integer i=0;i<=count;i++){
            Account acc=new Account();
            acc.Name= name+i;
            acc.Rating='Hot';
            accountList.add(acc);
        }
        if(isInsert){
            insert accountList;
        }
        return accountList;
    }
    
    public static List<College__c> createCollegeRecord(String name, Integer count, String state, Boolean isInsert){
        List<College__c> clgList = new List<College__c>();
        for(Integer i=1; i<=count; i++ ){
            College__c clg = new College__c();
            clg.Name = name + ' ' + i;
            clg.Active__c = true;
            clg.State__c = state;
            clgList.add(clg);
        }
        
        if(isInsert){
            INSERT clgList;
        }
        //System.assert(false,clgList.size());
        return clgList;
    }
    
    public static List<Student__c> createStudentRecord(String fName, String lName, Integer count, Boolean isInsert){
        List<Student__c> studentList = new List<Student__c>();
        
        for(Integer i=1; i<=count; i++){
            Student__c stu = new Student__c();
            stu.First_Name__c = fName+i;
            stu.Last_Name__c = lName+i;
            stu.Phone__c = '123456789'+i;
            stu.Email__c = stu.First_Name__c+'.'+stu.Last_Name__c+'@abc.com';
            studentList.add(stu);
        }
        if(isInsert){
            INSERT studentList;
        }
        return studentList;
        
    }

}