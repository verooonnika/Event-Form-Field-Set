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
}