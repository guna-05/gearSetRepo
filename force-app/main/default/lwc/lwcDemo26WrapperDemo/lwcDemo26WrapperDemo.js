import { LightningElement, track, wire } from 'lwc';
import getAccountDetailsWithRelatedData from '@salesforce/apex/LWCDemo26WrapperController.getAccountDetailsWithRelatedData';
import updateContactRecords from '@salesforce/apex/LWCDemo26WrapperController.updateContactRecords';
import updateSingleContact from '@salesforce/apex/LWCDemo26WrapperController.updateSingleContact';
import updateOpportunityRecords from '@salesforce/apex/LWCDemo26WrapperController.updateOpportunityRecords';
import updateSingleOpportunity from '@salesforce/apex/LWCDemo26WrapperController.updateSingleOpportunity';
import { getObjectInfo, getPicklistValues } from "lightning/uiObjectInfoApi";
import StageName from "@salesforce/schema/Opportunity.StageName";
import Opportunity from "@salesforce/schema/Opportunity";

export default class LwcDemo26WrapperDemo extends LightningElement {
    recordId;
    allData = {};
    hasData = false;
    editAllContacts = false;
    editAllOpportunity = false;
    @track allContacts = [];
    @track allOpportunity = [];
    stageName = [];
    value = ' ';
    opportunityRecordTypeId;

    handleAccountIdChange(event){
        this.recordId = event.target.value;
    }

    handleClick(event){
        if(this.recordId){
            getAccountDetailsWithRelatedData({accountId : this.recordId}).then(data =>{
                console.log(JSON.stringify(JSON.parse(data)));
                this.allData = JSON.parse(data);
                this.allContacts = this.allData.conList;
                this.allOpportunity = this.allData.oppList;
                this.hasData = true;
            }).catch(error=>{

            });
        }
    }

    editAll(event){
        var name = event.target.name;
        //alert(name);
        if(name == 'Contact'){
            this.editAllContacts = true; 
            this.allContacts.forEach((element, index)=>{
                element.isEditable = true;
            });
        }else if(name == 'Opportunity'){
            console.log('All opp'+event.target.dataset.id);
            this.editAllOpportunity = true;
            this.allOpportunity.forEach((element, index)=> {
                element.isEditable = true;
            })
        }
        
    }

    saveAll(event){
        var name = event.target.name;
        //alert(name);
        if(name == 'Contact'){
            updateContactRecords({jsonString : JSON.stringify(this.allData)}).then(data=>{
                this.editAllContacts = false;
                this.allData = JSON.parse(data);
                //alert(JSON.stringify(this.allData));
                this.allContacts = this.allData.conList;
                //alert(JSON.stringify(this.allContacts));
            }).catch(error=>{
                //alert('Error');
            });
        }else if(name == 'Opportunity'){
            updateOpportunityRecords({jsonString : JSON.stringify(this.allData)}).then(data => {
                this.editAllOpportunity = false;
                this.allData = JSON.parse(data);
                this.allOpportunity = this.allData.oppList;
            }).catch(error =>{
                alert(error);
            });
        }
        
    }

    handleOnBlur(event){    //used on contacts input elements
        this.allContacts[event.target.dataset.id].contactObject[event.target.name] = event.target.value;
        console.log(JSON.stringify(this.allContacts));
        this.allData.conList = this.allContacts;  //pushing the updated contacts value to all data
    }

    handleOnBlurOpp(event){      //used on opportunity input elements
        this.allOpportunity[event.target.dataset.id].opportunityObject[event.target.name] = event.target.value;
        console.log(JSON.stringify(this.allOpportunity));
        this.allData.oppList = this.allOpportunity;
    }

    addNewContact(event){
        var _newContact = {
            "attributes":{
                "type":"Contact",
            },
            "FirstName":"",
            "LastName":"",
            "Email":"",
            "Title":"",
            "AccountId": this.recordId
        };
        var _temp = {'isSelected': false, 'isEditable': true, 'contactObject': _newContact};
        this.editAllContacts = true;
        this.allContacts.push(_temp);
    }

    addNewOpportunity(event){
        var _newOpportunity = {
            "attributes":{
                "type":"Opportunity"
            },
            "Name":"",
            "StageName":"",
            "Amount":"",
            "CloseDate":"",
            "AccountId": this.recordId
        }
        var _temp = {'isSelected': false, 'isEditable': true, 'opportunityObject': _newOpportunity};
        this.editAllOpportunity = true;
        this.allOpportunity.push(_temp);
    }
    

    editSingleContact(event){
        this.editAllContacts = true;
        console.log('con'+event.target.dataset.id);
        this.allContacts[event.target.dataset.id]['isEditable'] = true;
    }

    saveSingleContact(event){
        var selectedElement = {};
        selectedElement = this.allContacts[event.target.dataset.id];
        var selectedId = event.target.dataset.id;
        alert(JSON.stringify(selectedElement));
        updateSingleContact({jsonString : JSON.stringify(selectedElement)}).then(data=> {
            this.allContacts[selectedId] = JSON.parse(data);
            this.allData.conList = this.allContacts;
            this.editAllContacts = false;
            this.allContacts.forEach((element, index)=>{
                if(element.isEditable){
                    this.editAllContacts = true;
                }
            });
        }).catch(error=>{

        });
    }

    editSingleOpportunity(event){
        this.editAllOpportunity = true;
        this.allOpportunity[event.target.dataset.id]['isEditable']=true;
    }

    saveSingleOpportunity(event){
        this.allOpportunity[event.target.dataset.id]['isEditable']=false;
        var selectedElement = {};
        selectedElement = this.allOpportunity[event.target.dataset.id];
        var selectedId = event.target.dataset.id;
        updateSingleOpportunity({jsonString : JSON.stringify(selectedElement)}).then(data=>{
            this.allOpportunity[selectedId] = JSON.parse(data);
            this.allData.oppList = this.allOpportunity;
            this.editAllOpportunity = false;
            this.allOpportunity.forEach((element, index)=>{
                if(element.isEditable){
                    this.editAllOpportunity = true;
                }
            });
        }).catch(error =>{

        });
    }

    @wire(getObjectInfo, { objectApiName: Opportunity })oppObjectInfo;

    @wire(getPicklistValues,{ recordTypeId:'$oppObjectInfo.data.defaultRecordTypeId', fieldApiName:StageName })picklistResults({ error, data }){
        if (data) {
            //console.log(data);
            //var tempData = data.values;
            for(var stage of data.values){
                var temp = {label: stage.label, value: stage.value};
                this.stageName.push(temp);
            }
        } else if (error) {
            alert(error);
        }
    }
}