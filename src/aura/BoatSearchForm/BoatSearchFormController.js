({
    doInit: function(component, event, helper){
        var opts = [
            { value: "Red", label: "Red" },
            { value: "Green", label: "Green" },
            { value: "Blue", label: "Blue" }
        ];
        component.set("v.options", opts);  
    },
    
    createNew : function(component, event, helper) {
        
    },
})