/********************************************************************************************
* Class:        FastApprovalControllerServer
* Description:  Server side controller Class for the FastApproval 
********************************************************************************************/
public class FastApprovalControllerServer {
    /************************************************************************
    *   Method Name: getApprovalRecords
    *   Description: Method to return object names of records for which approvals are pending for logged in User.
    ***************************************************************************/ 
    @AuraEnabled 
    public static List<String> getApprovalRecords(Id userid ){        
        
        List<String> objnameList = new List<String>(); 
        Set<String> objnameSet = new Set<String>(); 
        system.debug('userid'+userid);
        List<ProcessInstanceWorkitem> PIWList = [SELECT ActorId,Id,ProcessInstance.TargetObjectId,ProcessInstance.TargetObject.Name,ProcessInstance.SubmittedBy.Name FROM ProcessInstanceWorkitem where ActorId=:userid];
        
        for(ProcessInstanceWorkitem p : PIWList){
            String objname = (p.ProcessInstance.TargetObjectId).getSObjectType().getDescribe().getName();
            objnameSet.add(objname);
        }
        objnameList.addAll(objnameSet);
        return objnameList;          
    }
    
   /************************************************************************
    *   Method Name: approveRejectAction
    *   Description: Method to approve or reject indivisual approval record
    ***************************************************************************/   
    @AuraEnabled
    public static void approveRejectAction(String Status,String Comment, Id recId) {
        Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        req.setComments(Comment);
        req.setAction(Status);
        ProcessInstanceWorkitem pItem = [Select Id from ProcessInstanceWorkitem where ProcessInstance.TargetObjectId =: recId];
        req.setWorkitemId(pItem.Id);
        
        Approval.ProcessResult result = Approval.process(req);
        
        
    }
    
    /************************************************************************
    *   Method Name: massApproveRejectAction
    *   Description: Method to approve or reject all approval records
    ***************************************************************************/  
    @AuraEnabled
    public static void massApproveRejectAction(String Status,String Comment, string strRecords) {
        List<Id> recIdList = (List<Id>) JSON.deserialize(strRecords,List<Id>.class);
        List<ProcessInstanceWorkitem> pItemList = [Select Id from ProcessInstanceWorkitem where ProcessInstance.TargetObjectId IN: recIdList];
        for(ProcessInstanceWorkitem pItem : pItemList ){
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setComments(Comment);
            req.setAction(Status);        
            req.setWorkitemId(pItem.Id);
            Approval.ProcessResult result = Approval.process(req);
        }
        
    }
    
    /************************************************************************
    *   Method Name: massReassignAction
    *   Description: Method to reassign mass approval records
    ***************************************************************************/  
    @AuraEnabled
    public static void massReassignAction(Id assignId,String Comment, string strRecords) {
        List<Id> recIdList = (List<Id>) JSON.deserialize(strRecords,List<Id>.class);
        
        List<ProcessInstanceWorkItem> updateWorkItemList = new List<ProcessInstanceWorkItem>(); 
        List<ProcessInstanceWorkItem> workItemList = [Select p.ProcessInstance.Status, p.ProcessInstance.TargetObjectId,p.ProcessInstanceId,p.OriginalActorId,p.Id,p.ActorId
                                                      From ProcessInstanceWorkitem p where p.ProcessInstance.TargetObjectId IN :  recIdList];
        for(ProcessInstanceWorkItem piw : workItemList ){
            piw.ActorId = assignId;
            updateWorkItemList.add(piw);
        }
        //system.debug('updateWorkItemList'+updateWorkItemList);
        update updateWorkItemList;
    }
    
    /************************************************************************
    *   Method Name: ReassignAction
    *   Description: Method to reassign indivisual approval records
    ***************************************************************************/ 
    @AuraEnabled
    public static void ReassignAction(Id assignId,String Comment, Id recId) {
        
        List<ProcessInstanceWorkItem> workItemList = [Select p.ProcessInstance.Status, p.ProcessInstance.TargetObjectId,p.ProcessInstanceId,p.OriginalActorId,p.Id,p.ActorId
                                                      From ProcessInstanceWorkitem p where p.ProcessInstance.TargetObjectId = :  recId];
        system.debug('workItemList : '+workItemList);
        workItemList.get(0).ActorId  = assignId;
        
        update workItemList;
        
        
    }
    
    /************************************************************************
    *   Method Name: getUser
    *   Description: Method to fetch all users present in Org according to search word enterd in input box
    ***************************************************************************/ 
    @AuraEnabled
    public static List < User > getUser(String searchKeyWord) {
        String searchKey = searchKeyWord + '%';
        List < User > returnList = new List < User > ();
        List < User > lstOfUser = [select id, Name from User where Name LIKE: searchKey];
        
        for (User usr: lstOfUser) 
        {
            returnList.add(usr);
        }
        //system.debug('returnList : ' +returnList);
        return returnList;
    }
    
