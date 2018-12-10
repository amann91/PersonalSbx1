({
    doInit : function(component, event, helper) {
        helper.getCrewMembers(component, event);
        helper.getCompsFullList(component, event);
        
    },
    
    afterScriptsLoaded : function(component, event, helper){
        //alert("Charts API Loaded");
        component.set("v.ready", true);
        //helper.createChart(component);
    },
    
    iterationLoaded : function(component, event, helper){
    	debugger;
        //("loaded");
        helper.buildTable(component, event);
    },
    
})