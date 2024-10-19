import { LightningElement, wire } from 'lwc';
import {APPLICATION_SCOPE,MessageContext,publish,subscribe,unsubscribe,} from 'lightning/messageService';
import demolms from '@salesforce/messageChannel/Demolms__c';

export default class LwcDemo19LightningMessageService extends LightningElement {

    receivedMessage = '';
    passedMessage = '';

    @wire(MessageContext)messageContext;

    handleMessageChange(event){
        this.passedMessage = event.target.value;
    }

    handlePublish(event){
        const payload = { message: this.passedMessage, source: 'Test Source' };
        publish(this.messageContext, demolms, payload);
    }

    handleSubscribe(event){
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
        this.receivedMessage= 'Message is : '+data.message + ' Source is : '+data.source;
    }

    handleUnsubscribe(event){
        unsubscribe(this.subscription);
        this.subscription = null;
    }

}