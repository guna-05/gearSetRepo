import { LightningElement } from 'lwc';
import allresources from '@salesforce/resourceUrl/allresources';
import { loadStyle, loadScript } from "lightning/platformResourceLoader";

export default class LwcDemo17UsingExtrenalResources extends LightningElement {

    image1 = allresources + '/images/welcome.png';
    renderedCallback(){
      Promise.all([loadScript(this, allresources + '/js/chart.js'),
                    loadStyle(this, allresources + '/css/mycssfile.css')]).then(() => {
            const chartdata = {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'July'],
                datasets: [{
                  label: 'My First Dataset',
                  data: [65, 59, 80, 81, 56, 55, 40],
                  backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(255, 159, 64, 0.2)',
                    'rgba(255, 205, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(201, 203, 207, 0.2)'
                  ],
                  borderColor: [
                    'rgb(255, 99, 132)',
                    'rgb(255, 159, 64)',
                    'rgb(255, 205, 86)',
                    'rgb(75, 192, 192)',
                    'rgb(54, 162, 235)',
                    'rgb(153, 102, 255)',
                    'rgb(201, 203, 207)'
                  ],
                  borderWidth: 1
                }]
              };
              var cmp = this.template.querySelector('canvas');
              var ctx = cmp.getContext('2d');
              var mychart = new Chart(ctx, {type: 'bar', data:chartdata});
          }).catch(error =>{
            alert('Error');
          });
    }
}