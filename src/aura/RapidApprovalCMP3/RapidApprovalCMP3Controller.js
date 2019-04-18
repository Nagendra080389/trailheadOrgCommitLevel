({
    doInit : function(component, event, helper) {
        var urlLink = event.getParam("urlLink");
        component.set("v.linkOfRecord",urlLink);
        
        //window.location.href = event.getParam("urlLink");
        
        //window.open(event.getParam("urlLink"),'_top');
    },
    
    ShowDetails : function(component, event, helper) {
        component.set("v.toggle",true)
        var objName = event.getParam("WrapperRecord");
        var userId = event.getParam("userId");
        helper.fetchDetails(component,objName,userId);
        
    },
    
    selectAll : function(component, event, helper) {        
        alert('select all');
    },
    
    
    
})