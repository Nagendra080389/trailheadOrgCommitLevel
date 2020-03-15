/**
 * Created by nagesingh on 2/2/2018.
 */

@IsTest
private class TestRestrictContactByName {
    static testMethod void testBehavior() {
        Test.startTest();
        try {
            Contact contact = new Contact();
            contact.LastName = 'VALIDNAME';
            insert contact;

            Contact contact1 = [SELECT Id, LastName FROM Contact WHERE LastName = 'VALIDNAME' LIMIT 1];
            contact1.LastName = 'INVALIDNAME';
            update contact1;

        } catch (Exception e) {

        }

        Test.stopTest();
    }


    static testMethod void testClass1() {
        List<Integer> integers = new List<Integer>();

        integers.add(1);
        integers.add(2);
        integers.add(3);
        integers.add(4);
        integers.add(5);
        integers.add(6);
        integers.add(7);
        integers.add(8);


        for (Integer i = integers.size() - 1; i >= 0; i--) {
            if (integers[i] == 2) {
                integers.remove(i);
            }
        }

        System.debug(integers);
    }
}