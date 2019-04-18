/**
 * This class helps to process all the Integrations, using Continuation.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
public without sharing class IntegrationClass_CF {
    
    //Public variables
    public static Boolean BOOL_SKIP_ATTACHMENT_GENERATION = false;
    public static final Integer INTEGER_DEFAULT_TIMEOUT_VALUE_MILLISECONDS = 120000;
    public static final String STRING_GET_SEPARATOR = '?';
    public static final String STRING_GET_SEPARATOR_PARAMETER = '&';
    public static final String STRING_HELPER_URL = Page.IntegrationHelperPage_CF.getUrl() + '?';
    public static final String STRING_HELPER_PARAMETER_LINKER = 'linker';
    public static final String STRING_HELPER_PARAMETER_ENDPOINT = 'endpoint';
    public static final String STRING_HELPER_PARAMETER_REQUEST_BODY = 'requestBody';
    public static final String STRING_HELPER_PARAMETER_RESPONSE_BODY = 'responseBody';
    public static final String STRING_HELPER_PARAMETER_NAME_SUFFIX = '=';
    public static final String STRING_HELPER_PARAMETER_SEPARATOR = '&';
    public static final String STRING_HELPER_URL_ENCODING = 'UTF-8';
    public static final Integer INTEGER_URL_LIMIT = 4095;
    public static final Integer INTEGER_LONG_TEXT_AREA_FIELD_LIMIT = 131072;
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @param strCallbackMethodName    Method name for the callback.
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF continuationCallout(String strEndpointName, String strCallbackMethodName) {
        return callout(true, strEndpointName, null, null, null, null, null, null, strCallbackMethodName);
    }
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @param strCallbackMethodName    Method name for the callback.
     * @param strBody    Body of the request.
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF continuationCallout(String strEndpointName, String strCallbackMethodName, String strBody) {
        return callout(true, strEndpointName, strBody, null, null, null, null, null, strCallbackMethodName);
    }
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @param strCallbackMethodName    Method name for the callback.
     * @param strURLSuffix    Suffix to be appended to the URL.
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF continuationCalloutNoParameters(String strEndpointName, String strCallbackMethodName, String strURLSuffix) {
        return callout(true, strEndpointName, strURLSuffix, true, false, null, null, null, strCallbackMethodName);
    }
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @param strCallbackMethodName    Method name for the callback.
     * @param strBody    Body of the request.
     * @param boolIsHTTPGetRequest    Defines if the callout requires an HTTP GET or POST action.
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF continuationCallout(String strEndpointName, String strCallbackMethodName, String strBody, Boolean boolIsHTTPGetRequest) {
        return callout(true, strEndpointName, strBody, boolIsHTTPGetRequest, null, null, null, null, strCallbackMethodName);
    }
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @param strCallbackMethodName    Method name for the callback.
     * @param strBody    Body of the request.
     * @param boolIsHTTPGetRequest    Defines if the callout requires an HTTP GET or POST action.
     * @param mapHeaderValues    Header values.
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF continuationCallout(String strEndpointName, String strCallbackMethodName, String strBody, Boolean boolIsHTTPGetRequest, 
            Map<String, String> mapHeaderValues) {
        return callout(true, strEndpointName, strBody, boolIsHTTPGetRequest, null, null, mapHeaderValues, null, strCallbackMethodName);
    }
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @param strCallbackMethodName    Method name for the callback.
     * @param strBody    Body of the request.
     * @param boolIsHTTPGetRequest    Defines if the callout requires an HTTP GET or POST action.
     * @param mapHeaderValues    Header values.
     * @param intTimeout    Timeout value for the callout (in milliseconds).
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF continuationCallout(String strEndpointName, String strCallbackMethodName, String strBody, Boolean boolIsHTTPGetRequest, 
            Map<String, String> mapHeaderValues, Integer intTimeout) {
        return callout(true, strEndpointName, strBody, boolIsHTTPGetRequest, null, intTimeout, mapHeaderValues, null, strCallbackMethodName);
    }
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF synchronousCallout(String strEndpointName) {
        return callout(false, strEndpointName, null, null, null, null, null, true, null);
    }
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @param strBody    Body of the request.
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF synchronousCallout(String strEndpointName, String strBody) {
        return callout(false, strEndpointName, strBody, null, null, null, null, true, null);
    }
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @param strURLSuffix    Suffix to be appended to the URL.
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF synchronousCalloutNoParameters(String strEndpointName, String strURLSuffix) {
        return callout(false, strEndpointName, strURLSuffix, true, false, null, null, true, null);
    }
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @param strBody    Body of the request.
     * @param boolIsHTTPGetRequest    Defines if the callout requires an HTTP GET or POST action.
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF synchronousCallout(String strEndpointName, String strBody, Boolean boolIsHTTPGetRequest) {
        return callout(false, strEndpointName, strBody, boolIsHTTPGetRequest, null, null, null, true, null);
    }
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @param strBody    Body of the request.
     * @param boolIsHTTPGetRequest    Defines if the callout requires an HTTP GET or POST action.
     * @param mapHeaderValues    Header values.
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF synchronousCallout(String strEndpointName, String strBody, Boolean boolIsHTTPGetRequest, Map<String, String> mapHeaderValues) {
        return callout(false, strEndpointName, strBody, boolIsHTTPGetRequest, null, null, mapHeaderValues, true, null);
    }
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @param strBody    Body of the request.
     * @param boolIsHTTPGetRequest    Defines if the callout requires an HTTP GET or POST action.
     * @param mapHeaderValues    Header values.
     * @param boolIncludeQuestionMarkGetMethod    Defines if the ? must be appended to the URL, on a GET callout.
     * @param intTimeout    Timeout value for the callout (in milliseconds).
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF synchronousCallout(String strEndpointName, String strBody, Boolean boolIsHTTPGetRequest, Map<String, String> mapHeaderValues, 
            Boolean boolIncludeQuestionMarkGetMethod, Integer intTimeout) {
        return callout(false, strEndpointName, strBody, boolIsHTTPGetRequest, boolIncludeQuestionMarkGetMethod, intTimeout, mapHeaderValues, true, null);
    }
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @param strBody    Body of the request.
     * @param boolIsHTTPGetRequest    Defines if the callout requires an HTTP GET or POST action.
     * @param mapHeaderValues    Header values.
     * @param intTimeout    Timeout value for the callout (in milliseconds).
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF synchronousCallout(String strEndpointName, String strBody, Boolean boolIsHTTPGetRequest, Map<String, String> mapHeaderValues, 
            Integer intTimeout) {
        return callout(false, strEndpointName, strBody, boolIsHTTPGetRequest, null, intTimeout, mapHeaderValues, true, null);
    }
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF asynchronousCallout(String strEndpointName) {
        return callout(false, strEndpointName, null, null, null, null, null, false, null);
    }
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @param strBody    Body of the request.
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF asynchronousCallout(String strEndpointName, String strBody) {
        return callout(false, strEndpointName, strBody, null, null, null, null, false, null);
    }
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @param strURLSuffix    Suffix to be appended to the URL.
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF asynchronousCalloutNoParameters(String strEndpointName, String strURLSuffix) {
        return callout(false, strEndpointName, strURLSuffix, true, false, null, null, false, null);
    }
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @param strBody    Body of the request.
     * @param boolIsHTTPGetRequest    Defines if the callout requires an HTTP GET or POST action.
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF asynchronousCallout(String strEndpointName, String strBody, Boolean boolIsHTTPGetRequest) {
        return callout(false, strEndpointName, strBody, boolIsHTTPGetRequest, null, null, null, false, null);
    }
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @param strBody    Body of the request.
     * @param boolIsHTTPGetRequest    Defines if the callout requires an HTTP GET or POST action.
     * @param mapHeaderValues    Header values.
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF asynchronousCallout(String strEndpointName, String strBody, Boolean boolIsHTTPGetRequest, Map<String, String> mapHeaderValues) {
        return callout(false, strEndpointName, strBody, boolIsHTTPGetRequest, null, null, mapHeaderValues, false, null);
    }
    
    /**
     * Executes the request callout.
     *
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @param strBody    Body of the request.
     * @param boolIsHTTPGetRequest    Defines if the callout requires an HTTP GET or POST action.
     * @param mapHeaderValues    Header values.
     * @param intTimeout    Timeout value for the callout (in milliseconds).
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF asynchronousCallout(String strEndpointName, String strBody, Boolean boolIsHTTPGetRequest, Map<String, String> mapHeaderValues, 
            Integer intTimeout) {
        return callout(false, strEndpointName, strBody, boolIsHTTPGetRequest, null, intTimeout, mapHeaderValues, false, null);
    }
    
    /**
     * Extracts the Continuation result.
     *
     * @param objIntegration    Integration wrapper object.
     * @return Integration Wrapper.
     */
    public static IntegrationWrapperClass_CF getContinuationResponse(IntegrationWrapperClass_CF objIntegration) {
        if(objIntegration != null && String.IsNotBlank(objIntegration.strRequestKey)) {
            HttpResponse objResponse = Continuation.getResponse(objIntegration.strRequestKey);
            objIntegration.strResponseBody = objResponse.getBody();
            objIntegration.strResponseStatusCode = String.valueOf(objResponse.getStatusCode());
            saveIntegrationDetailsDifferentInstance(objIntegration.strLinker, null, objIntegration.strRequestBody, objIntegration.strResponseBody, 
                    objIntegration.strResponseStatusCode);
        }
        return objIntegration;
    }
    
    /**
     * Extracts the Result.
     *
     * @param strEndpointRecordSerialized    Endpoint URL object serialized.
     * @param strBody    Body of the request.
     * @param intTimeout    Timeout value for the callout (in milliseconds).
     * @param boolIsHTTPGetRequest    Defines if the callout requires an HTTP GET or POST action.
     * @param boolIncludeQuestionMarkGetMethod    Defines if the ? must be appended to the URL, on a GET callout.
     * @param strLinker    Linker value for Request and Response.
     * @param mapHeaderValues    Header values.
     */
    @future(callout = true)
    public static void futureCallout(String strEndpointRecordSerialized, String strBody, Integer intTimeout, Boolean boolIsHTTPGetRequest, Boolean boolIncludeQuestionMarkGetMethod, 
            Map<String, String> mapHeaderValues, String strLinker) {
        String strEndpoint = '';
        try {
            IntegrationEndpoint_CF__mdt objEndpointRecord = (IntegrationEndpoint_CF__mdt) JSON.deserialize(strEndpointRecordSerialized, IntegrationEndpoint_CF__mdt.class);
            strEndpoint = objEndpointRecord.Endpoint_CF__c;
            HttpRequest objHttpRequest = createHttpRequest(false, objEndpointRecord, strBody, intTimeout, boolIsHTTPGetRequest, boolIncludeQuestionMarkGetMethod, mapHeaderValues);
            Http objHttp = new Http();
            HttpResponse objResponse = objHttp.send(objHttpRequest);
            saveIntegrationDetailsDifferentInstance(strLinker, strEndpoint, strBody, objResponse.getBody(), String.valueOf(objResponse.getStatusCode()));
        } catch(Exception objException) {
            
            //Storing first the request.
            saveIntegrationDetails(strLinker, strEndpoint, strBody, null, null);
            
            //Now the error log.
            ErrorLogClass_CF.processException(objException, strEndpointRecordSerialized, strBody);
        }
    }
    
    /**
     * Stores the Request data for tracking purposes.
     *
     * @param strLinker    Linker value for Request and Response.
     * @param strEndpoint    Endpoint.
     * @param strRequestBody    Body request.
     * @param strResponseBody    Body response.
     * @param strResponseCode    Status Code response.
     */
    public static void saveIntegrationDetails(String strLinker, String strEndpoint, String strRequestBody, String strResponseBody, String strResponseCode) {
        try {
            Integer intCounter = 0;
            String strRequestAttachmentName = 'Request.txt';
            String strResponseAttachmentName = 'Response.txt';
            String strTrimmedMessage = 'Data Trimmed by Developer: ';
            Attachment objRequestAttachment = new Attachment();
            Attachment objResponseAttachment = new Attachment();
            IntegrationDetail_CF__c objIntegrationDetails = new IntegrationDetail_CF__c();
            List<Attachment> lstAttachments = new List<Attachment>();
            for(IntegrationDetail_CF__c objExistingRecord : [SELECT LinkerId_CF__c, Endpoint_CF__c, RequestBody_CF__c, ResponseBody_CF__c, ResponseCode_CF__c
                    FROM IntegrationDetail_CF__c WHERE LinkerId_CF__c = :strLinker LIMIT 1]) {
                objIntegrationDetails = objExistingRecord;
            }
            objIntegrationDetails.LinkerId_CF__c = strLinker;
            if(String.IsNotBlank(strEndpoint)) {
                objIntegrationDetails.Endpoint_CF__c = strEndpoint;
            }
            
            //Now preparing the updats.
            if(String.IsNotBlank(strRequestBody)) {
                if(String.IsBlank(objIntegrationDetails.RequestBody_CF__c)) {
                    objIntegrationDetails.RequestBody_CF__c = '';
                }
                objIntegrationDetails.RequestBody_CF__c = objIntegrationDetails.RequestBody_CF__c + strRequestBody;
                if(String.IsNotBlank(objIntegrationDetails.RequestBody_CF__c) && objIntegrationDetails.RequestBody_CF__c.length() > INTEGER_LONG_TEXT_AREA_FIELD_LIMIT) {
                    if(BOOL_SKIP_ATTACHMENT_GENERATION) {
                        objIntegrationDetails.RequestBody_CF__c = strTrimmedMessage + objIntegrationDetails.RequestBody_CF__c;
                        objIntegrationDetails.RequestBody_CF__c = objIntegrationDetails.RequestBody_CF__c.substring(0, INTEGER_LONG_TEXT_AREA_FIELD_LIMIT - 1);
                    } else {
                        objRequestAttachment.Body = Blob.valueOf(objIntegrationDetails.RequestBody_CF__c);
                        objRequestAttachment.Name = strRequestAttachmentName;
                        lstAttachments.add(objRequestAttachment);
                        objIntegrationDetails.RequestBody_CF__c = 'Please see ' + objRequestAttachment.Name + ' attached file.';
                    }
                }
            }
            if(String.IsNotBlank(strResponseBody)) {
                if(String.IsBlank(objIntegrationDetails.ResponseBody_CF__c)) {
                    objIntegrationDetails.ResponseBody_CF__c = '';
                }
                objIntegrationDetails.ResponseBody_CF__c = objIntegrationDetails.ResponseBody_CF__c + strResponseBody;
                if(String.IsNotBlank(objIntegrationDetails.ResponseBody_CF__c) && objIntegrationDetails.ResponseBody_CF__c.length() > INTEGER_LONG_TEXT_AREA_FIELD_LIMIT) {
                    if(BOOL_SKIP_ATTACHMENT_GENERATION) {
                        objIntegrationDetails.ResponseBody_CF__c = strTrimmedMessage + objIntegrationDetails.ResponseBody_CF__c;
                        objIntegrationDetails.ResponseBody_CF__c = objIntegrationDetails.ResponseBody_CF__c.substring(0, INTEGER_LONG_TEXT_AREA_FIELD_LIMIT - 1);
                    } else {
                        objResponseAttachment.Body = Blob.valueOf(objIntegrationDetails.ResponseBody_CF__c);
                        objResponseAttachment.Name = strResponseAttachmentName;
                        lstAttachments.add(objResponseAttachment);
                        objIntegrationDetails.ResponseBody_CF__c = 'Please see ' + objResponseAttachment.Name + ' attached file.';
                    }
                }
            }
            if(String.isNotBlank(strResponseCode)) {
                objIntegrationDetails.ResponseCode_CF__c = strResponseCode;
            }
            upsert objIntegrationDetails LinkerId_CF__c;
            
            //Now we create the attachments.
            if(!BOOL_SKIP_ATTACHMENT_GENERATION) {
                for(Attachment objNewAttachment : lstAttachments) {
                    if(objNewAttachment.ParentId == null) {
                        objNewAttachment.ParentId = objIntegrationDetails.Id;
                    }
                }
                
                //Finally, we insert the attachments.
                if(lstAttachments.size() > 0) {
                    insert lstAttachments;
                }
            }
        } catch(Exception objInternalException) {
            System.debug(objInternalException.getMessage());
            System.debug(objInternalException.getStackTraceString());
        }
    }
    
    /**
     * Executes the request callout.
     *
     * @param boolUseContinuation    Defines if the code will use Continuation to prepare the callout.
     * @param strEndpointName    Name of the Endpoint stored in the Custom Metadata Type.
     * @param strBody    Body of the request.
     * @param boolIsHTTPGetRequest    Defines if the callout requires an HTTP GET or POST action.
     * @param boolIncludeQuestionMarkGetMethod    Defines if the ? must be appended to the URL, on a GET callout.
     * @param intTimeout    Timeout value for the callout (in milliseconds).
     * @param mapHeaderValues    Header values.
     * @param boolExecuteSynchronously    Defines if the callout should be on a Future method.
     * @param strCallbackMethodName    Method name for the callback.
     * @param objContinuation    Continuation instance.
     * @return Integration Wrapper.
     */
    private static IntegrationWrapperClass_CF callout(Boolean boolUseContinuation, String strEndpointName, String strBody, Boolean boolIsHTTPGetRequest, 
            Boolean boolIncludeQuestionMarkGetMethod, Integer intTimeout, Map<String, String> mapHeaderValues, Boolean boolExecuteSynchronously, String strCallbackMethodName) {
        IntegrationWrapperClass_CF objIntegration = new IntegrationWrapperClass_CF();
        String strOrganizationId = UserInfo.getOrganizationId();
        if(Test.isRunningTest()) {
            strOrganizationId = 'Default';
        }
        try {
            if(String.IsNotBlank(strEndpointName)) {
                
                //We first get the right endpoint, based on the current Environment.
                for(IntegrationEndpoint_CF__mdt objEndpointRecord : [SELECT Endpoint_CF__c, AuthenticationToken_CF__c FROM IntegrationEndpoint_CF__mdt WHERE 
                        MasterLabel = :strEndpointName AND Environment_CF__r.Id__c = :strOrganizationId AND IsActive_CF__c = true AND 
                        Environment_CF__r.Is_Active_CF__c = true LIMIT 1]) {
                    strEndpointName = objEndpointRecord.Endpoint_CF__c;
                    
                    //Setting the values for request/response tracking.
                    if(strBody == null) {
                        strBody = '';
                    }
                    objIntegration.strLinker = Userinfo.getUserId() + DateTime.now() + ':' + DateTime.now().millisecond();
                            
                    //Now we create the HTTP Request object.
                    HttpRequest objHttpRequest = createHttpRequest(boolUseContinuation, objEndpointRecord, strBody, intTimeout, boolIsHTTPGetRequest, 
                            boolIncludeQuestionMarkGetMethod, mapHeaderValues);
                    
                    //If the developer wants to use continuation.
                    if(boolUseContinuation == null || boolUseContinuation) {
                        if(intTimeout == null) {
                            intTimeout = INTEGER_DEFAULT_TIMEOUT_VALUE_MILLISECONDS;
                        }
                        
                        //First, we convert the provided milliseconds to seconds.
                        intTimeout = intTimeout / 1000;
                        
                        //Finally, we set the values for the Continuation method.
                        objIntegration.intTimeout = intTimeout;
                        objIntegration.strCallbackMethodName = strCallbackMethodName;
                        objIntegration.strRequestMethod = objHttpRequest.getMethod();
                        objIntegration.strRequestBody = objHttpRequest.getBody();
                        objIntegration.strRequestEndpoint = objHttpRequest.getEndpoint();
                        objIntegration.mapHeaderValues = mapHeaderValues;
                    } else {
                        
                        //If the developer needs to execute the callout synchronously.
                        if(boolExecuteSynchronously == null || boolExecuteSynchronously) {
                            Http objHttp = new Http();
                            HttpResponse objResponse = objHttp.send(objHttpRequest);
                            objIntegration.strResponseBody = objResponse.getBody();
                            objIntegration.strResponseStatusCode = String.valueOf(objResponse.getStatusCode());
                            saveIntegrationDetailsDifferentInstance(objIntegration.strLinker, strEndpointName, strBody, objIntegration.strResponseBody, 
                                    objIntegration.strResponseStatusCode);
                        } else {
                            futureCallout(JSON.serialize(objEndpointRecord), strBody, intTimeout, boolIsHTTPGetRequest, boolIncludeQuestionMarkGetMethod, mapHeaderValues, 
                                    objIntegration.strLinker);
                        }
                    }
                }
            }
        } catch(Exception objInternalException) {
            ErrorLogWrapperClass_CF objErrorWrapper = ErrorLogClass_CF.processException(objInternalException, objIntegration, strBody);
            objIntegration.strErrorMessage = objErrorWrapper.strErrorMessage;
            System.debug(objInternalException.getMessage());
            System.debug(objInternalException.getStackTraceString());
        }
        return objIntegration;
    }
    
    /**
     * Extracts the Result.
     *
     * @param boolUseContinuation    Defines if the code will use Continuation to prepare the callout.
     * @param objEndpointRecord    Endpoint URL object.
     * @param strBody    Body of the request.
     * @param intTimeout    Timeout value for the callout (in milliseconds).
     * @param boolIsHTTPGetRequest    Defines if the callout requires an HTTP GET or POST action.
     * @param boolIncludeQuestionMarkGetMethod    Defines if the ? must be appended to the URL, on a GET callout.
     * @param mapHeaderValues    Header values.
     * @return Http Request object.
     */
    private static HttpRequest createHttpRequest(Boolean boolUseContinuation, IntegrationEndpoint_CF__mdt objEndpointRecord, String strBody, Integer intTimeout, 
            Boolean boolIsHTTPGetRequest, Boolean boolIncludeQuestionMarkGetMethod, Map<String, String> mapHeaderValues) {
        HttpRequest objHttpRequest = new HttpRequest();
        if(objEndpointRecord != null) {
            String strEndpointURL = objEndpointRecord.Endpoint_CF__c;
            if(boolIsHTTPGetRequest == null || boolIsHTTPGetRequest) {
                
                //We create the GET request.
                objHttpRequest.setMethod('GET');
                strEndpointURL = setGetParameters(objEndpointRecord, strBody, boolIncludeQuestionMarkGetMethod);
            } else {
                
                //We create the POST request.
                setPostParameters(objHttpRequest, strBody);
            }
            objHttpRequest.setEndpoint(strEndpointURL);
            
            //Now we set the headers.
            setHeaders(objHttpRequest, mapHeaderValues);
            
            //Finally, we set the Continuation parameters.
            setContinuationParameters(objHttpRequest, boolUseContinuation, intTimeout);
        }
        return objHttpRequest;
    }
    
    /**
     * Stores the Request data for tracking purposes, using an external VFP.
     *
     * @param strLinker    Linker value for Request and Response.
     * @param strEndpoint    Endpoint.
     * @param strRequestBody    Body request.
     * @param strResponseBody    Body response.
     * @param strResponseCode    Status Code response.
     */
    private static void saveIntegrationDetailsDifferentInstance(String strLinker, String strEndpoint, String strRequestBody, String strResponseBody, String strResponseCode) {
        try {
            Integer intRootDomainSize = URL.getSalesforceBaseUrl().toExternalForm().length();
            String strCompleteRequestURL = STRING_HELPER_URL + 
                    STRING_HELPER_PARAMETER_ENDPOINT + STRING_HELPER_PARAMETER_NAME_SUFFIX + strEndpoint + STRING_HELPER_PARAMETER_SEPARATOR + 
                    STRING_HELPER_PARAMETER_LINKER + STRING_HELPER_PARAMETER_NAME_SUFFIX + strLinker + STRING_HELPER_PARAMETER_SEPARATOR + 
                    STRING_HELPER_PARAMETER_REQUEST_BODY + STRING_HELPER_PARAMETER_NAME_SUFFIX + EncodingUtil.urlEncode(strRequestBody, STRING_HELPER_URL_ENCODING) + 
                    STRING_HELPER_PARAMETER_SEPARATOR + STRING_HELPER_PARAMETER_RESPONSE_BODY + STRING_HELPER_PARAMETER_NAME_SUFFIX + 
                    EncodingUtil.urlEncode(strResponseBody, STRING_HELPER_URL_ENCODING);
            if((intRootDomainSize + strCompleteRequestURL.length()) > INTEGER_URL_LIMIT) {
                String strRequestURL = STRING_HELPER_URL + 
                        STRING_HELPER_PARAMETER_ENDPOINT + STRING_HELPER_PARAMETER_NAME_SUFFIX + strEndpoint + STRING_HELPER_PARAMETER_SEPARATOR + 
                        STRING_HELPER_PARAMETER_LINKER + STRING_HELPER_PARAMETER_NAME_SUFFIX + strLinker + STRING_HELPER_PARAMETER_SEPARATOR + 
                        STRING_HELPER_PARAMETER_REQUEST_BODY + STRING_HELPER_PARAMETER_NAME_SUFFIX + EncodingUtil.urlEncode(strRequestBody, STRING_HELPER_URL_ENCODING);
                String strResponseURL = STRING_HELPER_URL + 
                        STRING_HELPER_PARAMETER_ENDPOINT + STRING_HELPER_PARAMETER_NAME_SUFFIX + strEndpoint + STRING_HELPER_PARAMETER_SEPARATOR + 
                        STRING_HELPER_PARAMETER_LINKER + STRING_HELPER_PARAMETER_NAME_SUFFIX + strLinker + STRING_HELPER_PARAMETER_SEPARATOR + 
                        STRING_HELPER_PARAMETER_RESPONSE_BODY + STRING_HELPER_PARAMETER_NAME_SUFFIX + EncodingUtil.urlEncode(strResponseBody, STRING_HELPER_URL_ENCODING);
                if((intRootDomainSize + strRequestURL.length()) > INTEGER_URL_LIMIT) {
                    strRequestURL = strRequestURL.substring(0, INTEGER_URL_LIMIT - 1);
                }
                if((intRootDomainSize + strResponseURL.length()) > INTEGER_URL_LIMIT) {
                    strResponseURL = strResponseURL.substring(0, INTEGER_URL_LIMIT - 1);
                }
                try {
                    new PageReference(strRequestURL).getContent();
                } catch(Exception objInternalException) {
                    System.debug(objInternalException.getMessage());
                    System.debug(objInternalException.getStackTraceString());
                    saveIntegrationDetails(strLinker, strEndpoint, strRequestBody, null, strResponseCode);
                }
                try {
                    new PageReference(strResponseURL).getContent();
                } catch(Exception objInternalException) {
                    System.debug(objInternalException.getMessage());
                    System.debug(objInternalException.getStackTraceString());
                    saveIntegrationDetails(strLinker, strEndpoint, null, strResponseBody, strResponseCode);
                }
            } else {
                new PageReference(strCompleteRequestURL).getContent();
            }
        } catch(Exception objInternalException) {
            System.debug(objInternalException.getMessage());
            System.debug(objInternalException.getStackTraceString());
            saveIntegrationDetails(strLinker, strEndpoint, strRequestBody, strResponseBody, strResponseCode);
        }
    }
    
    /**
     * Creates the GET request.
     *
     * @param objEndpointRecord    Endpoint URL object.
     * @param strBody    Body of the request.
     * @param boolIncludeQuestionMarkGetMethod    Defines if the ? must be appended to the URL, on a GET callout.
     * @return Endpoint.
     */
    private static String setGetParameters(IntegrationEndpoint_CF__mdt objEndpointRecord, String strBody, Boolean boolIncludeQuestionMarkGetMethod) {
        String strEndpointURL = objEndpointRecord.Endpoint_CF__c;
        if(String.IsNotBlank(strBody)) {
            if(boolIncludeQuestionMarkGetMethod == null || boolIncludeQuestionMarkGetMethod) {
                strEndpointURL += STRING_GET_SEPARATOR;
            }
            strEndpointURL = strEndpointURL + strBody;
            if(String.IsNotBlank(objEndpointRecord.AuthenticationToken_CF__c)) {
                strEndpointURL += STRING_GET_SEPARATOR_PARAMETER + objEndpointRecord.AuthenticationToken_CF__c;
            }
        } else if(String.IsNotBlank(objEndpointRecord.AuthenticationToken_CF__c)) {
            strEndpointURL += STRING_GET_SEPARATOR + objEndpointRecord.AuthenticationToken_CF__c;
        }
        return strEndpointURL;
    }
    
    /**
     * Creates the POST request.
     *
     * @param objHttpRequest    HTTP Request.
     * @param strBody    Body of the request.
     */
    private static void setPostParameters(HttpRequest objHttpRequest, String strBody) {
        objHttpRequest.setMethod('POST');
        if(String.IsNotBlank(strBody)) {
            objHttpRequest.setBody(strBody);
        }
    }
    
    /**
     * Sets the Headers to the Request.
     *
     * @param objHttpRequest    HTTP Request.
     * @param mapHeaderValues    Header values.
     */
    private static void setHeaders(HttpRequest objHttpRequest, Map<String, String> mapHeaderValues) {
        if(mapHeaderValues != null) {
            for(String strKey : mapHeaderValues.keySet()) {
                objHttpRequest.setHeader(strKey, mapHeaderValues.get(strKey));
            }
        }
    }
    
    /**
     * Creates the Continuation request.
     *
     * @param objHttpRequest    HTTP Request.
     * @param boolUseContinuation    Defines if the code will use Continuation to prepare the callout.
     * @param intTimeout    Timeout value for the callout (in milliseconds).
     */
    private static void setContinuationParameters(HttpRequest objHttpRequest, Boolean boolUseContinuation, Integer intTimeout) {
        if(boolUseContinuation != null && !boolUseContinuation) {
            if(intTimeout == null) {
                intTimeout = INTEGER_DEFAULT_TIMEOUT_VALUE_MILLISECONDS;
            }
            objHttpRequest.setTimeout(intTimeout);
        }
    }
}