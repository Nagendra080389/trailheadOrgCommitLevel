/**
 * Created by nagesingh on 2/2/2018.
 */

@IsTest
private class LeadProcessorTest {

    static testMethod void testBehavior() {
        Test.startTest();
        Lead lead = null;
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            lead = new Lead(LastName = 'LastName' + i, Company = 'Company' + i);
            leads.add(lead);
        }

        upsert leads;

        Database.executeBatch(new LeadProcessor());
        Test.stopTest();
    }
}