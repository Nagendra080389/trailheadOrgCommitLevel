/**
 * Description of the class
 * <p /><p />
 * @author Nagendra Kumar Singh
 */
public class CalloutBridge {

    public Object objResponse { get; set; }
    public String caseId { get; set; }

    public CalloutBridge(Object objResponse, String caseId) {
        this.objResponse = objResponse;
        this.caseId = caseId;
    }

}