import { LightningElement, wire } from 'lwc';
import {APPLICATION_SCOPE,MessageContext,publish} from 'lightning/messageService';
import demolms from '@salesforce/messageChannel/Demolms__c';

export default class LwcDemo19AssignmentContactDetails extends LightningElement {
    contactdetails;
    contacts = [
        {Id : 1, Name : 'Contact Name 1', Title : 'Test Title 1'},
        {Id : 2, Name : 'Contact Name 2', Title : 'Test Title 2'},
        {Id : 3, Name : 'Contact Name 3', Title : 'Test Title 3'},
        {Id : 4, Name : 'Contact Name 4', Title : 'Test Title 4'}
    ];

    @wire(MessageContext)messageContext;

    selecthandler(event){
        var selectedId = event.currentTarget.dataset.item;
        this.contactdetails = this.contacts.find(contact => contact.Id == selectedId);
        var tempmessage = this.contactdetails.Id + ' - ' + this.contactdetails.Name + ' - ' + this.contactdetails.Title;
        const payload = { message: tempmessage, source: 'Test Source' };
        publish(this.messageContext, demolms, payload);
    }
}