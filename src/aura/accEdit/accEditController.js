({
    handleSaveRecord: function(component, event, helper) {
        component.find("recordEditor").saveRecord(function(saveResult) {
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                // record is saved successfully
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Saved",
                    "message": "The record was saved."
                });
                resultsToast.fire();
            } else if (saveResult.state === "INCOMPLETE") {
                // handle the incomplete state
                cmp.set("v.recordSaveError", errMsg);
                
            } else if (saveResult.state === "ERROR") {
                // handle the error state
                cmp.set("v.recordSaveError", errMsg);
                
            } else {
                console.log('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
            }
        });
    }
})