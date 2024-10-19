import { api, LightningElement} from 'lwc';

export default class LwcDemo9Time extends LightningElement {
    timestamp = new Date();

    @api
    refreshtime(){
        this.timestamp = new Date();
        alert('The Child component method get called');
    }
}