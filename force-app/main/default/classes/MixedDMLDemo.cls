public class MixedDMLDemo {
    public static void createAccount(){
        Account acc = new Account();
        acc.Name = 'test';
        INSERT acc;
        updateUser();
    }
    
    @future
    public static void updateUser(){
        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        List<User> userList = new List<user>();
        userList = [SELECT Id FROM User WHERE UserName = 'guna@guna.com'];
        for(User user : userList){
            user.Title = 'Salesforce Test';
            user.ProfileId = p.Id;
        }
        update userList;
    }
}