/**
 * Description of the class
 * <p /><p />
 * @author Nagendra Kumar Singh
 */
public class CanvasAppController {

    private AssesmentDataWrapper_ACE objAssessmentDataWrapperAce { get; set; }
    public Case objCase { get; set; }
    Public String strEffectiveUserId { get; set; }

    public String getbase_url() {
        return 'https://viewerdemo-ic3uat.mckessonasp.com/';
    }

    public static String getap_userName() {
        return 'hcscdemo';
    }

    public static String getap_tenant_id() {
        return 'b9d35460-5cbd-44ae-a2f3-9cae9f9e4b15';
    }

    public String getap_password() {
        return 'HCSCTest@123';
    }

    public CanvasAppController(ApexPages.StandardController controller) {
        objCase = (Case) controller.getRecord();
        strEffectiveUserId = /*[select id, accountid from case where id = :objCase.id].accountId;*/ '4';
        system.debug('strEffectiveUserId-->' + strEffectiveUserId);
    }

    @RemoteAction
    public static Object fnMessageCarePlanSaveHandler(String strAssessmentDataWrapperAce, String caseId) {
        AssesmentDataWrapper_ACE objDataWrapperAce = (AssesmentDataWrapper_ACE) JSON.deserialize(strAssessmentDataWrapperAce, AssesmentDataWrapper_ACE.class);
        System.debug('objDataWrapperAce- > ' + objDataWrapperAce);

        HttpRequest httpRequest = new HttpRequest();
        SecurityManager manager = new SecurityManager();
        Map<String, String> stringMap = manager.addSecurityHeaders(getap_userName(), getap_tenant_id());

        httpRequest.setHeader(SecurityManager.HEADER_USER_NAME, stringMap.get(SecurityManager.HEADER_USER_NAME));
        httpRequest.setHeader(SecurityManager.HEADER_AUTH_TOKEN, stringMap.get(SecurityManager.HEADER_AUTH_TOKEN));
        httpRequest.setHeader(SecurityManager.HEADER_TENANT_ID, stringMap.get(SecurityManager.HEADER_TENANT_ID));
        httpRequest.setHeader(SecurityManager.HEADER_NONCE, stringMap.get(SecurityManager.HEADER_NONCE));
        httpRequest.setHeader('Ap-effective-user-id', objDataWrapperAce.ap_effective_user_id);
        system.debug('objDataWrapperAce.ap_effective_user_id-->' + objDataWrapperAce.ap_effective_user_id);
        //httpRequest.setEndpoint('https://engine-ic3uat.mckessonasp.com/Server/mckesson/restful/v1/iccc/iccc_care_plans/iccc_master_barriers/full.json');
        httpRequest.setEndpoint('https://engine-ic3uat.mckessonasp.com/Server/mckesson/restful/v1/iccc/iccc_care_plans/iccc_master_barriers.json');
        httpRequest.setMethod('GET');
        Continuation objContinuation = new Continuation(120);
        CalloutBridge bridge = new CalloutBridge(objContinuation.addHttpRequest(httpRequest), caseId);
        objContinuation.state = bridge;
        objContinuation.continuationMethod = 'continuationCallback';
        system.debug('objContinuation-->' + objContinuation);
        return objContinuation;
    }

    /**
     *Continuation callback method.
     *
     *@param objState holds state object.
     *@return response body.
     */
    public static Boolean continuationCallback(Object objState) {
        CalloutBridge objCalloutBridge = (CalloutBridge) objState;
        System.debug('objCalloutBridge.caseId -> ' + objCalloutBridge.caseId);
        HttpResponse httpResponse = Continuation.getResponse((String) objCalloutBridge.objResponse);
        List<Goals> goals = (List<Goals>) JSON.deserialize(httpResponse.getBody(), List<Goals>.class);

        System.debug('goal-->' + goals);
        //TO DO : Pass the response to another class with care plan Id
        //Boolean isSuccess = Class.method(objCase.id, goals);
        //InterQualUtility.InterQual(caseId , goals);
        return true;
    }
}