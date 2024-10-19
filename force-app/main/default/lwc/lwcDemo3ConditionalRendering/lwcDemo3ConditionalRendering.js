import { LightningElement } from 'lwc';

export default class LwcDemo3ConditionalRendering extends LightningElement {
    isDetailsVisible = true;
    myexpression = 2 == '2';
    property2 = true;

    handleChange(event){
        this.isDetailsVisible = event.target.checked;
    }
}