import { LightningElement } from 'lwc';

export default class LwcDemo12ContactDetail extends LightningElement {
    contacts = [
        {Id : 1, Name : 'Contact Name 1', Title : 'Test Title 1'},
        {Id : 2, Name : 'Contact Name 2', Title : 'Test Title 2'},
        {Id : 3, Name : 'Contact Name 3', Title : 'Test Title 3'},
        {Id : 4, Name : 'Contact Name 4', Title : 'Test Title 4'}
    ];

    selecthandler(event){
        var selectedId = event.currentTarget.dataset.item;
        console.log('The Element with Id clicked is'+ selectedId);
        const selectedevent = new CustomEvent('selected', {detail : /* data */ {contactid : selectedId}, bubbles: true});
        this.dispatchEvent(selectedevent);
    }
}