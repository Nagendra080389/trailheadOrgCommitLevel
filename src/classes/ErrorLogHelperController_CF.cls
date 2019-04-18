/**
 * This class acts as a helper for the Error Log class, to store Error Log records created from Constructors, Getters and/or Setters.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
public without sharing class ErrorLogHelperController_CF {
    
    /**
     * This method extracts the GET parameter with the serialized Error Log record and sends the value to the future method.
     */
    public void insertExceptionLogRecord() {
        String strErrorLogSerialized = ApexPages.currentPage().getParameters().get(ErrorLogClass_CF.STRING_HELPER_PARAMETER_NAME);
        if(String.IsNotBlank(strErrorLogSerialized)) {
            strErrorLogSerialized = EncodingUtil.urlDecode(strErrorLogSerialized, ErrorLogClass_CF.STRING_HELPER_URL_ENCODING);
            ErrorLogClass_CF.futureInsertErrorLogRecords(strErrorLogSerialized);
        }
    }
}