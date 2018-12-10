({
	getLinkedObject: function(component, event, helper) {
	debugger;
        var recId = component.get("v.recordId");
        var action = component.get("c.getRenewalId");
        action.setParams({
			"relatedRecord" : recId
		});
        action.setCallback(this, function(response) {
		debugger;
            var state = response.getState();
			var responseVal = response.getReturnValue();
            if (state === "SUCCESS") {
				component.set("v.renewalId", responseVal);
				if(responseVal != null){
					component.set("v.showCloneFilesBtn", true);
				}
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

	showSuccessToast : function(component) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success Message',
            message: 'Allowed Document Types have been cloned from Renewed Opportunity',
            duration:'10000',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
        });
        toastEvent.fire();
    },
})