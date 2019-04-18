/**
 * Wrapper class for Integration process.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
public class IntegrationWrapperClass_CF {
    
    //Public variables.
    public Integer intTimeout {get; set;}
    public String strResponseStatusCode {get; set;}
    public String strRequestMethod {get; set;}
    public String strRequestBody {get; set;}
    public String strRequestEndpoint {get; set;}
    public String strCallbackMethodName {get; set;}
    public String strLinker {get; set;}
    public String strRequestKey {get; set;}
    public String strResponseBody {get; set;}
    public String strErrorMessage {get; set;}
    public Boolean boolHasError {
        get {
            return String.IsNotBlank(strErrorMessage);
        }
    }
    public Map<String, String> mapHeaderValues {get; set;}
}