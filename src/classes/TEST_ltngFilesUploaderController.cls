@isTest
public class TEST_ltngFilesUploaderController {
    private static Account a;
    private static Opportunity opp;
    
    @isTest
    public static void testFilesUploader() {    
        //setup and test files uploader
        opp = new Opportunity();
        opp.Name = 'Test Opportunity';
        opp.StageName = 'Prospecting';
        opp.CloseDate = system.today();
        insert opp;
        
        Id documentID = consutructFiles(opp.Id);
    }
    
    
    private static Id consutructFiles(Id opp) {
        List<String> documentTypesAvailable = ltngFilesUploaderController.getDocType(opp);
        ContentVersion contentVersion_1 = new ContentVersion(
            Title = 'slalomTest',
            Document_Type__c = documentTypesAvailable[1],
            PathOnClient = 'slalomTest.jpg',
            VersionData = Blob.valueOf('slalomTest Content'),
            IsMajorVersion = true
        );
        insert contentVersion_1;
        
        List<String> docsToUpdate = new List<String>();
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersion_1.Id].ContentDocumentId;
        cdl.LinkedEntityId = opp;
        cdl.ShareType = 'V';
        insert cdl;
        docsToUpdate.add(cdl.ContentDocumentId);
        
        ContentVersion contentVersion_2 = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersion_1.Id LIMIT 1];
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        Id documentId = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument LIMIT 1].Id;
        
        ltngFilesUploaderController.updateCvDocType(docsToUpdate, documentTypesAvailable[1], opp);
        
        System.assertEquals(documents.size(), 1);
        System.assertEquals(documents[0].Id, contentVersion_2.ContentDocumentId);
        System.assertEquals(documents[0].LatestPublishedVersionId, contentVersion_2.Id);
        System.assertEquals(documents[0].Title, contentVersion_2.Title);
        
        return documents[0].Id;
    }
}