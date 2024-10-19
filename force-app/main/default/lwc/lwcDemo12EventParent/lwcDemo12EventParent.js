import { LightningElement } from 'lwc';

export default class LwcDemo12EventParent extends LightningElement {
    selectedContactId = ' ';

    connectedCallback(){
        this.template.addEventListener('selected', event=>{
            this.selectedContactId = event.detail.contactid;
        });
    }
}