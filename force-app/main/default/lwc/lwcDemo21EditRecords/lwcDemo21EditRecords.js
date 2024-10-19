import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class LwcDemo21EditRecords extends LightningElement {
    @api objectApiName;
    @api recordId;

    handleSuccess(event){
        const evt = new ShowToastEvent({
            title: 'Confirmation',
            message: 'The Record has be updated',
            variant: 'success',
          });
          this.dispatchEvent(evt);
      }

      handleSubmit(event){
        event.preventDefault();
        console.log('All field Values: '+ JSON.stringify(event.detail.fields));
        const fields = event.detail.fields;
        fields.Website = 'https://mtxb2b.com';
        var tempname = fields.Name.toUpperCase();
        fields.Name = tempname;
        this.template.querySelector('lightning-record-edit-form').submit(fields);
      }

}