public class QueueableJob2 Implements Queueable {
	public List<User> userList;
    public QueueableJob2(){
        userList = new List<User>();
    }
    
    public QueueableJob2(List<User> tempUserList){
        userList = tempUserList;
    }
    
    public void execute(System.QueueableContext qc){
        for(User user : userList){
            user.Title = 'Updated By Queueable Job 2';
        }
        UPDATE userList;
        Database.executeBatch(new AccountUpdateBatch('Technology'),50);
    }
}