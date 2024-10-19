@isTest
public class SumTest {
    @isTest static void testSumFunctionality(){
        Sum obj = new Sum(5,10);
        obj.doSum();
        System.assertEquals(15, obj.result);
    }
    
    @isTest static void testSumFunctionalityNegative(){
        Sum obj = new Sum(5,-10);
        obj.doSum();
        System.assertEquals(-5, obj.result);
    }
}