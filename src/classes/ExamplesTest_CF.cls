/**
 * Test class for ExamplesController_CF.
 * <p /><p />
 * @author Alejandro Cajica
 */
@isTest
public class ExamplesTest_CF {

    //Private variables.
    private static Lead testLead;
    
    /**
     * Test Setup for testing scenarios in testmethods.
     */
    @testSetup
    static void testSetupData() {
        IntegrationDetail_CF__c objIntegration;
        
        //Create common test data.
        testLead = new Lead(LastName = StaticVariablesClass_CF.CUSTOM_FRAMEWORK_MEMBER_ID);
        insert testLead;
        objIntegration = new IntegrationDetail_CF__c(); 
        objIntegration.LinkerId_CF__c = 'ExampleLinker';
        insert objIntegration;
    }

    /**
     * Execute all generic example methods from ExamplesController_CF.
     */
    static testMethod void executeMethods() {
        Test.startTest();
        String strInputText;
        ExamplesController_CF objController = new ExamplesController_CF();
        strInputText = objController.strInputText;
        Attachment objAttachment = objController.objAttachment;
        Lead objLead = objController.objLead;
        Case objCase = objController.objCase; 
        objController.actionMethod();
        objController.fatal();
        objController.success();
        objController.actionMethod();
        objController.customFrameworkExamplesAction();
        objController.createIntegrationDetail();
        objController.lstRecords = ExamplesController_CF.remoteAction('Test');
        System.assert(objController.lstRecords.size() > 0);
        Test.stopTest();
    }
    
    /**
     * Execute negative scenario for Lead creation from ExamplesController_CF.
     */
    static testMethod void negativeExecuteMethods() {
        Test.startTest();
        ExamplesController_CF objController = new ExamplesController_CF();
        Lead objLead = [SELECT Id, LastName FROM Lead WHERE LastName = :StaticVariablesClass_CF.CUSTOM_FRAMEWORK_MEMBER_ID LIMIT 1];
        
        //Cleaning Name of test Lead.
        objLead.LastName = 'NewName';
        upsert objLead;
        
        //Obtain clean Lead.
        objController.customFrameworkExamplesAction();
        Test.stopTest();
    }
}