import { LightningElement, track } from 'lwc';

export default class LwcDemo2DataBinding extends LightningElement {
    greeting = 'Welcome To Salesforce LWC Training!!!';
    firstname = '';
    lastname = '';
    @track fullname = {};
    handleGreetingChange(event){
        this.greeting = event.target.value;
    }

    handleNameChange(event){
        var field = event.target.name;
        this.fullname[field] = event.target.value;
        /*if(field == 'firstname'){
            this.firstname = event.target.value;
        }
        if(field == 'lastname'){
            this.lastname = event.target.value;
        }
       //this.fullname[field] = event.target.value;
       /*this.fullname = {
            firstname: this.firstname,
            lastname: this.lastname
        }*/
        //this.fullname.firstname = this.firstname;
        //this.fullname.lastname = this.lastname;
        console.log('-----'+JSON.stringify(this.fullname));
    }
}