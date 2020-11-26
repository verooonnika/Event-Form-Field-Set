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
            Boolean isRequired = field.getDBRequired();
            FieldWrapper fieldWrap = new FieldWrapper(fieldName, fieldLabel, fieldType, isRequired);
            fields.add(fieldWrap);            
        }
        
        return fields;
    }

    @AuraEnabled
    public static Event getEventRecord(Id eventId){

        return [SELECT Id, Subject, StartDateTime, EndDateTime,
         CheckBox_Field__c, Currency_Field__c, Email_Field__c,
        Phone_Field__c, PickList_Field__c, Text_Field__c 
         FROM Event 
         WHERE Id =: eventId LIMIT 1];
    }

    @AuraEnabled
    public static Id createEventRecord(Event eventObject){
        upsert eventObject;
        return eventObject.Id;
    }

    @AuraEnabled(cacheable = true)
    public static Map<String, String> getEventSubjectPicklist(){
        Map<String, String> picklistMap = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Event.Subject.getDescribe();
        List<Schema.PicklistEntry> pickList = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry ple: pickList){
            picklistMap.put(ple.getLabel(), ple.getValue());
        }

        return picklistMap;
    }
}