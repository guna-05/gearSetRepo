import { LightningElement, wire } from 'lwc';
import getStudentRecords from '@salesforce/apex/PracticeDataTable2.getStudentRecords';

const coloumns = [
    {label: 'First Name', fieldName: 'First_Name__c', type:'text'},
    {label: 'Last Name', fieldName: 'Last_Name__c', type:'text'}
]

export default class PracticeDataTabel2 extends LightningElement {
    collegeId;
    studentData = [];
    columns = coloumns;

    handleOnChange(event){
        this.collegeId = event.target.value;
    }

    @wire(getStudentRecords, {clgId : '$collegeId'})wiredStudent({error,data}){
        if(data){
            this.studentData = data;
        }
    }

}