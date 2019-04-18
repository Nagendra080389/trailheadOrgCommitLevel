({
    //Called when component is loaded. Used to fetch Object names of records wwhich are pending for approval.
    doInit : function(component, event, helper) {        
        var userid = $A.get("$SObjectType.CurrentUser.Id");
        helper.fetchApprovalRecord(component,userid);
    },
    
    
    
    showHide:function(component, event, helper) {
        var objName = event.getSource().get("v.value");
        var userid = $A.get("$SObjectType.CurrentUser.Id");       
       	//helper.fetchDetails(component,objName,userid);
        var appEvent = $A.get("e.c:WrapperRecordEvent");
        appEvent.setParams({
            "WrapperRecord" : objName,
            "userId" : userid
        });
        appEvent.fire(); 
               
    }
})