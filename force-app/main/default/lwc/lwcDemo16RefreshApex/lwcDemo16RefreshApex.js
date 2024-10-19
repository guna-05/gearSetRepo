import { LightningElement, wire } from 'lwc';
import getAccountList from '@salesforce/apex/LWCDemo16Controller.getAccountList';
import updateAccountList from '@salesforce/apex/LWCDemo16Controller.updateAccountList';
import {refreshApex} from '@salesforce/apex';

export default class LwcDemo16RefreshApex extends LightningElement {

    testproperty = 'Initial Value';
    @wire(getAccountList)accountList;

    handleClick(event){
        updateAccountList().then(data=>{
            this.testproperty  = 'Updated Value';
            alert('Account record got updated');
            return refreshApex(this.accountList);
        }).catch(error=>{
            alert('error');
        });
    }

    
}