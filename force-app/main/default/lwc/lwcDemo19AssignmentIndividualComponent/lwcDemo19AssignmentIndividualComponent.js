import { LightningElement,wire } from 'lwc';
import {APPLICATION_SCOPE,MessageContext,subscribe,unsubscribe,} from 'lightning/messageService';
import demolms from '@salesforce/messageChannel/Demolms__c';

export default class LwcDemo19AssignmentIndividualComponent extends LightningElement {
    receivedMessage = '';

    @wire(MessageContext)messageContext;

    connectedCallback(){
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                demolms,
                (data) => this.handleMessage(data),
                { scope: APPLICATION_SCOPE }
            );
        }
    }

    handleMessage(data){
        this.receivedMessage= 'Selected Contact Details: '+data.message + ' & Source is : '+data.source;
    }

    disconnectedCallback(){
        unsubscribe(this.subscription);
        this.subscription = null;
    }
}