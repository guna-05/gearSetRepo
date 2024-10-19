import { LightningElement, wire } from 'lwc';
import getContactList from '@salesforce/apex/LWCDemo25DataTabelController.getContactList';
import { NavigationMixin } from "lightning/navigation";
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

const actions = [
    {label: 'Show Details', name: 'details'},
    {label: 'Edit', name: 'edit'},
    {label: 'Delete', name: 'delete'},
]

const columns = [
    { label: 'Name', fieldName: 'contactUrl', type: 'url',
        typeAttributes: { 
            label: { fieldName: 'Name' },
            target: '_blank'
        }   
    },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Title', fieldName: 'Title', type: 'text' },
    { label: 'Account Id', fieldName: 'AccountId', type: 'text' },
    { label: 'Title', fieldName: 'Title', type: 'text' },
    { label: 'Account Name', fieldName: 'accountUrl', type: 'url',
        typeAttributes: { 
            label: { fieldName: 'AccountName' },
            target: '_blank'
        },
        cellAttributes:{
            iconName : 'standard:account',
            iconPosition : 'left',
            iconAlterativeText: 'Account'
        }
     },
     { type: 'button', fixedWidth: 150,
        typeAttributes: {
            label: 'View Details',
            variant: 'brand',
            name: 'viewDetails'
        },
     },
     { type: 'action', typeAttributes: {rowActions : actions}}
];

export default class LwcDemo25DataTable extends NavigationMixin(LightningElement) {

    contactData = [];
    columnsList = columns;

    @wire(getContactList) wiredContacts({error, data}){
        if(data){
            console.log(JSON.stringify(data));
            let parsedData = JSON.parse(JSON.stringify(data));
            let baseUrl = 'https://'+location.host+'/';
            parsedData.forEach(contact => {
                contact.contactUrl = baseUrl+contact.Id;
                if(contact.AccountId){
                    contact.AccountName = contact.Account.Name;
                    contact.accountUrl = baseUrl+contact.AccountId;
                }
            });
            this.contactData = parsedData;
        }
    }

    handleRowAction(event){
        const action = event.detail.action;
        const row = event.detail.row;
        switch(action.name){
            case 'details':
                this.showDeatils(row.Id);
                break;
            case 'edit':
                this.editContact(row.Id);
                break;
            case 'delete':
                this.deleteContact(row.Id);
                break;
            case 'viewDetails':
                this.showDeatils(row.Id);
                break;
        }
    }

    showDeatils(recordId){
        alert('Use Navigation Mixin to navigate to record Id:'+recordId);
        this[NavigationMixin.Navigate]({
            type: "standard__recordPage",
            attributes: {
              recordId: recordId, // objectApiName is optional
              actionName: "view",
            },
          });
    }

    editContact(recordId){
        alert('Use Navigation Mixin to navigate to record Id:'+recordId+' in edit mode');
        this[NavigationMixin.Navigate]({
            type: "standard__recordPage",
            attributes: {
              recordId: recordId, // objectApiName is optional
              actionName: "edit",
            },
          });
        //return refreshApex(this.wiredContacts);
    }

    deleteContact(recordId){
        alert('Use uiRecordApi to delete record Id:'+recordId);
        deleteRecord(recordId);
        //return refreshApex(this.wiredContacts);
    }
}