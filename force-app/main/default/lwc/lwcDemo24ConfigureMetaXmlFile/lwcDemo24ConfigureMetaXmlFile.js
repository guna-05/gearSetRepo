import { LightningElement, api } from 'lwc';

export default class LwcDemo24ConfigureMetaXmlFile extends LightningElement {
    @api dynamicclass;
    @api message;
    @api objectApiName;
    @api recordId;
}