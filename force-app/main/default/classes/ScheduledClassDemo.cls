public class ScheduledClassDemo implements Schedulable {
    
    public String industryValue;
    public ScheduledClassDemo(){
        industryValue = 'All';
    }
    public ScheduledClassDemo(String tempIndustryValue){
        industryValue = tempIndustryValue;
    }
    public void execute(SchedulableContext sc){
        //whatever code we write here will be executed at defined time
        Database.executeBatch(new AccountUpdateBatch(industryValue),50);
    }
    
    // 0 15 * * * ?
    // /*
    // ScheduledClassDemo obj = new ScheduledClassDemo('Technology');
    // System.schedule('Schedule Job 1', '0 15 * * * ?', obj);
    // System.schedule('Schedule Job 2', '0 30 * * * ?', obj);
    // System.schedule('Schedule Job 3', '0 45 * * * ?', obj);
    // System.schedule('Schedule Job 4', '0 0 * * * ?', obj);
    // */
}