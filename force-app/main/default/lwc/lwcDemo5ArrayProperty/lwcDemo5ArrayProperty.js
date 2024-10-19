import { LightningElement, track } from 'lwc';

export default class LwcDemo5ArrayProperty extends LightningElement {
    @track contacts = [
                    {Id : 1, Name : 'Contact Name 1', Title : 'Test Title 1'},
                    {Id : 1, Name : 'Contact Name 2', Title : 'Test Title 2'},
                    {Id : 1, Name : 'Contact Name 3', Title : 'Test Title 3'},
                    {Id : 1, Name : 'Contact Name 4', Title : 'Test Title 4'}
                ];
    
handleClick(event){
    alert('Hello');
    this.contacts[0].Name = 'Updated Name';
    alert('Value Updated');
}
}