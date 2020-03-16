// This is a commit commit from UCS
//Test asd 74
@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {

    @HttpGet
    global static Account getAccount() {
        Vehicle__c vehicle = new Vehicle__c();
        RestRequest req = RestContext.request;
        String accId = req.requestURI.substringBetween('Accounts/', '/contacts');
        Account acc = [
                SELECT Id, Name, (SELECT Id, Name FROM Contacts)
                FROM Account
                WHERE Id = :accId
        ];
        return acc;
    }
    // This is UCD Deployment
    public static void testThisMethod() {
        System.debug('');
    }
}
