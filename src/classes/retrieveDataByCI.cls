/**
 * Description of the class
 * <p /><p />
 * @author nagesingh
 */
public with sharing class retrieveDataByCI {

    private IntegrationWrapperClass_CF objIntegration;

    public Continuation continuation() {
        objIntegration = IntegrationClass_CF.continuationCallout('JsonRec', 'continuationResponse');
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
        system.debug('Entered response');
        IntegrationWrapperClass_CF objResponse = IntegrationClass_CF.getContinuationResponse(objIntegration);
        return null;
    }
}