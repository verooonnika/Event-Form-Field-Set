import {LightningElement, wire, track} from 'lwc';
import getFields from '@salesforce/apex/eventFormController.getFields';

export default class EventForm extends LightningElement {

    @track fieldsData=[];

    @wire(getFields) fields ({data, error}) {
        if(data) {
            console.debug(data);
            data.forEach(field => {
                this.fieldsData.push({label: field.label, apiName: field.apiName, type: field.lwcType});
            });
        }
        else if(error) {
            console.log(error);
        }
    }

    connectedCallback(){

    }
}