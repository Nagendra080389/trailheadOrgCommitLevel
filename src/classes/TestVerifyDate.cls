/**
 * Created by nagesingh on 2/2/2018.
 */

@IsTest
private class TestVerifyDate {

    static testMethod void testBehavior() {
        Test.startTest();
        List<User> users1 = UserTest.users;
        System.debug(Limits.getQueries());
        List<User> users2 = UserTest.users;
        System.debug(Limits.getQueries());
        List<User> users3 = UserTest.users;
        System.debug(Limits.getQueries());
        List<User> users4 = UserTest.users;
        System.debug(Limits.getQueries());
        Test.stopTest();
    }

    static testMethod void testBehavior2() {
        Test.startTest();
        List<User> users1 = UserTestModified.users;
        System.debug(Limits.getQueries());
        List<User> users2 = UserTestModified.users;
        System.debug(Limits.getQueries());
        List<User> users3 = UserTestModified.users;
        System.debug(Limits.getQueries());
        List<User> users4 = UserTestModified.users;
        System.debug(Limits.getQueries());
        Test.stopTest();
    }
}