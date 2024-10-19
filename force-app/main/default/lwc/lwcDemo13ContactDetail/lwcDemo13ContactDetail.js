import { LightningElement, wire } from 'lwc';
import { fireEvent }  from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

export default class LwcDemo13ContactDetail extends LightningElement {
    contactdetails;
    contacts = [
        {Id : 1, Name : 'Contact Name 1', Title : 'Test Title 1'},
        {Id : 2, Name : 'Contact Name 2', Title : 'Test Title 2'},
        {Id : 3, Name : 'Contact Name 3', Title : 'Test Title 3'},
        {Id : 4, Name : 'Contact Name 4', Title : 'Test Title 4'}
    ];

    @wire(CurrentPageReference)pageRef;

    selecthandler(event){
        var selectedId = event.currentTarget.dataset.item;
        this.contactdetails = this.contacts.find(contact => contact.Id == selectedId);
        alert(JSON.stringify(this.contactdetails));
        fireEvent(this.pageRef, 'pubsubselected', this.contactdetails);
    }
}