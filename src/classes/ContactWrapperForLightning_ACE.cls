/**
 * Created by nagesingh on 8/17/2018.
 */

public class ContactWrapperForLightning_ACE {

    @AuraEnabled
    public String strFirstName { get; set; }
    @AuraEnabled
    public String strId { get; set; }
    @AuraEnabled
    public String strLastName { get; set; }
    @AuraEnabled
    public String strUrl { get; set; }
    @AuraEnabled
    public String strAdditionalData { get; set; }

    public ContactWrapperForLightning_ACE(String strFirstName, String strId, String strLastName, String strUrl, String strAdditionalData) {
        this.strFirstName = strFirstName;
        this.strId = strId;
        this.strLastName = strLastName;
        this.strUrl = strUrl;
        this.strAdditionalData = strAdditionalData;
    }

}