/**
 * wrapper class to process Exceptions.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
public class ErrorLogWrapperClass_CF {
        
    //Public variables.
    public Object objClass {get; set;}
    public Object objAdditionalObject {get; set;}
    public Exception objException {get; set;}
    public String strErrorMessage {get; set;}
    public String strClassName {get; set;}
    public ErrorLog_CF__c objErrorLog {get; set;}
}