public with sharing class FieldWrapper {

    @AuraEnabled public String apiName;
    @AuraEnabled public String label;
    @AuraEnabled public String lwcType;
    @AuraEnabled public Object value;
    @AuraEnabled public Boolean isRequired;
    @AuraEnabled public Map<String, Object> picklistValues;

    public FieldWrapper(Schema.DescribeFieldResult fieldDescribe) {
        this.apiName = fieldDescribe.getName();
        this.label = fieldDescribe.getLabel();

        String type = fieldDescribe.getType().name();

        if(apiName == 'StartDateTime' || apiName == 'EndDateTime'){
            this.isRequired = true;
        }

        if(type == 'COMBOBOX' || type == 'PICKLIST') {
            this.lwcType = 'COMBOBOX';
            picklistValues = new Map<String, Object>();
            
            for(Schema.PicklistEntry ple: fieldDescribe.getPicklistValues()){
                picklistValues.put(ple.getLabel(), ple.getValue());
            }
        }else if(type == 'STRING'){
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
