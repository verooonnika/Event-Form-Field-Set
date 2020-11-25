declare module "@salesforce/apex/eventFormController.getFields" {
  export default function getFields(): Promise<any>;
}
declare module "@salesforce/apex/eventFormController.getEventRecord" {
  export default function getEventRecord(param: {eventId: any}): Promise<any>;
}
declare module "@salesforce/apex/eventFormController.createEventRecord" {
  export default function createEventRecord(param: {eventObject: any}): Promise<any>;
}
declare module "@salesforce/apex/eventFormController.getEventSubjectPicklist" {
  export default function getEventSubjectPicklist(): Promise<any>;
}
