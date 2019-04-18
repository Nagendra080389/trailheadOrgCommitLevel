({
    //called on load of component. Fetch all records associated with selected object and assigned to logged in User.
    doInit : function(component, event, helper) {        
        var objName = event.getParam("WrapperRecord");
        var userId = event.getParam("userId");
        component.set("v.objname",objName);
        component.set("v.Comment",'');
        component.set("v.SearchKeyWord",'');
        component.set("v.userId",userId);
        alert(component.get("v.objname"));
        if(component.get("v.objname")!='' || component.get("v.objname")!=undefined || component.get("v.objname")!='---None---' ){
            component.set("v.showAccordian",true);
        }
        
        helper.fetchDetails(component,objName,userId);
        
        
    },
    
    //To open Modal when clicked on reassigne all
    openMassReassignModal:function(component, event, helper) {
        
        component.set("v.OpenMassReassign",true);
    },
    
    //Called when approve button clicked on modal of mass approve/reject
    massApprove:function(component, event, helper){
        helper.setMassActionAppRej(component,'Approve',component.get("v.Comment"),component.get("v.objInfoRecords"));
    },
    
    //Called when reject button clicked on modal of mass approve/reject
    massReject:function(component, event, helper){
        helper.setMassActionAppRej(component,'Reject',component.get("v.Comment"),component.get("v.objInfoRecords"));
    },
    
    //Called when reassign button clicked on modal of mass reassign
    massReassign:function(component, event, helper) {        
        helper.setMassReassign(component,component.get("v.selectedRecord.Id"),component.get("v.objInfoRecords"),component.get("v.Comment"));
    },
    
    //To open Modal when clicked on Approve/Reject all
    openMassApproveRejectModal:function(component, event, helper) {
        component.set("v.massOpenAorR",true);
    },
    
    //Called when approve button clicked on modal
    Approve: function(component, event, helper) {
        helper.setActionAppRej(component,'Approve',component.get("v.Comment"),component.get("v.recId"));
    },
    
    //Called when reject button clicked on modal
    Reject: function(component, event, helper) {
        helper.setActionAppRej(component,'Reject',component.get("v.Comment"),component.get("v.recId"));
    },
    
    //Called when reassign button clicked on modal
    Reassign: function(component, event, helper) {
        helper.setReassign(component,component.get("v.selectedRecord.Id"),component.get("v.recId"),component.get("v.Comment"));
    },
    
    //Called when any button on menu is clicked i.e. Approve/Reject or Reassigned 
    MenuClicked: function(component, event, helper) {
        var parcedValue = event.getParam("value").split(',');
        var value = parcedValue[0];
        var label = parcedValue[1];
        var recordname = parcedValue[2];
        var recordOwner = parcedValue[3];
        component.set("v.recId",value);
        component.set("v.recordName",recordname);
        component.set("v.recordOwner",recordOwner);
        helper.onclickOfMenu(component,value,label)
        //alert('value : '+value+'  label: '+label);        
        
    },
    
    //To close Model
    closeModel : function(component, event, helper) { 
        helper.setCloseModal(component);        
    },
    
    //when value entered in approver input box
    keyPressController : function(component, event, helper) {
        // get the search Input keyword   
        var getInputkeyWord = component.get("v.SearchKeyWord");
        // check if getInputKeyWord size id more then 0 then open the lookup result List and 
        // call the helper 
        // else close the lookup result List part.   
        if( getInputkeyWord.length > 0 ){
            var forOpen = component.find("searchRes");
            $A.util.addClass(forOpen, 'slds-is-open');
            $A.util.removeClass(forOpen, 'slds-is-close');
            helper.searchHelper(component,event,getInputkeyWord);
        }
        else{  
            component.set("v.listOfSearchRecords", null ); 
            var forclose = component.find("searchRes");
            $A.util.addClass(forclose, 'slds-is-close');
            $A.util.removeClass(forclose, 'slds-is-open');
        }
        
    },
    
    // function for clear the Record Selection 
    clear :function(component,event,heplper){
        
        var pillTarget = component.find("lookup-pill");
        var lookUpTarget = component.find("lookupField"); 
        
        $A.util.addClass(pillTarget, 'slds-hide');
        $A.util.removeClass(pillTarget, 'slds-show');
        
        $A.util.addClass(lookUpTarget, 'slds-show');
        $A.util.removeClass(lookUpTarget, 'slds-hide');
        
        component.set("v.SearchKeyWord",null);
        component.set("v.listOfSearchRecords", null );
    },
    
    // This function call when the end User Select any record from the result list.   
    handleComponentEvent : function(component, event, helper) {
        
        // get the selected Account record from the COMPONETN event 	 
        var selectedUserGetFromEvent = event.getParam("userByEvent");
        
        component.set("v.selectedRecord" , selectedUserGetFromEvent); 
        
        var forclose = component.find("lookup-pill");
        $A.util.addClass(forclose, 'slds-show');
        $A.util.removeClass(forclose, 'slds-hide');
        
        
        var forclose = component.find("searchRes");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open');
        
        var lookUpTarget = component.find("lookupField");
        $A.util.addClass(lookUpTarget, 'slds-hide');
        $A.util.removeClass(lookUpTarget, 'slds-show');  
        
    }
})