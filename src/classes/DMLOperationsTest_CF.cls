/**
 * Test class for DMLOperationsClass_CF.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
@isTest(seeAllData = false)
public without sharing class DMLOperationsTest_CF {
    
    //Private variables.
    private static DMLOperationResultClass_CF objResults;
    private static Lead objTestLead;
    
    /**
     * Method that prepares all the data to be used on the different test methods.
     */
    @testSetup
    static void setup() {
        objTestLead = new Lead();
        objTestLead.LastName = 'Test Lead';
        DMLOperationsClass_CF.insertRecord(objTestLead);
     }
    
    /**
     * This method tests all the methods that Insert records.
     */
    static testMethod void insertMethods() {
        Test.startTest();
        
        //We first the most simple scenario.
        Lead objLead = new Lead();
        objLead.LastName = 'Test';
        DMLOperationsClass_CF.insertRecord(objLead);
        System.assert(objLead.Id != null, 'Unsuccessful insertion: ' + objLead.Id);
        
        //Now we test the rest of the available methods.
        objLead.Id = null;
        DMLOperationsClass_CF.insertRecord(objLead);
        System.assert(objLead.Id != null, 'Unsuccessful insertion: ' + objLead.Id);
        objLead.Id = null;
        DMLOperationsClass_CF.insertRecord(objLead, true, true, 'Record inserted successfuly.', ApexPages.Severity.INFO);
        System.assert(objLead.Id != null, 'Unsuccessful insertion: ' + objLead.Id);
        objLead.Id = null;
        List<String> lstTriggers = new List<String>();
        lstTriggers.add(Account.class.toString());
        DMLOperationsClass_CF.insertRecord(objLead, true, true, null, null, lstTriggers);
        DMLOperationsClass_CF.shouldStopTriggerExecution(Lead.class.toString());
        System.assert(objLead.Id != null, 'Unsuccessful insertion: ' + objLead.Id);
        List<Lead> lstLeads = new List<Lead>();
        lstLeads.add(objLead);
        DMLOperationsClass_CF.insertRecords(lstLeads, lstTriggers);
        objLead.Id = null;
        List<Lead> lstLeads2 = new List<Lead>();
        lstLeads2.add(objLead);
        DMLOperationsClass_CF.insertRecords(lstLeads, true);
        System.assert(objLead.Id != null, 'Unsuccessful insertion: ' + objLead.Id);
        
        //Finally, we try an exception scenario.
        DMLOperationsClass_CF.insertRecord(objLead);
        Test.stopTest();
    }
    
    /**
     * This method tests all the methods that Update records.
     */
    static testMethod void updateMethods() {
        objResults = new DMLOperationResultClass_CF();
        objTestLead = [SELECT Id FROM Lead LIMIT 1];
        Test.startTest();
        
        //We first the most simple scenario.
        objTestLead.LastName = 'Test 2';
        objResults = DMLOperationsClass_CF.updateRecord(objTestLead);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(objResult.boolIsSuccess, 'Unsuccessful update: ' + objResult.boolIsSuccess);
        }
        
        
        //Now we test the rest of the available methods.
        objTestLead.LastName = 'Test 3';
        objResults = DMLOperationsClass_CF.updateRecord(objTestLead, true);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(objResult.boolIsSuccess, 'Unsuccessful update: ' + objResult.boolIsSuccess);
        }
        objTestLead.LastName = 'Test 4';
        objResults = DMLOperationsClass_CF.updateRecord(objTestLead, true, true, 'Record updated successfuly.', ApexPages.Severity.INFO);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(objResult.boolIsSuccess, 'Unsuccessful update: ' + objResult.boolIsSuccess);
        }
        objTestLead.LastName = 'Test 5';
        List<String> lstTriggers = new List<String>();
        lstTriggers.add(Account.class.toString());
        objResults = DMLOperationsClass_CF.updateRecord(objTestLead, true, true, null, null, lstTriggers);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(objResult.boolIsSuccess, 'Unsuccessful update: ' + objResult.boolIsSuccess);
        }
        List<Lead> lstLeads = new List<Lead>();
        lstLeads.add(objTestLead);
        DMLOperationsClass_CF.updateRecords(lstLeads, lstTriggers);
        
        //Finally, we try an exception scenario.
        DMLOperationsClass_CF.deleteRecord(objTestLead);
        objResults = DMLOperationsClass_CF.updateRecord(objTestLead);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(!objResult.boolIsSuccess, 'Successful update: ' + objResult.boolIsSuccess);
        }
        Test.stopTest();
    }
    
    /**
     * This method tests all the methods that Delete and Undelete records.
     */
    static testMethod void deleteAndUndeleteMethods() {
        objResults = new DMLOperationResultClass_CF();
        objTestLead = [SELECT Id FROM Lead LIMIT 1];
        Test.startTest();
        
        //We first the most simple scenario.
        objResults = DMLOperationsClass_CF.deleteRecord(objTestLead);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(objResult.boolIsSuccess, 'Unsuccessful update: ' + objResult.boolIsSuccess);
        }
        objResults = DMLOperationsClass_CF.undeleteRecord(objTestLead);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(objResult.boolIsSuccess, 'Unsuccessful update: ' + objResult.boolIsSuccess);
        }
        
        
        //Now we test the rest of the available methods.
        objResults = DMLOperationsClass_CF.deleteRecord(objTestLead, true);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(objResult.boolIsSuccess, 'Unsuccessful deletion: ' + objResult.boolIsSuccess);
        }
        objResults = DMLOperationsClass_CF.undeleteRecord(objTestLead, true);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(objResult.boolIsSuccess, 'Unsuccessful undeletion: ' + objResult.boolIsSuccess);
        }
        objResults = DMLOperationsClass_CF.deleteRecord(objTestLead, true, true, 'Record updated successfuly.', ApexPages.Severity.INFO);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(objResult.boolIsSuccess, 'Unsuccessful deletion: ' + objResult.boolIsSuccess);
        }
        objResults = DMLOperationsClass_CF.undeleteRecord(objTestLead, true, true, 'Record updated successfuly.', ApexPages.Severity.INFO);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(objResult.boolIsSuccess, 'Unsuccessful undeletion: ' + objResult.boolIsSuccess);
        }
        List<String> lstTriggers = new List<String>();
        lstTriggers.add(Account.class.toString());
        objResults = DMLOperationsClass_CF.deleteRecord(objTestLead, true, true, null, null, lstTriggers);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(objResult.boolIsSuccess, 'Unsuccessful deletion: ' + objResult.boolIsSuccess);
        }
        objResults = DMLOperationsClass_CF.undeleteRecord(objTestLead, true, true, null, null, lstTriggers);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(objResult.boolIsSuccess, 'Unsuccessful undeletion: ' + objResult.boolIsSuccess);
        }
        
        //Finally, we try an exception scenario.
        objResults = DMLOperationsClass_CF.undeleteRecord(objTestLead, true, true, null, null, lstTriggers);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(!objResult.boolIsSuccess, 'Successful undeletion: ' + objResult.boolIsSuccess);
        }
        DMLOperationsClass_CF.deleteRecord(objTestLead, true, true, null, null, lstTriggers);
        objResults = DMLOperationsClass_CF.deleteRecord(objTestLead, true, true, null, null, lstTriggers);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(!objResult.boolIsSuccess, 'Successful deletion: ' + objResult.boolIsSuccess);
        }
        objTestLead.Id = null;
        objResults = DMLOperationsClass_CF.undeleteRecord(objTestLead, false, true, null, null, lstTriggers);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(!objResult.boolIsSuccess, 'Successful undeletion: ' + objResult.boolIsSuccess);
        }
        objResults = DMLOperationsClass_CF.deleteRecord(objTestLead, false, true, null, null, lstTriggers);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(!objResult.boolIsSuccess, 'Successful deletion: ' + objResult.boolIsSuccess);
        }
        Test.stopTest();
    }
    
    /**
     * This method tests all the methods that Upsert records.
     */
    static testMethod void upsertMethods() {
        objResults = new DMLOperationResultClass_CF();
        objTestLead = [SELECT Id FROM Lead LIMIT 1];
        Lead objLead = new Lead();
        objLead.LastName = 'Test';
        Test.startTest();
        
        //We first the most simple scenario.
        objTestLead.LastName = 'Test 2';
        objResults = DMLOperationsClass_CF.upsertRecord(objTestLead);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(objResult.boolIsSuccess, 'Unsuccessful update: ' + objResult.boolIsSuccess);
        }
        objResults = DMLOperationsClass_CF.upsertRecord(objLead);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(objResult.boolIsSuccess, 'Unsuccessful insert: ' + objResult.boolIsSuccess);
        }
        
        //Now we test the rest of the available methods.
        objTestLead.LastName = 'Test 3';
        objResults = DMLOperationsClass_CF.upsertRecord(objTestLead, true);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(objResult.boolIsSuccess, 'Unsuccessful update: ' + objResult.boolIsSuccess);
        }
        objTestLead.LastName = 'Test 4';
        objResults = DMLOperationsClass_CF.upsertRecord(objTestLead, true, true, 'Record updated successfuly.', ApexPages.Severity.INFO);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(objResult.boolIsSuccess, 'Unsuccessful update: ' + objResult.boolIsSuccess);
        }
        objTestLead.LastName = 'Test 5';
        List<String> lstTriggers = new List<String>();
        lstTriggers.add(Account.class.toString());
        objResults = DMLOperationsClass_CF.upsertRecord(objTestLead, true, true, null, null, lstTriggers);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(objResult.boolIsSuccess, 'Unsuccessful update: ' + objResult.boolIsSuccess);
        }
        List<sObject> lstRecords = new List<sObject>();
        objResults = DMLOperationsClass_CF.upsertRecord(objTestLead, lstTriggers);
        for(DMLResultClass_CF objResult : objResults.lstResults) {
            System.assert(objResult.boolIsSuccess, 'Unsuccessful update: ' + objResult.boolIsSuccess);
        }
        Test.stopTest();
    }
}