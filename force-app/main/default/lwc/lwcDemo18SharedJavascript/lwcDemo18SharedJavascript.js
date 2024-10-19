import { LightningElement } from 'lwc';
import {getTermOptions, calculateMonthlyPayment} from 'c/lwcDemo18Calculator'

export default class LwcDemo18SharedJavascript extends LightningElement {
    principal = 0;
    rate = 0;
    term = '20';
    tempterm = 20;
    termoptions = getTermOptions();
    monthlypayment = 0;

    handlePrincipalChange(event){
        this.principal = event.target.value;
    }

    handleRateChange(event){
        this.rate = event.target.value;
    }

    handleTermChange(event){
        this.term = event.target.value;
        this.tempterm = parseInt(event.target.value);
    }

    calculateMonltyPayment(event){
        this.monthlypayment = calculateMonthlyPayment(this.principal,this.tempterm,this.rate);
    }
}