({
    //called when component is loaded to fetch all details
    doInit : function(component, event, helper) {
        var action = component.get("c.fetchData");
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {             
                component.set("v.details", response.getReturnValue());                
            }
        });
        $A.enqueueAction(action);    
    },
    
    //to delete record
    DeleteRecord : function(component, event, helper) {        
        var action = component.get("c.DeleteData");
        action.setParams({
            "objName": event.target.value
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {                
                //do something
            }
        });
        $A.enqueueAction(action); 
        var appEvent = $A.get("e.c:ConfigDetailsEvent");        
        appEvent.fire(); 
    }
})