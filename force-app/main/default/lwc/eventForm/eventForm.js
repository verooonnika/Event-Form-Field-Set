import {LightningElement, wire, track, api} from 'lwc';
import getFields from '@salesforce/apex/eventFormController.getFields';
import getEventRecord from '@salesforce/apex/eventFormController.getEventRecord';
import createEventRecord from '@salesforce/apex/eventFormController.createEventRecord';
import {NavigationMixin} from 'lightning/navigation';

export default class EventForm extends NavigationMixin(LightningElement){

    @api recordId;
    @track eventRecord;
    @track fieldsData=[];

    @wire(getFields) fields ({data, error}) {
        if(data) {
            data.forEach(field => {
                if(field.lwcType == 'COMBOBOX'){
                    var pickListOptions = [];
                    for (var key in field.picklistValues){
                        pickListOptions.push({label: key, value: field.picklistValues[key]});
                    }
                    this.fieldsData.push({label: field.label, apiName: field.apiName, type: field.lwcType, isCombobox: true, isRequired: field.isRequired, options: pickListOptions});
                }else{
                    this.fieldsData.push({label: field.label, apiName: field.apiName, type: field.lwcType, isCombobox: false, isRequired: field.isRequired});
                }
            });
        }
        else if(error) {
            console.log(error);
        }
    } 

    connectedCallback(){
        if(this.recordId){
            getEventRecord({eventId: this.recordId})
            .then(result =>{
                this.eventRecord = result;
            })
            .catch(error =>{
                console.debug(error);
            })
        } else{
            this.eventRecord = {SObjectType: 'Event'};
        }
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
        if(field.type == 'checkbox'){
            this.eventRecord[field.apiName] = event.target.checked;
        } else{
            this.eventRecord[field.apiName] = event.target.value;
        }
    }

    handleSave(){
        if(this.validateFields()){
            let updatedEvent = JSON.parse(JSON.stringify(this.eventRecord));
            createEventRecord({eventObject: updatedEvent})
            .then(result =>{
                if(!this.recordId){
                    this.recordId = result;
                }
                this.navigateToEventPage();
            })
            .catch(error =>{
                console.debug(error);
            })
        }
    }

    navigateToEventPage() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.recordId,
                objectApiName: 'Event',
                actionName: 'view'
            }
        });
 }

    validateFields() {
        const allValid = [...this.template.querySelectorAll('lightning-input')]
        .reduce((validSoFar, inputCmp) => {
                    inputCmp.reportValidity();
                    return validSoFar && inputCmp.checkValidity();
        }, true);

        return allValid;
    }
}