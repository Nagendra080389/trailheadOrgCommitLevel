/**
 * Test class for FrameworkBaseController_CF.
 * <p /><p />
 * @author Gabriel Coronel
 */
@isTest
public class FrameworkBaseTest_CF {

    /**
     * Test Setup for testing scenarios.
     */
    @testSetup
    static void testSetupData() {
        
        //Create common test data.
        KeyboardShortcuts_CF__c objCustomSetting = new KeyboardShortcuts_CF__c();
        objCustomSetting.Name = 'Test';
        objCustomSetting.JSCode_CF__c = 'Test';
        insert objCustomSetting;
    }
    
    /**
     * Obtain Custom Framework system customization variables.
     */
    static testMethod void getCFVariables() {
        
        //Initialize variables.
        Account objTestAccount = new Account();
        FrameworkBaseController_CF objControllerConstructor = new FrameworkBaseController_CF(new ApexPages.StandardController(objTestAccount));
        FrameworkBaseController_CF objController = new FrameworkBaseController_CF();
        Map <String, String> mapTest = new Map<String, String>();
        Test.startTest();
        System.assertEquals(objController.mapAvailableKeyboardShortcuts.get('Test'), 'Test', 'Invalid Keyboard Shortcuts.');
        Test.stopTest();
    }
}