    /************************************************************************
    *   Method Name: getselectOptions
    *   Description: Method to fetch all objects present in Org
    ***************************************************************************/  
    @AuraEnabled 
    public static List<string> getselectOptions(){
        List<string> objNameList = new List<string>();
        for ( Schema.SObjectType o : Schema.getGlobalDescribe().values() )
        {
            Schema.DescribeSObjectResult objResult = o.getDescribe();
            objNameList.add(objResult.getLabel());
           // system.debug( 'Sobject: ' + objResult );
            //system.debug( 'Sobject API Name: ' + objResult.getName() );
            //system.debug( 'Sobject Label Name: ' + objResult.getLabel() );   
        }
        objNameList.sort();
        return objNameList;
    }
    
    
    
    
    /************************************************************************
    *   Method Name: getRecordDetails
    *   Description: Method to fetch all records associated to selected object and logged in user and 
    also binds record details with wrapper class fields.
    ***************************************************************************/ 
    @AuraEnabled 
    public static List<lightWeightObject> getRecordDetails(String ObjectName,Id userid){
        map<String,List<lightWeightObject>> nameRecordmap = new map<String,List<lightWeightObject>>();
        List<Fast_Approval_Config__c> facList = new List<Fast_Approval_Config__c>();
        List<String> fieldNames = new List<String>();
        Id usrId;
        String createdByName;      
                
        LightWeightObject LightWeightwrapper;
        String field1;
        String field2;
        
        facList= [Select Object_Name__c,Field_1__c,Field_2__c from Fast_Approval_Config__c where Object_Name__c =:ObjectName ];
        List<ProcessInstanceWorkitem> PIWList = [SELECT ActorId,Id,CreatedDate,ProcessInstance.TargetObjectId,ProcessInstance.TargetObject.Name,ProcessInstance.SubmittedBy.Name FROM ProcessInstanceWorkitem where ActorId=:userid];
        //system.debug('PIWList'+PIWList);
        Map<string,Set<id>> recordIdsMap = new Map<string,Set<id>>();
        for(ProcessInstanceWorkitem p : PIWList){
            
            String objname = (p.ProcessInstance.TargetObjectId).getSObjectType().getDescribe().getName();
            if(recordIdsMap.containsKey(objname)){                
                recordIdsMap.get(objname).add(p.ProcessInstance.TargetObjectId);
            }else
            {   
                recordIdsMap.put(objname, new Set<Id>{p.ProcessInstance.TargetObjectId});
            }     
        }
        set<id> setids = recordIdsMap.get(ObjectName);
        //system.debug('setids'+setids);
        
        for(Fast_Approval_Config__c fac:facList)
        {
            
            fieldNames.add(fac.Field_1__c);
            fieldNames.add(fac.Field_2__c);
            
        }
        fieldNames.add('Name');
        fieldNames.add('CreatedById');
        string query = ' SELECT ' +	      String.join( fieldNames, ', ' ) +	  ' FROM ' +ObjectName +' where id IN: setids';
       
        //system.debug('query'+query);    
 		 
		
        List<SObject> details = Database.query(query);
        for(ProcessInstanceWorkitem p : PIWList){
            for(SObject obj : details )
            {    
                if(obj.get('Id') == p.ProcessInstance.TargetObjectId){
                    usrId = (Id)obj.get('CreatedById'); 
                }
            }
        }
        List<User> usrList = [Select Id,Name from User where Id=:usrId];
        for(User u : usrList)
        {             
            createdByName = u.Name;              
        }
        //system.debug('details'+details);
        for(Fast_Approval_Config__c fac : facList)
        {
            field1 = fac.Field_1__c;
            field2 = fac.Field_2__c;
        }
        String type1=ObjectName;
        
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        
        Schema.SObjectType leadSchema = schemaMap.get(type1);
        
        Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
        String fieldLabel1;
        String fieldLabel2;
        if(field1!=null){
        fieldLabel1 = fieldMap.get(field1).getDescribe().getLabel();
        Schema.DisplayType fielddataType1 = fieldMap.get(field1).getDescribe().getType();
            }
        if(field2!=null){
        fieldLabel2 = fieldMap.get(field2).getDescribe().getLabel();
        Schema.DisplayType fielddataType2 = fieldMap.get(field2).getDescribe().getType();
        }
        for(ProcessInstanceWorkitem p : PIWList){
            
            String objname = (p.ProcessInstance.TargetObjectId).getSObjectType().getDescribe().getName();
            //system.debug('objname'+objname);
            LightWeightwrapper = new lightWeightObject();
            LightWeightwrapper.recordName = p.ProcessInstance.TargetObject.Name;
            LightWeightwrapper.recordUrl = System.Url.getSalesforceBaseURL().toExternalForm()+'/'+p.ProcessInstance.TargetObjectId;
            LightWeightwrapper.submitterName = p.ProcessInstance.SubmittedBy.Name;
            if(field1!=null){
                 LightWeightwrapper.field1API = field1 ;
                LightWeightwrapper.field1Label = fieldLabel1 ;
            }
            if(field2!=null){
                LightWeightwrapper.field2API = field2;
                LightWeightwrapper.field2Label = fieldLabel2;
            }
            LightWeightwrapper.title =  '|   Name : '+p.ProcessInstance.TargetObject.Name+' |  Submitted By : '+p.ProcessInstance.SubmittedBy.Name+' |  Date Submitted : '+p.CreatedDate;
            LightWeightwrapper.DateSubmitted = p.CreatedDate;
            LightWeightwrapper.recordId = p.ProcessInstance.TargetObjectId;
            LightWeightwrapper.recordOwner = createdByName;
            for(SObject obj : details )
            {
                // system.debug('obj'+obj.get('Id'));
                if(obj.get('Id') == p.ProcessInstance.TargetObjectId){
                    if(field1!=null){
                    LightWeightwrapper.field1 = obj.get(field1);
                    }
                    if(field2!=null){
                    LightWeightwrapper.field2 = obj.get(field2);
                    }
                    
                }
            }
            
            if(nameRecordmap.containsKey(objname)){                
                nameRecordmap.get(objname).add(LightWeightwrapper);
            }else
            {                
                nameRecordmap.put(objname, new List<lightWeightObject>{LightWeightwrapper});
            }
        }      
        
        return nameRecordmap.get(ObjectName);
    }
    
    
    
