/**
 * Utility Test Class.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
@isTest(seeAllData = false)
public class TestUtilitiesClass_CF {

    /**
     * Method to create a Test User for Test Methods.
     * 
     * @param strProfileName    Profile to be assigned to user.
     * @param boolInsertUser    Boolean to indicate if the User must be inserted or not.
     * @return User for RunAs method.
     */
    public static User createTestUser(String strProfileName, Boolean boolInsertUser) {
        Profile objProfile = [SELECT Id FROM Profile WHERE Name = :strProfileName];
        String strOrgId = UserInfo.getOrganizationId();
        Integer intRandomNumber = Integer.valueOf(DateTime.now().getTime());
        String strRandomValue = String.valueOf(DateTime.now().getTime());
        String strUniqueName = strOrgId + intRandomNumber;
        User objTestUser = new User();
        objTestUser.firstname = 'FirstName' + DateTime.now().getTime();
        objTestUser.lastName = 'LastName' + DateTime.now().getTime();
        objTestUser.email = strUniqueName + '@test' + strOrgId + '.org';
        objTestUser.Username = strUniqueName + '@test' + strOrgId + '.org';
        objTestUser.EmailEncodingKey = 'ISO-8859-1';
        objTestUser.Alias = strRandomValue.subString(strRandomValue.length() - 9, strRandomValue.length() - 1);
        objTestUser.TimeZoneSidKey = 'America/Los_Angeles';
        objTestUser.LocaleSidKey = 'en_US';
        objTestUser.LanguageLocaleKey = 'en_US';
        objTestUser.ProfileId = objProfile.Id;
        if(boolInsertUser) {
            DMLOperationsClass_CF.insertRecord(objTestUser);
        }
        return objTestUser;
    }
}