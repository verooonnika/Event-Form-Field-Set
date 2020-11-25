public with sharing class FieldWrapper {

    @AuraEnabled public String apiName;
    @AuraEnabled public String label;
    @AuraEnabled public String lwcType;
    @AuraEnabled public Object value;


    public FieldWrapper(String apiName, String label, String type) {
        this.apiName = apiName;
        this.label = label;

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
