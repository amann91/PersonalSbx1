({
    getReportRows : function(component) {
        // Load report data
        var action = component.get("c.getReportRows");
        var self = this;
        
        action.setCallback(this, function(a){
            debugger;
            var result = a.getReturnValue();
            component.set("v.row", a.getReturnValue());

            // Display toast message to indicate load status
            //var toastEvent = $A.get("e.force:showToast");
            /*if(action.getState() ==='SUCCESS'){
                toastEvent.setParams({
                    "title": "Success!",
                    "message": " Your report has been loaded successfully."
                });
            }else{
                toastEvent.setParams({
                    "title": "Error!",
                    "message": " Something has gone wrong."
                });
            }
            toastEvent.fire();*/
        });
         $A.enqueueAction(action);
    },
 	loadResources : function() {
    	this.loadCSS('/resource/jquery_mobile_145/jquery.mobile-1.4.5.min.css', function() {
		});
		this.loadJS('/resource/jquery_mobile_145/jquery-1.11.2.min.js', function() {
		});
		this.loadJS('/resource/jquery_mobile_145/jquery.mobile-1.4.5.min.js', function() {
		});
  	},
    loadJS : function(source, callback) {
        var loadScript = document.createElement('script');
        loadScript.setAttribute('src', source);
        loadScript.onload = callback;
        document.head.appendChild(loadScript);
    },
    loadCSS : function(source, callback) {
        var fileref = document.createElement('link');
        fileref.setAttribute("rel", "stylesheet");
        fileref.setAttribute("type", "text/css");
        fileref.setAttribute("href", source);
        fileref.onload = callback;
        document.head.appendChild(fileref);
    }    
})