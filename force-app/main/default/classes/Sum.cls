public class Sum {
    
    public Integer num1;
    public Integer num2;
    public Integer result;
    public Sum(Integer a, Integer b){
        num1 = a;
        num2 = b;
        result = 0;
    }
    
    public void doSum(){
        result = num1 + num2;
        System.debug('Sum = '+ result);
    }

}