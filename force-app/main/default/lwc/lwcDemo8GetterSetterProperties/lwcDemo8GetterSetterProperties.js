import { LightningElement } from 'lwc';

export default class LwcDemo8GetterSetterProperties extends LightningElement {
    firstname = '';
    lastname = '';
    fullname = '';

    handleNameChange(event) {
        var field = event.target.name;
        if(field === 'firstname'){
            this.firstname = event.target.value;
        }
        if(field === 'lastname'){
            this.lastname = event.target.value;
        }
        this.uppercasename = this.firstname + ' ' + this.lastname;
    }

    get uppercasename(){
        return this.fullname.toUpperCase();
    }

    set uppercasename(value){
        this.fullname = value;
    }
}