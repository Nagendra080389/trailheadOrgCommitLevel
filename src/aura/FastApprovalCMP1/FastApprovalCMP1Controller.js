({
    //Called when component is loaded
	doInit : function(component, event, helper) {
		helper.fetchObjects(component,'objName');
	},
    
    //populate fields according to selection of object
    selectField : function(component, event, helper) {        
        component.set("v.ObjectName",event.getSource().get("v.value"));
		helper.fetchFields(component,'field1','field2',event.getSource().get("v.value"));
	},
    
    //set field 1
    saveField1 : function(component, event, helper) {
        component.set("v.Field1",event.getSource().get("v.value"));
	},
    
    //set field 2
    saveField2 : function(component, event, helper) {
        component.set("v.Field2",event.getSource().get("v.value"));
	},
    
    //To save data
    SaveData : function(component, event, helper) {
		helper.saveDataToObj(component,component.get("v.ObjectName"),component.get("v.Field1"),component.get("v.Field2"));
        var appEvent = $A.get("e.c:ConfigDetailsEvent");        
        appEvent.fire(); 
	},
})