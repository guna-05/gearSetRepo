public class FutureMethodDemo {
	//Query in loop is just for demo to understand concept, Never Write Query in loop
    public static void demo(){
        for(Integer i=0; i<=70; i++){
            List<Account> accList = [SELECT Id FROM Account LIMIT 1];
            
        }
        moreDemo();
    }
    
    @future
    public static void moreDemo(){
        for(Integer i=0; i<=80; i++){
            List<Account> accList = [SELECT Id FROM Account LIMIT 1];
        }
    }
}