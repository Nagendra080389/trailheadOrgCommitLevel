({
	fetchDetails: function(component,ObjectName,userid) {
        debugger;
        var action = component.get("c.getRecordDetails");
        action.setParams({
            "userid":userid,
            "ObjectName":ObjectName
        });
        action.setCallback(this , function(response){
             if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
                 if(allValues!= undefined ){
                     
                     component.set("v.objInfoRecords",allValues);
                     
                       }
                
             }
        });
        $A.enqueueAction(action);
    }
})