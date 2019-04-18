({
    //To fetch object Names
    fetchApprovalRecord : function(component,userid) {
        var action = component.get("c.getApprovalRecords");
        var opts = [];
        action.setParams({
            "userid":userid
        });
        action.setCallback(this , function(response){
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
               
                if(allValues!= undefined && allValues.length > 0){
                    opts.push({
                        class: "optionClass",
                        label: "--- None ---",
                        value: ""
                    });                    
                }
                else if(allValues==''){
                    component.set("v.showMessage",true);
                    component.set("v.title","No Records present for approval");
                    component.set("v.severity","warning");
                    //component.set("v.uiMessage","No Records present for approval ");
                }
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        class: "optionClass",
                        label: allValues[i],
                        value: allValues[i]
                    });
                }
                component.find("objName").set("v.options", opts);
                
            }
        });
        $A.enqueueAction(action);
    }   
    
})