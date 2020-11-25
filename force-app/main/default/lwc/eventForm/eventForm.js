import {LightningElement, wire, track, api} from 'lwc';
import getFields from '@salesforce/apex/eventFormController.getFields';
import getEventRecord from '@salesforce/apex/eventFormController.getEventRecord';
import createEventRecord from '@salesforce/apex/eventFormController.createEventRecord';

export default class EventForm extends LightningElement {

    @track fieldsData=[];
    @api recordId;
    @track eventRecord;

    @wire(getFields) fields ({data, error}) {
        if(data) {
            data.forEach(field => {
                this.fieldsData.push({label: field.label, apiName: field.apiName, type: field.lwcType});
            });
        }
        else if(error) {
            console.log(error);
        }
    } 

    @wire(getEventRecord, {eventId: '$recordId'}) record ({data, error}) {
        if (data) {
            this.eventRecord = {...data};
    }
}

    connectedCallback(){
        //console.debug('15');
    }

    get fieldsInfo(){  
        if(this.fieldsData && this.eventRecord){
            this.fieldsData.forEach(field => {
                if(this.eventRecord[field.apiName] != undefined){
                    field.value = this.eventRecord[field.apiName];
                }
        });
    } 

        return this.fieldsData;
    }

    changeFieldValue(event){
        var field = this.fieldsData.find(element => element.label == event.target.label);
        this.eventRecord[field.apiName] = event.target.value;
        console.debug(this.eventRecord);
    }

    handleSave(){
        let updatedEvent = JSON.parse(JSON.stringify(this.eventRecord));
        createEventRecord({eventObject: updatedEvent})
        .then(result =>{
            console.debug('success', result);
        })
        .catch(error =>{
            console.debug(error);
        })
    }
}