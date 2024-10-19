public class QueueableJob1 implements Queueable {
    public List<User> userList;
    public Id profileId;
    
    public QueueableJob1(){
        userList = new List<User>();
        profileId = Null;
    }
    
    public QueueableJob1(List<User> tempUserList, Id tempProfileId){
        userList = tempUserList;
        profileId = tempProfileId;
    }
    public void execute(System.QueueableContext qc){
        for(User user : userList){
            user.Title = 'Salesforce Test';
            user.ProfileId = profileId;
        }
        UPDATE userList;
        QueueableJob2 obj = new QueueableJob2();
        System.enqueueJob(obj);
    }
}