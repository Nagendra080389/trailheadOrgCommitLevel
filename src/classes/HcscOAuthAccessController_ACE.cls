/**
 * Controller class that will connect to Google Login page and update the OAuth Token in User record.
 * <p /><p />
 * @author Rahul Nanda
 */
public with sharing class HcscOAuthAccessController_ACE{
    
    //variable declaration
    
    private static Boolean boolDMLInsertResult = false;
    private static Boolean boolRetryCallout = true;  
    @TestVisible
    private static final string STRING_GRANT_TYPE='grant_type=authorization_code';
    @TestVisible
    private static final string STRING_SCOPE='https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile';  //Scope URL as per oauth 2.0 guide of the google
    @TestVisible
    private static final string STRING_STATE='/profile';
    @TestVisible
    private static final string STRING_APPROVAL_PROMPT='force';   //Approval Prompt Constant
    @TestVisible
    private static final Integer INTEGER_STATUS_OK = 200;
    private static String strRequestCode;
    private static String strRequestBody;
    private static String strErrorMessage;   
    private static List<User> lstUserRecord ;
    private static List<ErrorLog_CF__c> lstErrorLog;
    private static List<GoogleConnectionSettings__mdt> lstGoogleConnectionSettings;
    private static Map<String,String> mapGoogleAccessSetting = new Map<String,String>();
    private static Map<String,String> mapHeaderValues = new Map<String,String>();
    private static DMLOperationResultClass_CF objDMLOperationInsertOAuthToken;
    private static IntegrationWrapperClass_CF objIntegrationWrapperClass = new IntegrationWrapperClass_CF();
    
    //Getters and setters
    
    public static string strOAuthtoken{get;set;}
    public static String strUrlToRedirect {get;set;} 
    
    /*
     * Method redirects to url to authorize the application
     */ 
    @AuraEnabled
    public static String connect(){        
        
        //Get the Custom metadata
        
        mapGoogleAccessSetting = getCustomMetaData();
        
        if(!mapGoogleAccessSetting.isEmpty())
        {
            strUrlToRedirect = mapGoogleAccessSetting.get('OAuthCodeEndPointUrl_ACE')+'?scope='+EncodingUtil.urlEncode(STRING_SCOPE,'UTF-8')+'&state='+EncodingUtil.urlEncode(STRING_STATE,'UTF-8')+'&redirect_uri='+EncodingUtil.urlEncode(mapGoogleAccessSetting.get('REDIRECT_URL'),'UTF-8')+'&response_type=code&client_id='+mapGoogleAccessSetting.get('ClientID_ACE')+'&approval_prompt='+STRING_APPROVAL_PROMPT;
        }
        
        return strUrlToRedirect;
    }
    
    /*
     * This method will get the OAuth Token and save it in user record
     */   
    @AuraEnabled
    public static String getOAuthToken(String strRequestCode)
    {
        System.debug('strRequestCode'+strRequestCode);
        mapGoogleAccessSetting = getCustomMetaData();
        
        //Get the Userdetail to update the OAuth token in User Record
        
        lstUserRecord = [Select id,OAuthToken_ACE__c from user where id =: UserInfo.getUserId() limit 1];
        
        if(lstUserRecord!=null &&  !mapGoogleAccessSetting.isEmpty())
        {
            strRequestBody='code='+strRequestCode+'&client_id='+mapGoogleAccessSetting.get('ClientID_ACE')+'&client_secret='+mapGoogleAccessSetting.get('ClientSecret_ACE')+'&redirect_uri='+mapGoogleAccessSetting.get('REDIRECT_URL')+'&'+STRING_GRANT_TYPE;   
            
            // Make callout to get access token
            
            doCallout(strRequestBody);
            
            //Update the OAuth token in User Record    
            
            if(strOAuthtoken!=null)
            { 
                lstUserRecord[0].OAuthToken_ACE__c = strOAuthtoken;
                objDMLOperationInsertOAuthToken =  DMLOperationsClass_CF.updateRecords(lstUserRecord);
                for(DMLResultClass_CF objDMLResultClass : objDMLOperationInsertOAuthToken.lstResults) {
                    boolDMLInsertResult = objDMLResultClass.boolIsSuccess;
                }
                
                if(!boolDMLInsertResult)
                {
                    //Fetching the error number to show in UI
                    
                    lstErrorLog = [SELECT Message_CF__c FROM ErrorLog_CF__c WHERE CreatedById =:UserInfo.getUserId() ORDER BY CreatedDate DESC LIMIT 1];
                    for(ErrorLog_CF__c objErrorLog : lstErrorLog) {
                        strErrorMessage = objErrorLog.Message_CF__c;
                    }
                }
            }
            
        }
        return strErrorMessage;
    }
    
    
    /* 
     * This method is used send the request and get a response  
     */
    public static void doCallout(String strRequestBody)
    {
        mapHeaderValues.put('Content-Type', 'application/x-www-form-urlencoded');
        
        //Make a synchronous Callout to get OAuth Token
        IntegrationWrapperClass_CF objIntegrationWrapperClass = IntegrationClass_CF.synchronousCallout('GoogleAuth', strRequestBody, false, mapHeaderValues,10000);
        
        //Check if Response status code is OK
        system.debug('+++objIntegrationWrapperClass+++'+objIntegrationWrapperClass);    
        if(objIntegrationWrapperClass.intResponseStatusCode == INTEGER_STATUS_OK)
        {
            boolRetryCallout = true;
            if(!String.isBlank(objIntegrationWrapperClass.strResponseBody)) {
                Map<String, Object>  mapResponseBody = (Map<String, Object>)JSON.deserializeUntyped(objIntegrationWrapperClass.strResponseBody);
                strOAuthtoken = String.valueOf(mapResponseBody.get('access_token'));
            }
        }
        else if(boolRetryCallout)
        {
            boolRetryCallout = false;
            doCallout(strRequestBody);
        }
        else if(objIntegrationWrapperClass.boolHasError)
        {
            strErrorMessage=objIntegrationWrapperClass.strErrorMessage;
        }
        else
        {  
            if(!String.isBlank(objIntegrationWrapperClass.strResponseBody) )
            {
                Map<String, Object>  mapResponseBody = (Map<String, Object>)JSON.deserializeUntyped(objIntegrationWrapperClass.strResponseBody);
                if (mapResponseBody.get('error_description') != null)
                {
                    strErrorMessage = String.valueOf(mapResponseBody.get('error_description'));   
                }
                
            }
            else
            {
                strErrorMessage = 'Unknown Error Occured';
            }
        }
    }
    
    /*
     * Method to get the Custom Meta Data 
     */
    public static Map<String,String> getCustomMetaData()
    {
        
        for(GoogleConnectionSettings__mdt googleConnectionSetting : [Select DeveloperName,Value_ACE__c from GoogleConnectionSettings__mdt] )
        {
            mapGoogleAccessSetting.put(googleConnectionSetting.DeveloperName,googleConnectionSetting.Value_ACE__c);
        }
        system.debug('+++mapGoogleAccessSetting+++'+mapGoogleAccessSetting);
        return  mapGoogleAccessSetting;
    }
    
}