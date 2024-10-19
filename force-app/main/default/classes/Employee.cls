public class Employee {
    //instance variable - A variable which holds a value at an Instance
    //public Interger empNo -> Statement will give access to empNo Variable outside this class
    Integer empNo;
    String empName;
    Double empSalary;
    
    //Default/Without Parameter constructor
    public Employee(){
        //System.debug('Object Created!!!');
        this.empNo = 0;
        this.empName = 'dummy';
        this.empSalary = 0.0;
        count++;
    }
    
    //Parameterized Construtor
    public Employee(Integer empNo, String empName, Double empSalary){
        this.empNo = empNo;
        this.empName = empName;
        this.empSalary = empSalary;
        count++;
    }
    
    //Static Variable
    public static Integer count;
    
    //Static Block to initiallise Static Variable
    static{
        count = 0;
        //empNo = 1; - throws error
    }
    
    public static Integer getCount(){
        //count++;
        return count;
    }
    
    //we created setter and getter method to restrict accessing the variable outside this class
    //this is an additional reference variable created to invoke the method 
    public void setEmpNo(Integer empNo){
        this.empNo = empNo;
    }
    public Integer getEmpNo(){
        return this.empNo;
    }
    public void setEmpName(String empName){
        this.empName = empName;
    }
    public String getEmpName(){
        return this.empName;
    }
    public void setEmpSalary(Double empSalary){
        this.empSalary = empSalary;
    }
    public Double getEmpSalary(){
        return this.empSalary;
    }
    
    public void printData(){
        System.debug('No of Employees: '+ count);
        System.debug('Emp No: '+ this.empNo);
        System.debug('Emp Name:'+ this.empName);
        System.debug('Emp Salary:'+ this.empSalary);
    }
    
    public void increaseCount(){
        count++;
    }
    
    //Method Overloading
    public void increaseSalary(){
        this.empSalary = this.empSalary + (this.empSalary * 0.05);
    }
    
    public void increaseSalary(Double increaseSalaryPercent){
        this.empSalary = this.empSalary + (this.empSalary * increaseSalaryPercent / 100);
    }

}