/**
* Test class for HcscOAuthAccessController_ACE.
* <p /><p />
* @author Rahul Nanda
*/
@isTest
public class HcscOAuthAccessControllerTest_ACE {
    public static string strRedirectUrl = ''; 
    public static string strRequestCode = '';
    public static Pagereference pageReference;
    
    public static testMethod void callThePageWithContinuation(){
        //Use the PageReference Apex class to instantiate a page
        PageReference pageRef = Page.GoogleLogin;
        
        //In this case, the Visualforce page named 'success' is the starting point of this test method. 
        Test.setCurrentPage(pageRef);
        //strRedirectUrl  = HcscOAuthAccessController_ACE.connect();
        Test.setCurrentPageReference(pageRef);
        HcscOAuthAccessController_ACE hcscCon = new HcscOAuthAccessController_ACE();
        test.startTest();
            HcscOAuthAccessController_ACE.getOAuthToken(system.currentPageReference().getParameters().get('code'));
        test.stopTest();
    }
    public static testMethod void connetMethod(){
       // List<GoogleConnectionSettings__mdt> cmdtLst = [Select DeveloperName,Value_ACE__c from GoogleConnectionSettings__mdt] ;
        //List<IntegrationEndpoint_CF__mdt > endPointLst = [SELECT Endpoint_CF__c, AuthenticationToken_CF__c FROM IntegrationEndpoint_CF__mdt]; 
        strRedirectUrl  = HcscOAuthAccessController_ACE.connect();
        Test.setCurrentPageReference(new pageReference(strRedirectUrl));
    }
    public static testMethod void getOAuthTokenMethod(){
        test.startTest();
      
        strRequestCode=System.currentPageReference().getParameters().get('code');
        
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
            IntegrationClass_CF.saveIntegrationDetails('1234', '', '', '');
            IntegrationClass_CF.futureCallout(null, null, null, null, null, null, null);
            System.assertNotEquals(null, objIntegrationDetails.Id, 'Record not inserted.');
            strRequestCode=apexpages.currentpage().getparameters().get('code');
        HcscOAuthAccessController_ACE.getOAuthToken(strRequestCode);
        Test.stopTest();
        
        
    }
}