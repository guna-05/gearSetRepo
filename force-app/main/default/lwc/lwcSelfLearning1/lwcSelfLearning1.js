import { LightningElement, wire } from 'lwc';
import getCollegeList from '@salesforce/apex/LWCSelfLearning1Controller.getCollegeList';
import getStudentList from '@salesforce/apex/LWCSelfLearning1Controller.getStudentList';
import getAllMarks from '@salesforce/apex/LWCSelfLearning1Controller.getAllMarks';
import allresources from '@salesforce/resourceUrl/allresources';
import { loadScript } from "lightning/platformResourceLoader";
import { backgroundColor, borderColor, columns, labels } from 'c/lwcSelfLearningJavascript';

export default class LwcSelfLearning1 extends LightningElement {

    clgValue = 'none';
    stuValue = 'none';
    clgOption = [];
    stuOption = [];
    markData = [];
    tempcondition = false;
    dataset = [];
    count = 0;
    

    columns = columns();
    
    @wire(getCollegeList)wiredColleges({error, data}){
        if(data){
            let tempclgArray = [];
            const temp = {label: 'None', value:'None'};
            tempclgArray.push(temp);
            for(var clg of data){
                var tempval = {label: clg.Name, value: clg.Id};
                tempclgArray.push(tempval);
            }
            this.clgOption = tempclgArray;
        }
        else if(error){
            alert(error);
        }
    }

    handleCollegeChange(event){
        this.clgValue = event.target.value;
        //alert(this.clgValue);
    }

    @wire(getStudentList, {selectedCollegeId : '$clgValue'})wiredStudents({error, data}){
        if(data){
            let tempstuArray = [];
            const stutemp = {label: 'None', value:'None'};
            tempstuArray.push(stutemp);
            for(var stu of data){
                var tempName = stu.First_Name__c + ' ' + stu.Last_Name__c;
                var tempval = {label: tempName, value: stu.Id};
                tempstuArray.push(tempval);
            }
            this.stuOption = tempstuArray;
        }
        else if(error){
            alert(error);
        }
    }

    handleStudentChange(event){
        this.stuValue = event.target.value;
        this.tempcondition = true;
        //alert(this.stuValue);
    }

    @wire(getAllMarks, {studentId : '$stuValue'})wiredMarks({error, data}){
        if(data){
            var tempdataArray = [];
            for(var mark of data){
                this.count = this.count+1;
                var tempdata = {Biology: mark.Biology__c,
                     Chemistry: mark.Chemistry__c,
                     Civics: mark.Civics__c,
                     Economics: mark.Economics__c,
                     History: mark.History__c,
                     Maths: mark.Maths__c,
                     Physics: mark.Physics__c,
                     Total: mark.Total_Mark__c
                };
                tempdataArray.push(tempdata);
                //tempdata.push(tempdataset);
                //alert(JSON.stringify(this.dataset));
            }
            this.markData = tempdataArray;
            
        }else if(error){
            alert(error);
        }
    }
    
}