/**
 * Created by nagesingh on 2/2/2018.
 */

public class AccountProcessor {

    @Future
    public static void countContacts(List<Id> accIds) {

        List<Account> accountsToBeUpdated = new List<Account>();
        Map<Id, Contact> contactMap = new Map<Id, Contact>([SELECT Id, AccountId, Account.Id, Account.Number_of_Contacts__c FROM Contact WHERE AccountId IN :accIds]);
        for (Id id : accIds) {
            Integer count = 1;
            Id accountId = null;
            for (Contact contact : contactMap.values()) {
                if (contact.AccountId == id) {
                    contact.Account.Number_of_Contacts__c = count++;
                    accountId = contact.AccountId;
                }
            }
            if (accountId != null) {
                accountsToBeUpdated.add(new Account(Id = accountId, Number_of_Contacts__c = count));
            }
        }

        update accountsToBeUpdated;

    }

}