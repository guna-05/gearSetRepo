import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import ACTIVE_FIELD from '@salesforce/schema/Account.Active__c';
import { ShowToastEvent } from "lightning/platformShowToastEvent";

//const allfields = ['Account.Name', 'Account.Industry', 'Account.Phone', 'Account.Active__c'];

export default class LwcDemo20LoadRecords extends LightningElement {

    @api objectApiName;
    @api recordId;

    /*@wire(getRecord, {
        recordId: '$recordId',
        fields: allfields
      })
      account;*/

      @wire(getRecord, {
            recordId: '$recordId',
            fields: [NAME_FIELD, PHONE_FIELD, INDUSTRY_FIELD, ACTIVE_FIELD]
            })
            account;
        


      get nameValue(){
        return getFieldValue(this.account.data, 'Account.Name');
      }

      get industryValue(){
        return getFieldValue(this.account.data, 'Account.Industry');
      }

      get phoneValue(){
        return getFieldValue(this.account.data, 'Account.Phone');
      }

      get activeValue(){
        return getFieldValue(this.account.data, 'Account.Active__c');
      }

      handleSubmit(event){
        event.preventDefault();
        console.log('All field Values: '+ JSON.stringify(event.detail.fields));
        const fields = event.detail.fields;
        fields.Website = 'https://mtxb2b.com';
        var tempname = fields.Name.toUpperCase();
        fields.Name = tempname;
        this.template.querySelector('lightning-record-form').submit(fields);
      }

      handleSuccess(event){
        const evt = new ShowToastEvent({
            title: 'Confirmation',
            message: 'The Record has be updated',
            variant: 'success',
          });
          this.dispatchEvent(evt);
      }

      handleError(event){
        const evt = new ShowToastEvent({
            title: 'Error',
            message: 'The Record has an error',
            variant: 'error',
          });
          this.dispatchEvent(evt);
      }

}