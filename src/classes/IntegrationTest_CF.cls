/**
 * Test class for IntegrationClass_CF.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
@isTest(seeAllData = false)
public without sharing class IntegrationTest_CF {
    
    /**
     * This method tests the continuation methods.
     */
    
    /**
     * This method tests the synchronous callouts.
     */
    static testMethod void synchronousMethods() {
        Test.startTest();
        
        //We first set the fake web service.
        Test.setMock(HttpCalloutMock.class, new IntegrationMockServiceTest_CF());
        
        //Now we test the different methods.
        IntegrationWrapperClass_CF objIntegration;
        String expectedValue = '{"test":"test"}';
        Map<String, String> mapHeaderValues = new Map<String, String>();
        mapHeaderValues.put('test', 'test');
        objIntegration = IntegrationClass_CF.synchronousCallout('Default');
        objIntegration = IntegrationClass_CF.synchronousCallout('Default', 'SynchMethod');
        objIntegration = IntegrationClass_CF.synchronousCalloutNoParameters('Default', 'SynchMethod');
        objIntegration = IntegrationClass_CF.synchronousCallout('Default', 'SynchMethod', true);
        objIntegration = IntegrationClass_CF.synchronousCallout('Default', 'SynchMethod', false, mapHeaderValues);
        objIntegration = IntegrationClass_CF.synchronousCallout('Default', 'SynchMethod', false, mapHeaderValues, 10);
        objIntegration = IntegrationClass_CF.synchronousCallout('Default', 'SynchMethod', false, mapHeaderValues, true, 120);
        System.assertNotEquals(null, objIntegration, 'Invalid response: ' + objIntegration);
        Test.stopTest();
    }
    
    /**
     * This method tests the asynchronous callouts.
     */
    static testMethod void asynchronousMethods() {
        Test.startTest();
        
        //We first set the fake web service.
        Test.setMock(HttpCalloutMock.class, new IntegrationMockServiceTest_CF());
        
        //Now we test the different methods.
        IntegrationWrapperClass_CF objResponse;
        Map<String, String> mapHeaderValues = new Map<String, String>();
        mapHeaderValues.put('test', 'test');
        IntegrationClass_CF.asynchronousCallout('Default');
        IntegrationClass_CF.asynchronousCallout('Default', 'SynchMethod');
        IntegrationClass_CF.asynchronousCalloutNoParameters('Default', 'SynchMethod');
        IntegrationClass_CF.asynchronousCallout('Default', 'SynchMethod', true);
        IntegrationClass_CF.asynchronousCallout('Default', 'SynchMethod', false, mapHeaderValues);
        objResponse = IntegrationClass_CF.asynchronousCallout('Default', 'SynchMethod', false, mapHeaderValues, null);
        System.assertNotEquals(null, objResponse, 'Invalid response.');
        Test.stopTest();
    }
    
    /**
     * This method tests the long request / response callouts.
     */
    static testMethod void longRequestResponseScenario() {
        Test.startTest();
        
        //We first set the fake web service.
        Test.setMock(HttpCalloutMock.class, new IntegrationMockServiceLongRequestTest_CF());
        
        //Now we test a long request / response.
        String strLongRequest = '';
        Map<String, String> mapHeaderValues = new Map<String, String>();
        mapHeaderValues.put('test', 'test');
        for(Integer intCounter = 0 ; intCounter < 2000; intCounter++) {
            strLongRequest = strLongRequest + 'swat';
        }
        IntegrationClass_CF.synchronousCallout('Default', strLongRequest, false, mapHeaderValues, 120);
        IntegrationDetail_CF__c objIntegrationDetails = new IntegrationDetail_CF__c();
        objIntegrationDetails.LinkerId_CF__c = '1234';
        upsert objIntegrationDetails LinkerId_CF__c;
        IntegrationClass_CF.saveIntegrationDetails('1234', '', '', '', null);
        IntegrationClass_CF.futureCallout(null, null, null, null, null, null, null);
        System.assertNotEquals(null, objIntegrationDetails.Id, 'Record not inserted.');
        Test.stopTest();
    }
   
    /**
     * This method tests the resonse code request / response code callouts.
     */
    static testMethod void longErrorCodeResponseScenario() {
        Test.startTest();
        
        //We first set the fake web service.
        Test.setMock(HttpCalloutMock.class, new IntegrationMockServiceLongRequestTest_CF());
        
        //Now we test a long request / response.
        String strLongRequest = '';
        Map<String, String> mapHeaderValues = new Map<String, String>();
        mapHeaderValues.put('test', 'test');
        for(Integer intCounter = 0 ; intCounter < 20; intCounter++) {
            strLongRequest = strLongRequest + 'swat';
        }       
        IntegrationClass_CF.saveIntegrationDetails('1234', '', '', '', '43432432');
        Test.stopTest();
    } 
    
    /**
     * This method tests the time out callout.
     */
    static testMethod void timeOutScenario() {
        Test.startTest();
        
        //We first set the fake web service.
        Test.setMock(HttpCalloutMock.class, new IntegrationMockServiceFailureTest_CF());
        
        //Now we test a long request / response.
        Map<String, String> mapHeaderValues = new Map<String, String>();
        mapHeaderValues.put('test', 'test');
        IntegrationWrapperClass_CF objResponse = IntegrationClass_CF.synchronousCallout('Default', 'Default', false, mapHeaderValues, 120);
        System.assertNotEquals(null, objResponse, 'Invalid response.');
        Test.stopTest();
    }
    
    /**
     * This method tests the asynchronous helper controller.
     */
    static testMethod void asynchronousHelper() {
        Test.startTest();
        String strLongRequest = '';
        for(Integer intCount = 0; intCount <= IntegrationClass_CF.INTEGER_LONG_TEXT_AREA_FIELD_LIMIT; intCount++) {
            strLongRequest += 'a';
        }
        IntegrationHelperController_CF objController = new IntegrationHelperController_CF();
        ApexPages.currentPage().getParameters().put(IntegrationClass_CF.STRING_HELPER_PARAMETER_LINKER, 'test');
        ApexPages.currentPage().getParameters().put(IntegrationClass_CF.STRING_HELPER_PARAMETER_ENDPOINT, 'test');
        ApexPages.currentPage().getParameters().put(IntegrationClass_CF.STRING_HELPER_PARAMETER_REQUEST_BODY, strLongRequest);
        ApexPages.currentPage().getParameters().put(IntegrationClass_CF.STRING_HELPER_PARAMETER_RESPONSE_BODY, strLongRequest);
        objController.insertIntegrationDetailRecord();
        IntegrationClass_CF.BOOL_SKIP_ATTACHMENT_GENERATION = true;
        objController.insertIntegrationDetailRecord();
        System.assertNotEquals(null, ApexPages.currentPage().getParameters().get(IntegrationClass_CF.STRING_HELPER_PARAMETER_LINKER), 'Invalid linker.');
        Test.stopTest();
    }
    
    /**
     * Inner class which creates integration request examples..
     * <p /><p />
     * @author Raymundo Rodriguez
     */
    public class IntegrationInnerTest_CF {
        
        //Private variables.
        private IntegrationWrapperClass_CF objIntegration;
        
        /**
         * Continuation method.
         *
         * @return Continuation object.
         */
        public Continuation continuation() {
            Map<String, String> mapHeaderValues = new Map<String, String>();
            mapHeaderValues.put('test', 'test');
            objIntegration = IntegrationClass_CF.continuationCallout('Default', 'continuationResponse');
            objIntegration = IntegrationClass_CF.continuationCallout('Default', 'continuationResponse', 'ContinuationMethod');
            objIntegration = IntegrationClass_CF.continuationCalloutNoParameters('Default', 'continuationResponse', 'ContinuationMethod');
            objIntegration = IntegrationClass_CF.continuationCallout('Default', 'continuationResponse', 'ContinuationMethod', true);
            objIntegration = IntegrationClass_CF.continuationCallout('Default', 'continuationResponse', 'ContinuationMethod', false, mapHeaderValues);
            objIntegration = IntegrationClass_CF.continuationCallout('Default', 'continuationResponse', 'ContinuationMethod', false, mapHeaderValues, 10);
            HttpRequest objHttpRequest = new HttpRequest();
            objHttpRequest.setMethod(objIntegration.strRequestMethod);
            objHttpRequest.setBody(objIntegration.strRequestBody);
            objHttpRequest.setEndpoint(objIntegration.strRequestEndpoint);
            Continuation objContinuation = new Continuation(objIntegration.intTimeout);
            objIntegration.strRequestKey = objContinuation.addHttpRequest(objHttpRequest);
            objContinuation.continuationMethod = objIntegration.strCallbackMethodName;
            return objContinuation;
        }
        
        /**
         * Continuation callback method
         *
         * @return Object.
         */
        public Object continuationResponse() {
            objIntegration = IntegrationClass_CF.getContinuationResponse(objIntegration);
            return null;
        }
    }
}