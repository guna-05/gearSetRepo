import { LightningElement, wire } from 'lwc';
import { registerListener, unregisterAllListeners } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

export default class LwcDemo13IndividualComponentCommunication extends LightningElement {
    selectedContact = {};
    
    @wire(CurrentPageReference)pageRef;

    connectedCallback(){
        registerListener('pubsubselected',this.contactHandler,this);
    }

    contactHandler(data){
        alert(JSON.stringify(data));
        this.selectedContact = data;
    }

    disconnectedCallback(){
        unregisterAllListeners(this);
    }


}