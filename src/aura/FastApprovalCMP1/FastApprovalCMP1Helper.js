({
    //To fetch all objects in org
	fetchObjects : function(component,elementId) {
        debugger;
		var action = component.get("c.getselectOptions");
        var opts = [];
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
                
                if (allValues != undefined && allValues.length > 0) {
                    opts.push({
                        class: "optionClass",
                        label: "--- None ---",
                        value: ""
                    });
                }
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        class: "optionClass",
                        label: allValues[i],
                        value: allValues[i]
                    });
                }
                component.find(elementId).set("v.options", opts);
            }
        });
        $A.enqueueAction(action);    
	},
    
    //To fetch all fields present on object
    fetchFields: function(component,elementId1,elementId2,objName) {
		var action = component.get("c.getFieldsOptions");
        action.setParams({
            "objName": objName           
        });
        var opts = [];
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
                
                if (allValues != undefined && allValues.length > 0) {
                    opts.push({
                        class: "optionClass",
                        label: "--- None ---",
                        value: ""
                    });
                }
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        class: "optionClass",
                        label: allValues[i],
                        value: allValues[i]
                    });
                }
                component.find(elementId1).set("v.options", opts);
                component.find(elementId2).set("v.options", opts);
            }
        });
        $A.enqueueAction(action);    
	},
    
    //To save data into object
    saveDataToObj : function(component,objName,fld1,fld2) {
		var action = component.get("c.saveDataInObj");
        action.setParams({
            "objName": objName,
            "fld1":fld1,
            "fld2":fld2
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                //Nothing to do
            }
        });
        $A.enqueueAction(action);    
	},
})