    /************************************************************************
    *   Method Name: fetchData
    *   Description: Method to fetch data from config object and display in component
    ***************************************************************************/
    @AuraEnabled 
    public static List<Fast_Approval_Config__c> fetchData(){
        return [Select Object_Name__c,Field_1__c,Field_2__c from Fast_Approval_Config__c];
    }
    
    /************************************************************************
    *   Method Name: DeleteData
    *   Description: Method to delete data from config object
    ***************************************************************************/
    @AuraEnabled 
    public static void DeleteData(string objName){
        List <Fast_Approval_Config__c> deleteobjList = new List <Fast_Approval_Config__c> ();
        deleteobjList = [SELECT id, Object_Name__c from Fast_Approval_Config__c where Object_Name__c =:objName ];
        try {
            if(!deleteobjList.isEmpty())
                delete deleteobjList;
        } catch (DmlException e) {
            // Process exception here
        }
    }
        
    /************************************************************************
    *   Method Name: saveDataInObj
    *   Description: Method to save data in config object according to users selection
    ***************************************************************************/
    @AuraEnabled 
    public static void saveDataInObj(string objName,string fld1,string fld2){
        map<String,Fast_Approval_Config__c> FASMap = new map<String,Fast_Approval_Config__c>();
        List<Fast_Approval_Config__c> FAS = new List<Fast_Approval_Config__c>();
        List<Fast_Approval_Config__c> updateFAS = new List<Fast_Approval_Config__c>();
        FAS = [Select Object_Name__c,Field_1__c,Field_2__c from Fast_Approval_Config__c];       
        
        for(Fast_Approval_Config__c f : FAS ){
            FASMap.put(f.Object_Name__c,f);
        }       
        Fast_Approval_Config__c fac = new Fast_Approval_Config__c();
        //fac.Object_Name__c = objName;
        
        if(FASMap.containsKey(objName)){
            fac = FASMap.get(objName);
            fac.Field_1__c = fld1;
            fac.Field_2__c = fld2;
            FASMap.put(fac.Object_Name__c,fac);
        }
        else{
            fac.Object_Name__c = objName;
            fac.Field_1__c = fld1;
            fac.Field_2__c = fld2;
            FASMap.put(fac.Object_Name__c,fac);
        }
        
        for(Fast_Approval_Config__c f : FASMap.values()){
            updateFAS.add(f);
        }
        try {
            if(!updateFAS.isEmpty())
                upsert updateFAS;
        } catch (DmlException e) {
            // Process exception here
        }
    }
    
    /************************************************************************
    *   Method Name: getFieldsOptions
    *   Description: Method to fetch field according to selected object
    ***************************************************************************/
    @AuraEnabled 
    public static List<string> getFieldsOptions(string objName){
        List<string> objFieldList;
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objName).getDescribe().fields.getMap();
        objFieldList = new List<String>(objectFields.keySet());
        objFieldList.sort();
        return objFieldList;
        
    }
    
    /************************************************************************
    *   Class Name: LightWeightObject
    *   Description: Wrapper class used to store information of approval record
    ***************************************************************************/
    public class LightWeightObject{
        @AuraEnabled public Id recordId {get;set;}
        @AuraEnabled public string recordUrl {get;set;}
        @AuraEnabled public string recordName {get;set;}
        @AuraEnabled public string submitterName {get;set;}
        @AuraEnabled public Object field1 {get;set;}
        @AuraEnabled public Object field2 {get;set;}
        @AuraEnabled public String field1API {get;set;}
        @AuraEnabled public String field2API {get;set;}
        @AuraEnabled public String field1Label {get;set;}
        @AuraEnabled public String field2Label {get;set;}
        @AuraEnabled public String title {get;set;}
        @AuraEnabled public String recordOwner {get;set;}
        @AuraEnabled public DateTime DateSubmitted {get;set;}
        @AuraEnabled public Boolean selected = false ;
    }      
    
}