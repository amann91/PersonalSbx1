({
    afterRender: function (component, helper) {
        this.superAfterRender();
        //debugger;
        var data = component.get("v.tableData");
        component.set("v.richtext", component.get("v.tableData"));
        
    },
})