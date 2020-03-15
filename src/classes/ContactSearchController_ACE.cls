/**
 * Created by nagesingh on 8/16/2018.
 * Committed via delta deployment:
 * Committed on demo
 */

public class ContactSearchController_ACE extends StaticVariablesClass_CF {

    // The collection of contacts to display
    public List<ContactWrapperForDemo_ACE> lstContactWrapper { get; set; }

    private transient List<Contact> lstContacts;

    private transient String strQueryString;

    // Maintained for making the button disable or enable based on some conditions
    public Boolean boolHideButton { get; set; }

    private transient IntegrationWrapperClass_CF objIntegration;

    /**
     * Contructor of the class
     */
    public ContactSearchController_ACE() {
        boolHideButton = true;
    }

    /**
     * Called from Search button from UI
     *  returns null as we dont want to navigate to any page
     * @return null
     */
    public PageReference runSearch() {

        String strFirstName = Apexpages.currentPage().getParameters().get('firstName');
        String strLastName = Apexpages.currentPage().getParameters().get('lastName');
        strFirstName = String.escapeSingleQuotes(strFirstName);
        strLastName = String.escapeSingleQuotes(strLastName);
        strQueryString = 'select Id, firstname, lastname from contact';
        if (strFirstName != null && !strFirstName.equals('')) {
            strQueryString += ' where firstname LIKE \'' + strFirstName + '%\'';
        }
        if (strLastName != null && !strLastName.equals('')) {
            strQueryString += ' and lastname LIKE \'' + strLastName + '%\'';
        }
        runQuery();
        return null;
    }

    /**
     * Creates contact in the org by passing the first name and last name from the UI.
     *
     *
     * @return null
     */
    public PageReference createContact() {

        try {
            String strFirstName = Apexpages.currentPage().getParameters().get('firstName');
            String strLastName = Apexpages.currentPage().getParameters().get('lastName');
            String strEndpointName = Test.isRunningTest() ? 'Default' : 'TestEndPoint';
            System.debug('strEndpointName -> ' + strEndpointName);
            //IntegrationWrapperClass_CF objClass_cf = IntegrationClass_CF.callout(false, strEndpointName, null, null, null, 10000, null, true, null);
            //DMLOperationResultClass_CF objDMLOperationResult = DMLOperationsClass_CF.insertRecord(new Contact(LastName = strLastName, FirstName = strFirstName));
            //lstContacts = (List<Contact>) objDMLOperationResult.lstRecords;

            //setData(objClass_cf, lstContacts);
        } catch (Exception objException) {
            ErrorLogClass_CF.processException(objException);
        }
        return null;
    }

    /**
     * Runs the actual query
     */
    public Object runQuery() {
        lstContactWrapper = new List<ContactWrapperForDemo_ACE>();
        try {
            //lstContacts = Database.query(strQueryString);
            String strEndpointName = Test.isRunningTest() ? 'Default' : 'TestEndPoint';
            //IntegrationWrapperClass_CF objIntegration = IntegrationClass_CF.callout(false, strEndpointName, null, null, null, 10000, null, true, null);
            objIntegration = IntegrationClass_CF.continuationCallout('JsonRec', 'continuationResponse');
            Continuation objContinuation = new Continuation(1);
            objContinuation.continuationMethod = objIntegration.strCallbackMethodName;

            HttpRequest objHttpRequest = new HttpRequest();
            objHttpRequest.setMethod(objIntegration.strRequestMethod);
            objHttpRequest.setBody(objIntegration.strRequestBody);
            objHttpRequest.setEndpoint(objIntegration.strRequestEndpoint);
            objIntegration.strRequestKey = objContinuation.addHttpRequest(objHttpRequest);

            System.debug('objContinuation -> ' + objContinuation);
            return objContinuation;
            //setData(objIntegration, lstContacts);
        } catch (Exception objException) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, objException.getMessage()));
            return null;
        }
    }

    public Continuation continuation() {

        objIntegration = IntegrationClass_CF.continuationCallout('TestEndPoint', 'continuationResponse');
        System.debug('objContinuation callback -> ' + objIntegration);
        HttpRequest objHttpRequest = new HttpRequest();
        objHttpRequest.setMethod(objIntegration.strRequestMethod);
        objHttpRequest.setBody(objIntegration.strRequestBody);
        objHttpRequest.setEndpoint(objIntegration.strRequestEndpoint);
        Continuation objContinuation = new Continuation(objIntegration.intTimeout);

        objIntegration.strRequestKey = objContinuation.addHttpRequest(objHttpRequest);
        objContinuation.continuationMethod = objIntegration.strCallbackMethodName;
        //throw new CalloutException();
        return objContinuation;
    }

    /**
     * Continuation callback method
     *
     * @return Object.
     */
    public Object continuationResponse() {
        IntegrationWrapperClass_CF objResponse = IntegrationClass_CF.getContinuationResponse(objIntegration);
        System.debug('Response true-> ' + objResponse.strResponseBody == null);
        System.debug('Response -> ' + objResponse.strResponseBody);
        System.debug('objResponse -> ' + objResponse);
        return null;
    }

    /**
     *
     * sets the data to the lstContactWrapper which is returned to the UI
     * @param objIntegration
     * @param lstContacts
     */
    private void setData(IntegrationWrapperClass_CF objIntegration, List<Contact> lstContacts) {
        System.debug(objIntegration.strResponseBody);
        Map<String, Object> mapDeserializedResult = (Map<String, Object>) JSON.deserializeUntyped(objIntegration.strResponseBody);
        for (Contact objContact : lstContacts) {
            String strRecordUrl = Url.getSalesforceBaseUrl().toExternalForm() + '/' + objContact.Id;
            lstContactWrapper.add(new ContactWrapperForDemo_ACE(objContact.FirstName, objContact.Id, objContact.LastName, strRecordUrl, (String) mapDeserializedResult.get('title')));
        }
        if (lstContactWrapper.isEmpty()) {
            boolHideButton = false;
        } else {
            boolHideButton = true;
        }
    }
}