({
    //to fetch all records related to object and assigned to logged in user
    fetchDetails : function(component,ObjectName,userid) {
        var action = component.get("c.getRecordDetails");
        action.setParams({
            "ObjectName" : ObjectName,
            "userid" : userid
        });
        action.setCallback(this , function(response){   
            alert(response.getState());
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
                if(allValues!= undefined ){
                    component.set("v.objInfoRecords",allValues);
                }
                
            }
            if (response.getState() == "ERROR") {
                window.location.reload();
            }
        });
        $A.enqueueAction(action);
    },
    
    //to mass approve or reject
    setMassActionAppRej:function(component,status,comment,records){
        var action = component.get("c.massApproveRejectAction");
        var recids = [];
        for(var i =0;i<records.length;i++){
            recids.push(records[i].recordId);
        }
        action.setParams({
            "Status":status,
            "Comment":comment,
            "strRecords" : JSON.stringify(recids)
        });
        action.setCallback(this , function(response){
            if (response.getState() == "SUCCESS") {
                this.setCloseModal(component);
                /* component.set("v.showMessage",true);
                if(status=='Approve'){
                    component.set("v.title",'Approved');
                    component.set("v.severity",'confirm');
                    component.set("v.uiMessage",component.get("v.recordName")+' has been Approved Successfully');
                }
                else if (status=='Reject'){
                    component.set("v.title",'Rejected');
                    component.set("v.severity",'error');
                    component.set("v.uiMessage",component.get("v.recordName")+' has been Rejected');
                }*/
            }
        });
        $A.enqueueAction(action);
        var appEvent = $A.get("e.c:WrapperRecordEvent");
        appEvent.setParams({
            "WrapperRecord" : component.get("v.objname"),
            "userId" : component.get("v.userId")
        });
        appEvent.fire(); 
    },
    
    //to mass reassign
    setMassReassign:function(component,assignId,records,comment){
        var action = component.get("c.massReassignAction");
        var recids = [];
        for(var i =0;i<records.length;i++){
            recids.push(records[i].recordId);
        }
        //alert(JSON.stringify(recids));
        action.setParams({
            "assignId":assignId,
            "Comment":comment,
            "strRecords" : JSON.stringify(recids)
        });
        action.setCallback(this , function(response){
            if (response.getState() == "SUCCESS") {
                this.setCloseModal(component);
                /*component.set("v.showMessage",true);                
                component.set("v.title",'Reassigned');
                component.set("v.severity",'warning');
                component.set("v.uiMessage",'All records on '+component.get("v.objname")+' has been reassigned Successfully to '+component.get("v.selectedRecord.Name"));
                       */        
            }
        });
        $A.enqueueAction(action);
        var appEvent = $A.get("e.c:WrapperRecordEvent");
        appEvent.setParams({
            "WrapperRecord" : component.get("v.objname"),
            "userId" : component.get("v.userId")
        });
        appEvent.fire(); 
        
    },
    
    //to reassign
    setReassign: function(component,assignId,recId,comment){
        var action = component.get("c.ReassignAction");
        action.setParams({
            "assignId":assignId,
            "Comment":comment,
            "recId" : recId
        });
        action.setCallback(this , function(response){
            if (response.getState() == "SUCCESS") {
                this.setCloseModal(component);
                component.set("v.showMessage",true);
                
                component.set("v.title",'Reassigned');
                component.set("v.severity",'warning');
                component.set("v.uiMessage",component.get("v.recordName")+' has been reassigned Successfully to '+component.get("v.selectedRecord.Name"));
                
                
            }
        });
        $A.enqueueAction(action);
        var appEvent = $A.get("e.c:WrapperRecordEvent");
        appEvent.setParams({
            "WrapperRecord" : component.get("v.objname"),
            "userId" : component.get("v.userId")
        });
        appEvent.fire(); 
    },
    
    //to close modal
    setCloseModal: function(component){
        component.set("v.OpenAorR", false);
        component.set("v.OpenReassign", false);
        component.set("v.OpenMassReassign", false);
        component.set("v.massOpenAorR",false);
    },
    
    //to approve or reject 
    setActionAppRej: function(component,status,comment,recId){
        var action = component.get("c.approveRejectAction");
        action.setParams({
            "Status":status,
            "Comment":comment,
            "recId" : recId
        });
        action.setCallback(this , function(response){
            if (response.getState() == "SUCCESS") {
                this.setCloseModal(component);
                component.set("v.showMessage",true);
                if(status=='Approve'){
                    component.set("v.title",'Approved');
                    component.set("v.severity",'confirm');
                    component.set("v.uiMessage",component.get("v.recordName")+' has been Approved Successfully');
                }
                else if (status=='Reject'){
                    component.set("v.title",'Rejected');
                    component.set("v.severity",'error');
                    component.set("v.uiMessage",component.get("v.recordName")+' has been Rejected');
                }
            }
        });
        $A.enqueueAction(action);
        var appEvent = $A.get("e.c:WrapperRecordEvent");
        appEvent.setParams({
            "WrapperRecord" : component.get("v.objname"),
            "userId" : component.get("v.userId")
        });
        appEvent.fire(); 
    },
    
    
    onclickOfMenu:function(component,value,label) {
        if(label== 'Approve/Reject'){
            this.openARModal(component,value,label)
        }
        else if(label== 'Reassign'){
            this.openReassignModal(component,value,label)
        }
    },
    
    openReassignModal:function(component, value, label) { 
        component.set("v.OpenReassign",true);
        
    },
    
    openARModal:function(component, value, label) { 
        component.set("v.OpenAorR",true);
        
    },
    
    //to search user on basis of entered data
    searchHelper : function(component,event,getInputkeyWord) {
        // call the apex class method 
        var action = component.get("c.getUser");
        // set param to method  
        action.setParams({
            'searchKeyWord': getInputkeyWord
        });
        // set a callBack    
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                
                // if storeResponse size is equal 0 ,display No Result Found... message on screen.
                if (storeResponse.length == 0) {
                    component.set("v.Message", 'No Result Found...');
                } else {
                    component.set("v.Message", 'Search Result...');
                }
                
                // set searchResult list with return value from server.
                component.set("v.listOfSearchRecords", storeResponse);
            }
            
        });
        // enqueue the Action  
        $A.enqueueAction(action);
        
    }
})