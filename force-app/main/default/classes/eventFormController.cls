public with sharing class eventFormController {
    
    @AuraEnabled(cacheable = true)
    public static List<FieldWrapper> getFields(){
        List<Schema.FieldSetMember> fieldSetMembers = SObjectType.Event.FieldSets.Event_Field_Set.getFields();
        List<FieldWrapper> fields = new List<FieldWrapper>();
        for(Schema.FieldSetMember field: fieldSetMembers){
            Schema.DescribeFieldResult fieldDescribe = field.getSObjectField().getDescribe();
            
            FieldWrapper fieldWrap = new FieldWrapper(fieldDescribe);
            fields.add(fieldWrap);            
        }
        
        return fields;
    }

    @AuraEnabled
    public static Event getEventRecord(Id eventId){
        List<Schema.FieldSetMember> fieldSetMembers = SObjectType.Event.FieldSets.Event_Field_Set.getFields();

        String query = 'SELECT ';
        for(Schema.FieldSetMember f : fieldSetMembers) {
            query += f.getFieldPath() + ', ';
        }
        query += 'Id FROM Event WHERE Id =: eventId LIMIT 1';
        return Database.query(query);
    }

    @AuraEnabled
    public static Id createEventRecord(Event eventObject){
        upsert eventObject;
        return eventObject.Id;
    }
}