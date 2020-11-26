public with sharing class FieldWrapper {

    @AuraEnabled public String apiName;
    @AuraEnabled public String label;
    @AuraEnabled public String lwcType;
    @AuraEnabled public Object value;
    @AuraEnabled public Boolean isRequired;

    public FieldWrapper(String apiName, String label, String type, Boolean isRequired) {
        this.apiName = apiName;
        this.label = label;

        if(apiName == 'StartDateTime' || apiName == 'EndDateTime'){
            this.isRequired = true;
        }
    
        if(type == 'STRING'){
            this.lwcType = 'text';
        }
        else if(type == 'BOOLEAN'){
            this.lwcType = 'checkbox';
        }
        else if(type == 'CURRENCY'){
            this.lwcType = 'number';
        }
        else if(type == 'PHONE'){
            this.lwcType = 'tel';
        }
        else{
            this.lwcType = type;
        }
    }
}
