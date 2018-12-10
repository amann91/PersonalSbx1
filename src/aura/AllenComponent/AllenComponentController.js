({
	doStuff: function (component, event, helper) {
	var myMsg = component.find("message").get("v.value");
	var outputArea = component.find("outputMessage");
	var newMessage = "Your message: " + myMsg;
	window.alert("Your message " + myMsg); 
	
	outputArea.set("v.value", newMessage);5
	}
})