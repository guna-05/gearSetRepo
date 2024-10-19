import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from "lightning/navigation";

export default class LwcDemo22CreateRecord extends NavigationMixin(LightningElement) {

    newAccountId = '';
    accountName = '';
    accountNumber = '';
    handleNameChange(event){
        this.accountName =  event.target.value;
    }
    handleAccNumChange(event){
        this.accountNumber = event.target.value;
    }
    
    handleClick(event){
        const fields = {};
        fields['Name'] = this.accountName;
        fields['AccountNumber'] = this.accountNumber;
        const recordinput = {apiName: 'Account', fields};
        createRecord(recordinput).then(data => {
            //alert(JSON.stringify(data));
            this.newAccountId = data.id;
            this.navigatetorecord(event);
        }).catch(error=>{
            alert(JSON.stringify('error'));
        })
        
    }

    navigatetorecord(event){
        this[NavigationMixin.Navigate]({
            type: "standard__recordPage",
            attributes: {
              recordId: this.newAccountId, // objectApiName is optional
              actionName: "view",
            },
          });
    }
}