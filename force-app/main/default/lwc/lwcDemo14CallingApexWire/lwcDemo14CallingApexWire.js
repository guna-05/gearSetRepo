import { LightningElement, wire } from 'lwc';
import getAccountList from '@salesforce/apex/LWCDemo14Controller.getAccountList';
import getContactList from '@salesforce/apex/LWCDemo14Controller.getContactList';

export default class LwcDemo14CallingApexWire extends LightningElement {

    value = 'none';
    options = [];

    @wire(getAccountList)allAccounts;

    handleClick(event){
        alert(JSON.stringify(this.allAccounts));
    }

    @wire(getAccountList)wiredAccounts({error,data}){
        if(data){
            let tempArray = [];
            const temp = {label: 'None', value:'None'};
            tempArray.push(temp);
            for(var acc of data){
                var tempval = {label: acc.Name, value: acc.Id};
                tempArray.push(tempval);
            }
            this.options = tempArray;
        }
        else if(error){
            alert('error');
        }
    }

    handleChange(event) {
        this.value = event.detail.value;
        alert('Selected Account Id is: '+this.value);
    }

    @wire(getContactList, {selectedAccountId : '$value'})allContacts;
    
}