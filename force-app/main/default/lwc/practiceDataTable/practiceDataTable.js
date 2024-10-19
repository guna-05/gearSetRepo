import { LightningElement, wire } from 'lwc';
import getAccountOpportunities from '@salesforce/apex/PracticeDataTabel.getAccountOpportunities';
import getContactDetails from '@salesforce/apex/PracticeDataTabel.getContactDetails';
const coloumns = [
    {label : 'Name', fieldName: 'Name', type:'text'},
    {label : 'Stage', fieldName: 'StageName', type:'text'},
    {label : 'Amount', fieldName: 'Amount', type:'number'}
]

export default class PracticeDataTable extends LightningElement {
    accId;
    oppData = [];
    columns = coloumns;
    conData = [];

    handleOnChange(event){
        this.accId = event.target.value;
    }

    @wire(getAccountOpportunities, {accountId : '$accId'})wiredContacts({error, data}){
        if(data){
            this.oppData = data;
        }
    };

    handleClick(event){
        getContactDetails({accountId : this.accId}).then(data=>{
            this.conData = data;
        })
    }

    

}