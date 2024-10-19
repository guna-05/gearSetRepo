import { LightningElement } from 'lwc';
import { NavigationMixin } from "lightning/navigation";

export default class LwcDemo23Navigation extends NavigationMixin(LightningElement) {
    navigatetohome(event){
        this[NavigationMixin.Navigate]({
            type: "standard__objectPage",
            attributes: {
              objectApiName: "Account",
              actionName: "home",
            },
          });
    }
    navigatetorecord(event){
        this[NavigationMixin.Navigate]({
            type: "standard__recordPage",
            attributes: {
              recordId: "001ak00000K9LIUAA3", // objectApiName is optional
              actionName: "view",
            },
          });
    }
    navigatetotab(event){
        this[NavigationMixin.Navigate]({
            type: "standard__navItemPage",
            attributes: {
              apiName: "LWCSelfLearning",
            },
          });
    }
    navigatetonewrecord(event){
        this[NavigationMixin.Navigate]({
            type: "standard__objectPage",
            attributes: {
              objectApiName: "Account",
              actionName: "new",
            },
          });
    }
    navigatetoexternalurl(event){
        this[NavigationMixin.Navigate](
            {
              type: "standard__webPage",
              attributes: {
                url: "http://salesforce.com",
              },
            },
            true, // Replaces the current page in your browser history with the URL
          );
    }
}