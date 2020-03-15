/**
 * Created by nagesingh on 8/16/2018.
 * Wrapper class to be passed to UI 
 */

public class ContactWrapperForDemo_ACE {

    public String strFirstName { get; set; }
    public String strId { get; set; }
    public String strLastName { get; set; }
    public String strUrl { get; set; }
    public String strAdditionalData { get; set; }

    public ContactWrapperForDemo_ACE(String strFirstName, String strId, String strLastName, String strUrl, String strAdditionalData) {
        this.strFirstName = strFirstName;
        this.strId = strId;
        this.strLastName = strLastName;
        this.strUrl = strUrl;
        this.strAdditionalData = strAdditionalData;
    }
}