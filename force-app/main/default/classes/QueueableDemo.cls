public class QueueableDemo {
    public void demo(){
        Account acc = new Account();
        acc.Name = 'Test';
        INSERT acc;
        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        List<User> userList = new List<user>();
        userList = [SELECT Id FROM User WHERE UserName = 'guna@guna.com'];
        QueueableJob1 obj = new QueueableJob1(userList, p.Id);
        System.enqueueJob(obj);
    }
}