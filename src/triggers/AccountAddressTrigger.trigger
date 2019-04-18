/**
 * Created by nagesingh on 2/2/2018.
 */

trigger AccountAddressTrigger on Account (before insert, before update) {


    List<Account> accounts = (List<Account>) Trigger.new;

    for (Account account : accounts){
        if(account.Match_Billing_Address__c && account.BillingPostalCode != null){
            account.ShippingPostalCode = account.BillingPostalCode;
        }
    }

}