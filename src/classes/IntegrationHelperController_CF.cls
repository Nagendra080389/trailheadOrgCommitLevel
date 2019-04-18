/**
 * This class acts as a helper for the Integration class, to store Integration Detail records.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
public without sharing class IntegrationHelperController_CF {
    
    /**
     * This method extracts the GET parameters with the request values.
     */
    public void insertIntegrationDetailRecord() {
        String strLinker = ApexPages.currentPage().getParameters().get(IntegrationClass_CF.STRING_HELPER_PARAMETER_LINKER);
        String strEndpoint = ApexPages.currentPage().getParameters().get(IntegrationClass_CF.STRING_HELPER_PARAMETER_ENDPOINT);
        String strRequestBody = ApexPages.currentPage().getParameters().get(IntegrationClass_CF.STRING_HELPER_PARAMETER_REQUEST_BODY);
        String strResponseBody = ApexPages.currentPage().getParameters().get(IntegrationClass_CF.STRING_HELPER_PARAMETER_RESPONSE_BODY);
        if(String.IsNotBlank(strLinker) && String.IsNotBlank(strEndpoint)) {
            IntegrationClass_CF.saveIntegrationDetails(strLinker, strEndpoint, strRequestBody, strResponseBody, null);
        }
    }
}