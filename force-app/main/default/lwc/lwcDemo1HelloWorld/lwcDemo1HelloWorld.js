import { LightningElement } from 'lwc';

export default class LwcDemo1HelloWorld extends LightningElement {
    
    clicked = false;
    handleClick(event){
        alert(this.clicked);
        this.clicked = true;
    }    
}