@isTest
public class TestFastApprovalControllerServer {
    
    public static testMethod void TST_fastApprove(){
        
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
            LastName = 'last',
            Email = 'puser000@amamama.com',
            Username = 'puser000@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert u;
         User u1 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
            LastName = 'last1',
            Email = 'puser1000@amamama.com',
            Username = 'puser1000@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title1',
            Alias = 'alias1',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
             ManagerId = u.Id
        );
        insert u1;
        Account a = new Account(Name = 'test account',BillingCity = 'Pune');
        insert a;
        
        Fast_Approval_Config__c fas = new Fast_Approval_Config__c();
       	fas.Object_Name__c='Account';
        fas.Field_1__c = 'billingcity';
        fas.Field_2__c='Id';
        insert fas;
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(a.id);
        
        // Submit on behalf of a specific submitter
        req1.setSubmitterId(u1.Id); 
        req1.setProcessDefinitionNameOrId('test');
		req1.setSkipEntryCriteria(true);

        Approval.ProcessResult result = Approval.process(req1);
        List<ProcessInstanceWorkitem> PIWList = [SELECT ActorId,Id,ProcessInstance.TargetObjectId,ProcessInstance.TargetObject.Name,ProcessInstance.SubmittedBy.Name FROM ProcessInstanceWorkitem where ProcessInstance.TargetObjectId=:a.Id];
        system.debug('PIWList from test'+PIWList);
        /*ProcessInstance tempProcessInstance = new ProcessInstance(Status='Pending',TargetObjectId= a.Id,ActorId = u.Id); 
		insert tempProcessInstance ; */                                           
        Test.startTest();
        FastApprovalControllerServer Obj = new FastApprovalControllerServer();
        FastApprovalControllerServer.LightWeightObject cmp = new FastApprovalControllerServer.LightWeightObject();
        cmp.field1API = 'abc';
        cmp.DateSubmitted = a.CreatedDate;
        cmp.field1 = a;
        cmp.field1Label = 'tets';
        cmp.field2API = 'test';
        cmp.field2Label = 'tetst';
        cmp.field2 = a;
        cmp.title = 'tets';
        cmp.recordName = 'tetst';
        cmp.recordId = a.Id;
        cmp.recordOwner = 'owner';
        cmp.recordUrl = 'url';
        cmp.submitterName = 'name';
        string strid = a.Id;
        List<Id> idlist = new List<Id>();
        FastApprovalControllerServer.LightWeightObject lwo = new FastApprovalControllerServer.LightWeightObject();
        lwo.recordId = a.Id;
        //insert lwo;
        idlist.add(lwo.recordId);
        
        
        
        FastApprovalControllerServer.fetchData();
       	FastApprovalControllerServer.getRecordDetails('Account', u.id);
        FastApprovalControllerServer.getApprovalRecords(u.Id);
        FastApprovalControllerServer.approveRejectAction('Approve','test',a.Id);
        FastApprovalControllerServer.massApproveRejectAction('Approve','tets',JSON.serialize(idlist));
        FastApprovalControllerServer.massReassignAction(u.Id,'tets',JSON.serialize(idlist));
        FastApprovalControllerServer.getUser('searchKeyWord');
        FastApprovalControllerServer.getselectOptions();
        //FastApprovalControllerServer.ReassignAction(u1.Id,'tetst',a.Id);
        FastApprovalControllerServer.saveDataInObj('Account','Name','Name');
        FastApprovalControllerServer.DeleteData('Account');
        
        Test.stopTest();
    }
}