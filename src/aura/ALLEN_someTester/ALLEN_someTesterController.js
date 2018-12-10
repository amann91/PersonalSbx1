({
    doSomethingOnClick : function(component, event, helper) {
        debugger;
        var valueIWantToChange = component.get("v.valueToChange");
        //alert("You want to change" +  " " + valueIWantToChange)
        component.set("v.valueHasBeenChanged", valueIWantToChange);
    }
})