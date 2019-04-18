/**
 * Inner class to store a DML result.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
public class DMLResultClass_CF {
    
    //Public variables.
    public Id objId {get; set;}
    public Boolean boolIsSuccess {get; set;}
    public Boolean boolWasCreated {get; set;}
    public List<String> lstErrorMessages {get; set;}
}