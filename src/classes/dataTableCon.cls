/**
 * Description of the dataTableCon.
 * <p /><p />
 * @author Nagendra Kumar Singh
 */
public with sharing class dataTableCon {
    List<Account> accounts;

    public List<Account> getAccounts() {
        if (accounts == null)
            accounts = [SELECT name, owner.name FROM account LIMIT 10];
        return accounts;
    }
}