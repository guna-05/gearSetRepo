import { LightningElement } from 'lwc';

export default class LwcDemo9CallingChildMethod extends LightningElement {

    handleClickQuerySelector(event){
        this.template.querySelector('c-lwc-demo9-time').refreshtime();
    }

    handleClickLwcRef(event){
        let childcmp = this.refs.mychildcomponent;
        childcmp.refreshtime();
    }
}