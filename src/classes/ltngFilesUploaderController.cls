public class ltngFilesUploaderController {
/*
* @description Supports ltngFileUploader.cmp
* @author Allen Mann, Slalom
* @date 07/02/2018
*/
    @AuraEnabled
    public static List<String> getDocType(Id objRecordId) {
        List<String> options = new List<String> ();
        Schema.SObjectType objectType = objRecordId.getSobjectType();
        
        String noneLabel = '--None--';
        options.add(noneLabel);
        
        String fieldDefault = (String) ContentVersion.Document_Type__c.getDescribe().getDefaultValue();
        
        Schema.DescribeFieldResult fieldResult = ContentVersion.Document_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        for( Schema.PicklistEntry f : ple)
        {
            options.add(f.getValue());
        } 
        
        return options;
    }
    
    @AuraEnabled
    public static void updateCvDocType(List<String> uploadedDocs, String docType, Id recId) {
        
        Set<String> documentIds = new Set<String>();
        for(String docId : uploadedDocs){
            documentIds.add(docId);
        }
        
        List<ContentVersion> versions = new List<ContentVersion> ();
        Set<ID> linkedEntityIds = new Set<Id> ();
        
        for (ContentDocumentLink cdl :[SELECT Id
                                       , LinkedEntityId
                                       , ContentDocument.Title
                                       , ContentDocument.Description
                                       , ContentDocumentId
                                       , ContentDocument.LatestPublishedVersionId
                                       FROM ContentDocumentLink
                                       WHERE LinkedEntityId = :recId AND ContentDocumentId IN :documentIds])
        {
            ContentVersion version = new ContentVersion();
            version.id = cdl.ContentDocument.LatestPublishedVersionId;
            version.Title = docType + ' - ' + cdl.ContentDocument.Title;
            //version.description = 'Notes?';
            version.Document_Type__c = docType;
            versions.add(version);
            linkedEntityIds.add(cdl.LinkedEntityId);
        }
        
        if (!linkedEntityIds.isEmpty()) {
            //updateRelatedRecordFileTypes(linkedEntityIds, docType);
        }
        update versions;
    }
    
}