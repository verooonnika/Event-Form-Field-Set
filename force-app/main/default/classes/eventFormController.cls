public with sharing class eventFormController {
    
    @AuraEnabled(cacheable = true)
    public static List<FieldWrapper> getFields(){
        List<Schema.FieldSetMember> fieldSetMembers = SObjectType.Event.FieldSets.Event_Field_Set.getFields();
        List<FieldWrapper> fields = new List<FieldWrapper>();
        for(Schema.FieldSetMember field: fieldSetMembers){
            Schema.DescribeFieldResult fieldDescribe = field.getSObjectField().getDescribe();
            
            String fieldName = fieldDescribe.getName();
            String fieldLabel = fieldDescribe.getLabel();
            String fieldType = fieldDescribe.getType().name();
            FieldWrapper fieldWrap = new FieldWrapper(fieldName, fieldLabel, fieldType);
            fields.add(fieldWrap);            
        }
        
        return fields;
    }

    @AuraEnabled(cacheable=true)
    public static Event getEventRecord(Id eventId){

        return [SELECT Id, Subject, StartDateTime, EndDateTime,
         CheckBox_Field__c, Currency_Field__c, Email_Field__c,
        Phone_Field__c, PickList_Field__c, Text_Field__c 
         FROM Event 
         WHERE Id =: eventId LIMIT 1];
    }

    @AuraEnabled
    public static void createEventRecord(Event eventObject){
        upsert eventObject;
    }
}