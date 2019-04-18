/**
 * Created by nagesingh on 3/24/2018.
 */

trigger ProcessDoNotCall on Contact (after update) {

    List<Contact> lstCon = [SELECT Id, DoNotCall, Department FROM Contact
            WHERE Department = 'HR' AND Id IN :Trigger.new];
    for(Contact c : lstCon) {
        c.DoNotCall = true;
    }
    update lstCon;
}