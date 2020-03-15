/**
 * Test class for ErrorLogClass_CF.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
@isTest(seeAllData = false)
public without sharing class ErrorLogTest_CF {

    /**
     * This method tests the normal scenarios, using all the available methods.
     */
    static testMethod void errorLogMethods() {
        Test.startTest();

        //In case the exception happens on the Constructor, Getter and / or setter.
        new ErrorLogInnerHelperTest_CF();
        ErrorLogHelperController_CF objConstructorController = new ErrorLogHelperController_CF();
        ApexPages.currentPage().getParameters().put(ErrorLogClass_CF.STRING_HELPER_PARAMETER_NAME, 'invalid');
        objConstructorController.insertExceptionLogRecord();

        //Now we test future methods.
        ErrorLogHelperTest_CF.futureMethodOne();
        ErrorLogHelperTest_CF.futureMethodTwo();

        //Now we test the other methods (same result).
        try {
            Integer intInteger = 1 / 0;
        } catch (Exception objException) {
            ErrorLogWrapperClass_CF objErrorLog = ErrorLogClass_CF.processException(objException);
            System.assertEquals(objErrorLog.strErrorMessage, 'Divide by 0', 'Invalid message returned: ' + objErrorLog.strErrorMessage);
            ErrorLogClass_CF.processException(objException, true, 'Error Message', ApexPages.Severity.INFO);
            ErrorLogClass_CF.processException(objException, false, 'Error Message', ApexPages.Severity.INFO, new Account());
            ErrorLogClass_CF.processException(objException, true, null, null, new Account());
            ErrorLogClass_CF.processException(objException, new Account());
            ErrorLogClass_CF.processException(objException, new Account(), new Account());

            //Now we test long Serialized data.
            String strLongResponse = '';
            for (Integer intCount = 0; intCount <= ErrorLogClass_CF.INTEGER_LONG_TEXT_AREA_FIELD_LIMIT; intCount++) {
                strLongResponse += 'a';
            }
            ErrorLogClass_CF.processException(objException, strLongResponse, strLongResponse);

            //Now we test a list of exceptions.
            List<ErrorLogWrapperClass_CF> lstExceptions = new List<ErrorLogWrapperClass_CF>();
            ErrorLogWrapperClass_CF objNewException = new ErrorLogWrapperClass_CF();
            objNewException.objException = objException;
            lstExceptions.add(objNewException);
            objNewException = new ErrorLogWrapperClass_CF();
            objNewException.objException = objException;
            objNewException.strClassName = 'TestClassName';
            lstExceptions.add(objNewException);
            ErrorLogClass_CF.processExceptions(lstExceptions);
        }
        Test.stopTest();
    }

    /**
     * This method tests the normal scenarios, using all the available methods.
     */
    static testMethod void skipAttachmentGeneration() {
        Test.startTest();
        try {
            Integer intInteger = 1 / 0;
        } catch (Exception objException) {
            ErrorLogWrapperClass_CF objErrorLog = ErrorLogClass_CF.processException(objException);
            System.assertEquals(objErrorLog.strErrorMessage, 'Divide by 0', 'Invalid message returned: ' + objErrorLog.strErrorMessage);
            String strLongResponse = '';
            for (Integer intCount = 0; intCount <= ErrorLogClass_CF.INTEGER_LONG_TEXT_AREA_FIELD_LIMIT; intCount++) {
                strLongResponse += 'a';
            }
            ErrorLogClass_CF.BOOL_SKIP_ATTACHMENT_GENERATION = true;
            ErrorLogClass_CF.processException(objException, strLongResponse, strLongResponse);
        }
        Test.stopTest();
    }

    /**
     * This method tests when a developer calls the Exception Caller method directly, without proper parameters.
     */
    static testMethod void exceptionScenarioInvalidCaller() {
        Test.startTest();
        ErrorLogClass_CF.extractExceptionCaller(null, null);
        Test.stopTest();
        Integer intResult = [SELECT Id FROM ErrorLog_CF__c].size();
        System.assertEquals(intResult, 0, '1 record was expected but ' + intResult + ' were found.');
    }

    /**
     * This method tests when a developer calls the Future method directly, without proper parameters.
     */
    static testMethod void exceptionScenarioInvalidSerializedRecord() {
        Test.startTest();
        ErrorLogClass_CF.futureInsertErrorLogRecords('');
        Test.stopTest();
        Integer intResult = [SELECT Id FROM ErrorLog_CF__c].size();
        System.assertEquals(intResult, 0, '1 record was expected but ' + intResult + ' were found.');
    }

    /**
     * This method tests when inproprer data is sent to the processors.
     */
    static testMethod void exceptionScenarioInvalidExceptionData() {
        Test.startTest();
        ErrorLogWrapperClass_CF objErrorLog = ErrorLogClass_CF.processException(new CalloutException());
        System.assertNotEquals('', objErrorLog.strErrorMessage, 'Invalid message returned: ' + objErrorLog.strErrorMessage);
        Test.stopTest();
    }

    /**
     * Inner class to test Constructor exception.
     * <p /><p />
     * @author Raymundo Rodriguez
     */
    public class ErrorLogInnerHelperTest_CF {

        /**
         * Constructor of the method.
         */
        public ErrorLogInnerHelperTest_CF() {
            try {
                Integer intInteger = 1 / 0;
            } catch (Exception objException) {
                ErrorLogClass_CF.processException(objException);
            }
        }
    }
}