import { LightningElement } from 'lwc';

export default class LwcDemo11EventParent extends LightningElement {
    selectedContactId = ' ';
    
    contactSelected(event){
        this.selectedContactId = event.detail.contactid;
    }
}