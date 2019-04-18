/**
 * This class helps to process all the Exceptions in the Apex code.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
public without sharing class ErrorLogClass_CF {
    
    //Public variables.
    public static Boolean BOOL_SKIP_ATTACHMENT_GENERATION = false;
    public static final String STRING_EXCEPTION_MATCHER = '(?i)^(?:class\\.)?([^.]+)\\.?([^\\.\\:]+)?[\\.\\:]?([^\\.\\:]*): line (\\d+), column (\\d+)$';
    public static final String STRING_BREAK_LINE = '\n';
    public static final String STRING_CLASS_METHOD_SEPARATOR = '.';
    public static final String STRING_CONSTRUCTOR_TOKEN = '<init>';
    public static final String STRING_CONSTRUCTOR_TOKEN_REPLACEMENT = '(constructor)';
    public static final String STRING_GETTER_SETTER_TOKEN = '__sfdc_';
    public static final String STRING_GETTER_SETTER_TOKEN_REPLACEMENT = '(getter/setter)';
    public static final String STRING_HELPER_URL = Page.ErrorLogHelperPage_CF.getUrl() + '?';
    public static final String STRING_HELPER_PARAMETER_NAME = 'errorLogRecordSerialized';
    public static final String STRING_HELPER_PARAMETER_NAME_SUFFIX = '=';
    public static final String STRING_HELPER_URL_ENCODING = 'UTF-8';
    public static final Integer INTEGER_URL_LIMIT = 4096;
    public static final Integer INTEGER_LONG_TEXT_AREA_FIELD_LIMIT = 131072;
    
    /**
     * This method processes the exception, extracting the error message and creating the Error Log record.
     *
     * @param objException    Exception to be processed.
     * @return ErrorLogWrapperClass_CF instance with Exception message.
     */
    public static ErrorLogWrapperClass_CF processException(Exception objException) {
        return extractSingleExceptionMessage(processExceptions(prepareSingleExceptionRecord(objException, null, null), null, null, null));
    }
    
    /**
     * This method processes the exception, extracting the error message and creating the Error Log record.
     *
     * @param objException    Exception to be processed.
     * @param boolCreateApexPageMessage    Indicates if the method should include the exception message in the current ApexPage messages.
     * @param strUserFriendlyMessage    User-friendly message related to the exception.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @return ErrorLogWrapperClass_CF instance with Exception message.
     */
    public static ErrorLogWrapperClass_CF processException(Exception objException, Boolean boolCreateApexPageMessage, String strUserFriendlyMessage, ApexPages.Severity objSeverity) {
        return extractSingleExceptionMessage(processExceptions(prepareSingleExceptionRecord(objException, null, null), boolCreateApexPageMessage, strUserFriendlyMessage, objSeverity));
    }
    
    /**
     * This method processes the exception, extracting the error message and creating the Error Log record.
     *
     * @param objException    Exception to be processed.
     * @param boolCreateApexPageMessage    Indicates if the method should include the exception message in the current ApexPage messages.
     * @param strUserFriendlyMessage    User-friendly message related to the exception.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @param objClass    Object to be serialized, with all its values.
     * @return ErrorLogWrapperClass_CF instance with Exception message.
     */
    public static ErrorLogWrapperClass_CF processException(Exception objException, Boolean boolCreateApexPageMessage, String strUserFriendlyMessage, ApexPages.Severity objSeverity, Object objClass) {
        return extractSingleExceptionMessage(processExceptions(prepareSingleExceptionRecord(objException, objClass, null), boolCreateApexPageMessage, strUserFriendlyMessage, 
                objSeverity));
    }
    
    /**
     * This method processes the exception, extracting the error message and creating the Error Log record.
     *
     * @param objException    Exception to be processed.
     * @param objClass    Object to be serialized, with all its values.
     * @return ErrorLogWrapperClass_CF instance with Exception message.
     */
    public static ErrorLogWrapperClass_CF processException(Exception objException, Object objClass) {
        return extractSingleExceptionMessage(processExceptions(prepareSingleExceptionRecord(objException, objClass, null), null, null, null));
    }
    
    /**
     * This method processes the exception, extracting the error message and creating the Error Log record.
     *
     * @param objException    Exception to be processed.
     * @param objClass    Object to be serialized, with all its values.
     * @param objAdditionalObject    Object to be serialize, to provide additional details to the developer.
     * @return ErrorLogWrapperClass_CF instance with Exception message.
     */
    public static ErrorLogWrapperClass_CF processException(Exception objException, Object objClass, Object objAdditionalObject) {
        return extractSingleExceptionMessage(processExceptions(prepareSingleExceptionRecord(objException, objClass, objAdditionalObject), null, null, null));
    }
    
    /**
     * This method extracts the error message from the first error log record.
     *
     * @param lstExceptions    List of wrapped error logs.
     * @return Error message.
     */
    public static ErrorLogWrapperClass_CF extractSingleExceptionMessage(List<ErrorLogWrapperClass_CF> lstExceptions) {
        ErrorLogWrapperClass_CF objResult = new ErrorLogWrapperClass_CF();
        objResult.strErrorMessage = Label.ErrorLog_Class_CF_UnableToProcessException_CF;
        if(lstExceptions != null) {
            for(ErrorLogWrapperClass_CF objNewException : lstExceptions) {
                objResult = objNewException;
                break;
            }
        }
        return objResult;
    }
    
    /**
     * This method prepares the list for the generic method, with one single exception record.
     *
     * @param objException    Exception to be processed.
     * @param objClass    Object to be serialized, with all its values.
     * @param objAdditionalObject    Object to be serialize, to provide additional details to the developer.
     * @return List of Wrapped records.
     */
    public static List<ErrorLogWrapperClass_CF> prepareSingleExceptionRecord(Exception objException, Object objClass, Object objAdditionalObject) {
        List<ErrorLogWrapperClass_CF> lstExceptions = new List<ErrorLogWrapperClass_CF>();
        if(objException != null) {
            ErrorLogWrapperClass_CF objNewException = new ErrorLogWrapperClass_CF();
            objNewException.objException = objException;
            objNewException.objClass = objClass;
            objNewException.objAdditionalObject = objAdditionalObject;
            lstExceptions.add(objNewException);
        }
        return lstExceptions;
    }
    
    /**
     * This method processes a list of exceptions, extracting the error message and creating the Error Log records.
     *
     * @param lstExceptions    Exceptions to be processed.
     * @return Wrapped Error Logs.
     */
    public static List<ErrorLogWrapperClass_CF> processExceptions(List<ErrorLogWrapperClass_CF> lstExceptions) {
        return processExceptions(lstExceptions, null, null, null);
    }
    
    /**
     * This method processes the exception, extracting the error message and creating the Error Log record.
     *
     * @param lstExceptions    Exceptions to be processed.
     * @param boolCreateApexPageMessage    Indicates if the method should include the exception message in the current ApexPage messages.
     * @param strUserFriendlyMessage    User-friendly message related to the exception.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @return String with Exception message.
     */
    public static List<ErrorLogWrapperClass_CF> processExceptions(List<ErrorLogWrapperClass_CF> lstExceptions, Boolean boolCreateApexPageMessage, String strUserFriendlyMessage, 
            ApexPages.Severity objSeverity) {
        List<ErrorLog_CF__c> lstErrorLogs = new List<ErrorLog_CF__c>();
            
        //We set the ApexPage Messages, if requested.
        if(boolCreateApexPageMessage != null && boolCreateApexPageMessage) {
            if(String.IsBlank(strUserFriendlyMessage)) {
                strUserFriendlyMessage = Label.ErrorLog_Class_CF_ExceptionContactAdministrator_CF;
            }
            if(objSeverity == null) {
                objSeverity = ApexPages.Severity.ERROR;
            }
            ApexPages.addMessage(new ApexPages.Message(objSeverity, strUserFriendlyMessage));
        }
        
        //Now we process the exceptions.
        ErrorLog_CF__c objNewException;
        for(ErrorLogWrapperClass_CF objExceptionWrapper : lstExceptions) {
            if(objExceptionWrapper.objException != null) {
                objNewException = new ErrorLog_CF__c();
                objNewException = extractExceptionCaller(objExceptionWrapper.objException, objNewException);
                
                //Setting custom Class name if requested.
                if(String.IsNotBlank(objExceptionWrapper.strClassName)) {
                    objNewException.ClassName_CF__c = objExceptionWrapper.strClassName;
                }
                
                //Setting additional information.
                objNewException.Message_CF__c = objExceptionWrapper.objException.getMessage();
                objNewException.StackTrace_CF__c = objExceptionWrapper.objException.getStackTraceString();
                if(objExceptionWrapper.objClass != null) {
                    objNewException.SerializedClass_CF__c = JSON.serialize(objExceptionWrapper.objClass);
                }
                if(objExceptionWrapper.objAdditionalObject != null) {
                    objNewException.AdditionalSerializedObject_CF__c = JSON.serialize(objExceptionWrapper.objAdditionalObject);
                }
                objExceptionWrapper.strErrorMessage = objExceptionWrapper.objException.getMessage();
                lstErrorLogs.add(objNewException);
            }
        }
            
        //Now, we send the record to the future method, to store the data.
        try {
            String strFinalUrl = STRING_HELPER_URL + STRING_HELPER_PARAMETER_NAME + STRING_HELPER_PARAMETER_NAME_SUFFIX + 
                    EncodingUtil.urlEncode(JSON.serialize(lstErrorLogs), STRING_HELPER_URL_ENCODING);
            if(strFinalUrl.length() > INTEGER_URL_LIMIT) {
                futureInsertErrorLogRecords(JSON.serialize(lstErrorLogs));
            } else if(!Test.isRunningTest()){
                new PageReference(strFinalUrl).getContent();
            }
        } catch(Exception objInternalException) {
            insertErrorLogRecords(lstErrorLogs);
        }
        return lstExceptions;
    }
    
    /**
     * Returns the patter to find the Class Name and Method of the excepsion causer.
     *
     * @param objException    Exception.
     * @param objNewException    Error log record.
     * @return Error Log object.
     */
    public static ErrorLog_CF__c extractExceptionCaller(Exception objException, ErrorLog_CF__c objNewException) {
        if(objNewException == null) {
            objNewException = new ErrorLog_CF__c();
        }
        if(objException != null) {
            Matcher objMatcher = Pattern.compile(STRING_EXCEPTION_MATCHER).matcher(objException.getStackTraceString().substringBefore(STRING_BREAK_LINE));
            if(objMatcher.find()) {
                if(String.isBlank(objMatcher.group(3))) {
                    objNewException.ClassName_CF__c = objMatcher.group(1);
                    objNewException.MethodName_CF__c = prettifyMethodName(objMatcher.group(2));
                } else {
                    objNewException.ClassName_CF__c = objMatcher.group(1) + STRING_CLASS_METHOD_SEPARATOR + objMatcher.group(2);
                    objNewException.MethodName_CF__c = prettifyMethodName(objMatcher.group(3));
                }
            }
        }
        return objNewException;
    }
    
    /**
     * Extracts and prettifies the method names from the exception caller.
     *
     * @param strName    Method name.
     * @return Prettified name.
     */
    public static String prettifyMethodName(String strName) {
        if(String.IsNotBlank(strName)) {
            strName = strName.replace(STRING_CONSTRUCTOR_TOKEN, STRING_CONSTRUCTOR_TOKEN_REPLACEMENT).replace(STRING_GETTER_SETTER_TOKEN, STRING_GETTER_SETTER_TOKEN_REPLACEMENT);
        }
        return strName;
    }
    
    /**
     * This method inserts the Error log records, based on the serialized data.
     *
     * @param strSerializedErrorLogRecords    Serialized Error Log Record.
     */
    @future
    public static void futureInsertErrorLogRecords(String strSerializedErrorLogRecords) {
        try {
            insertErrorLogRecords((List<ErrorLog_CF__c>) JSON.deserialize(strSerializedErrorLogRecords, List<ErrorLog_CF__c>.class));
        } catch(Exception objInternalException) {
            System.debug(objInternalException.getMessage());
            System.debug(objInternalException.getStackTraceString());
        }
    }
    
    /**
     * This method inserts Error log records.
     *
     * @param lstErrorLogRecords    List of Error Log records.
     */
    public static void insertErrorLogRecords(List<ErrorLog_CF__c> lstErrorLogRecords) {
        if(lstErrorLogRecords != null && lstErrorLogRecords.size() > 0) {
            Integer intCounter = 0;
            String strTrimmedMessage = 'Data Trimmed by Developer: ';
            Attachment objAttachment;
            List<Attachment> lstAttachments = new List<Attachment>();
            
            //We first prepare all the Error Logs and Attachments (if any).
            for(ErrorLog_CF__c objError : lstErrorLogRecords) {
                intCounter++;
                objError.ExternalId_CF__c = Userinfo.getUserId() + DateTime.now() + ':' + DateTime.now().millisecond() + ':' + intCounter;
                if(String.IsNotBlank(objError.SerializedClass_CF__c) && objError.SerializedClass_CF__c.length() > INTEGER_LONG_TEXT_AREA_FIELD_LIMIT) {
                    if(BOOL_SKIP_ATTACHMENT_GENERATION) {
                        objError.SerializedClass_CF__c = strTrimmedMessage + objError.SerializedClass_CF__c;
                        objError.SerializedClass_CF__c = objError.SerializedClass_CF__c.substring(0, INTEGER_LONG_TEXT_AREA_FIELD_LIMIT - 1);
                    } else {
                        objAttachment = new Attachment();
                        objAttachment.Body = Blob.valueOf(objError.SerializedClass_CF__c);
                        objAttachment.Name = 'SerializedClass.txt';
                        objAttachment.Description = objError.ExternalId_CF__c;
                        lstAttachments.add(objAttachment);
                        objError.SerializedClass_CF__c = 'Please see ' + objAttachment.Name + ' attached file.';
                    }
                }
                if(String.IsNotBlank(objError.AdditionalSerializedObject_CF__c) && objError.AdditionalSerializedObject_CF__c.length() > INTEGER_LONG_TEXT_AREA_FIELD_LIMIT) {
                    if(BOOL_SKIP_ATTACHMENT_GENERATION) {
                        objError.AdditionalSerializedObject_CF__c = strTrimmedMessage + objError.AdditionalSerializedObject_CF__c;
                        objError.AdditionalSerializedObject_CF__c = objError.AdditionalSerializedObject_CF__c.substring(0, INTEGER_LONG_TEXT_AREA_FIELD_LIMIT - 1);
                    } else {
                        objAttachment = new Attachment();
                        objAttachment.Body = Blob.valueOf(objError.AdditionalSerializedObject_CF__c);
                        objAttachment.Name = 'AdditionalSerializedClass.txt';
                        objAttachment.Description = objError.ExternalId_CF__c;
                        lstAttachments.add(objAttachment);
                        objError.AdditionalSerializedObject_CF__c = 'Please see ' + objAttachment.Name + ' attached file.';
                    }
                }
            }
            
            //Now we prepare the common list.
            insert lstErrorLogRecords;
            
            //Now we create the attachments.
            if(!BOOL_SKIP_ATTACHMENT_GENERATION) {
                for(Attachment objNewAttachment : lstAttachments) {
                    for(ErrorLog_CF__c objError : lstErrorLogRecords) {
                        if(objNewAttachment.Description == objError.ExternalId_CF__c) {
                            objNewAttachment.ParentId = objError.Id;
                            objNewAttachment.Description = null;
                        }
                    }
                }
                
                //Finally, we insert the attachments.
                if(lstAttachments.size() > 0) {
                    insert lstAttachments;
                }
            }
        }
    }
}