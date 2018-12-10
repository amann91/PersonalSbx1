({
    doInit: function(component, event, helper) {
        //var oppId = component.get("v.recordId");
        //Get values for doc type picklist
        debugger;
        var recId = component.get("v.recordId");
        var action = component.get("c.getDocType");
        action.setParams({objRecordId : recId});	
        var inputsel = component.find("DynamicDocType");
        debugger;
        var opts=[];
        action.setCallback(this, function(a) {
            for(var i=0;i< a.getReturnValue().length;i++){
                opts.push({"class": "optionClass", label: a.getReturnValue()[i], value: a.getReturnValue()[i]});
            }
            //action.setParams({"objRecordId" : recId})
            
            inputsel.set("v.options", opts);
            
        });
        $A.enqueueAction(action); 
		//helper.getLinkedObject(component, event, helper);
    },
    
    handlePicklistClick: function (component, event) {
        var filesUploader = component.find("uploadComponent");
        filesUploader.set("v.disabled", false);
    },
    
    handleUploadFinished: function (component, event, helper) {
        // uploaded files object
        debugger;
        var files = event.getParam("files");
        var uploadedFiles = [];
        for(var file in files){
            uploadedFiles.push(files[file].documentId);
        }
        
        //get selected doc type
        var inputSelect = component.find("DynamicDocType");
        var docTypeSelected = inputSelect.get("v.value");
        
        //call server to update the new doc with the selected doc type
        var recId = component.get("v.recordId");
        var action = component.get("c.updateCvDocType");
        action.setParams({uploadedDocs: uploadedFiles, docType : docTypeSelected, recId : recId});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var filesUploader = component.find("uploadComponent");
                filesUploader.set("v.disabled", true);
                $A.get('e.force:refreshView').fire();
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                    errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action); 
    },

	
})