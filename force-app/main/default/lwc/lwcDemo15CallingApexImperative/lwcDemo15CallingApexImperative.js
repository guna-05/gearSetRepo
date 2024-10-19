import { LightningElement } from 'lwc';
import getAccountList from '@salesforce/apex/LWCDemo14Controller.getAccountList';
import getContactList from '@salesforce/apex/LWCDemo14Controller.getContactList';

export default class LwcDemo15CallingApexImperative extends LightningElement {
    value = 'none';
    options = [];
    allContacts;

    connectedCallback(){
        getAccountList().then(data=>{
            let tempArray = [];
            const temp = {label: 'None', value:'None'};
            tempArray.push(temp);
            for(var acc of data){
                var tempval = {label: acc.Name, value: acc.Id};
                tempArray.push(tempval);
            }
            this.options = tempArray;
        
        }).catch(error=>{
            alert('error');
        });
    }

    handleChange(event) {
        this.value = event.target.value;
        getContactList({selectedAccountId : this.value}).then(data=>{
            this.allContacts = data;
        }).catch(error=>{
            alert('error');
        });
    }

}