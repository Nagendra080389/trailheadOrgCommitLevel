/**
 * Created by nagesingh on 8/17/2018.
 */

public class ContactWrapperController_ACE {
    /**
   * called from search button on UI
   *
   * @param strFirstName
   * @param strLastName
   *
   * @return List<ContactWrapperForLightning_ACE>
   */
    @AuraEnabled
    public static List<ContactWrapperForLightning_ACE> runSearch(String strFirstName, String strLastName) {

        List<ContactWrapperForLightning_ACE> lstContactWrapper = new List<ContactWrapperForLightning_ACE>();
        String strQueryString = 'select Id, firstname, lastname from contact';
        if (strFirstName != null && !strFirstName.equals('')) {
            strQueryString += ' where firstname LIKE \'' + strFirstName + '%\'';
        }
        if (strLastName != null && !strLastName.equals('')) {
            strQueryString += ' and lastname LIKE \'' + strLastName + '%\'';
        }


        try {
            List<Contact> lstContacts = Database.query(strQueryString);
            IntegrationWrapperClass_CF objResponse = new IntegrationWrapperClass_CF();
            Map<String, Object> mapDeserializedResults = (Map<String, Object>) JSON.deserializeUntyped(objResponse.strResponseBody);
            for (Contact eachContact : lstContacts) {
                String strRecordUrl = Url.getSalesforceBaseUrl().toExternalForm() + '/' + eachContact.Id;
                lstContactWrapper.add(new ContactWrapperForLightning_ACE(eachContact.FirstName, eachContact.Id,
                        eachContact.LastName, strRecordUrl, (String) mapDeserializedResults.get('title')));
            }
        } catch (Exception objException) {
            ErrorLogClass_CF.processException(objException);
        }

        return lstContactWrapper;
    }

    /**
   * Called from button of create new contact
   *
   * @param strFirstName
   * @param strLastName
   *
   * @return List<ContactWrapperForLightning_ACE>
   */
    @AuraEnabled
    public static List<ContactWrapperForLightning_ACE> createNewContact(String strFirstName, String strLastName) {

        List<ContactWrapperForLightning_ACE> lstContactWrapper = new List<ContactWrapperForLightning_ACE>();
        IntegrationWrapperClass_CF objResponse = new IntegrationWrapperClass_CF();
        DMLOperationResultClass_CF objResults = DMLOperationsClass_CF.insertRecord(new Contact(LastName = strLastName, FirstName = strFirstName));
        List<Contact> lstContacts = (List<Contact>) objResults.lstRecords;


        try {
            Map<String, Object> mapDeserializedResults = (Map<String, Object>) JSON.deserializeUntyped(objResponse.strResponseBody);
            for (Contact eachContact : lstContacts) {
                String strRecordUrl = Url.getSalesforceBaseUrl().toExternalForm() + '/' + eachContact.Id;
                lstContactWrapper.add(new ContactWrapperForLightning_ACE(eachContact.FirstName, eachContact.Id,
                        eachContact.LastName, strRecordUrl, (String) mapDeserializedResults.get('title')));
            }
        } catch (Exception objException) {
            ErrorLogClass_CF.processException(objException);
        }

        return lstContactWrapper;
    }

}