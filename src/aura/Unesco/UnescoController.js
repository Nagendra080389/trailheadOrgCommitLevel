({

    doInit: function(component, event, helper) {
            /*component.find("contactRecordCreator").getNewRecord(
                "Contact", // sObject type (entityApiName)
                null, // recordTypeId
                false, // skip cache?
                $A.getCallback(function() {
                    var rec = component.get("v.newContact");
                    var error = component.get("v.newContactError");
                    if(error || (rec === null)) {
                        console.log("Error initializing record template: " + error);
                    }
                    else {
                        console.log("Record template initialized: " + rec.sobjectType);
                    }
                })
            );*/
            console.log();
        },


	myAction : function(component, event, helper) {
		
	}
})