/**
 * Created by nagesingh on 8/17/2018.
 */

@IsTest
private class ContactSearchControllerTest_ACE {

    static testMethod void testBehaviorPositiveScenario() {

        String strFirstName = 'Nagendra';
        String strLastName = 'Singh';
        Contact objContact = new Contact(FirstName = strFirstName, LastName = strLastName);
        DMLOperationsClass_CF.insertRecord(objContact);
        ApexPages.currentPage().getParameters().put('firstName',strFirstName);
        ApexPages.currentPage().getParameters().put('lastName',strLastName);
        String strResponse = '{"title":"qui est esse"}';
        Test.StartTest();
        //We first set the fake web service.
        Test.setMock(HttpCalloutMock.class, new JsonServiceTest_ACE(strResponse));
        ContactSearchController_ACE objContactSearchControllerAce = new ContactSearchController_ACE();
        objContactSearchControllerAce.runSearch();
        Test.StopTest();


    }

    static testMethod void testBehaviorNegativeScenario() {

        String strFirstName = 'Nagendra';
        String strLastName = 'Singh';
        ApexPages.currentPage().getParameters().put('firstName',strFirstName);
        ApexPages.currentPage().getParameters().put('lastName',strLastName);
        String strResponse = '{"title":"qui est esse"}';
        Test.StartTest();
        //We first set the fake web service.
        Test.setMock(HttpCalloutMock.class, new JsonServiceTest_ACE(strResponse));
        ContactSearchController_ACE objContactSearchControllerAce = new ContactSearchController_ACE();
        objContactSearchControllerAce.runSearch();
        Test.StopTest();


    }

    static testMethod void testBehaviorNegativeScenarioException() {

        String strFirstName = 'Nagendra';
        String strLastName = 'Singh';
        ApexPages.currentPage().getParameters().put('firstName',strFirstName);
        ApexPages.currentPage().getParameters().put('lastName',strLastName);
        String strResponse = null;
        Test.StartTest();
        //We first set the fake web service.
        Test.setMock(HttpCalloutMock.class, new JsonServiceTest_ACE(strResponse));
        ContactSearchController_ACE objContactSearchControllerAce = new ContactSearchController_ACE();
        objContactSearchControllerAce.runSearch();
        Test.StopTest();


    }

    static testMethod void testBehaviorPositiveScenarioCreateCon() {

        String strFirstName = 'Nagendra';
        String strLastName = 'Singh';
        ApexPages.currentPage().getParameters().put('firstName',strFirstName);
        ApexPages.currentPage().getParameters().put('lastName',strLastName);
        String strResponse = '{"title":"qui est esse"}';
        Test.StartTest();
        //We first set the fake web service.
        Test.setMock(HttpCalloutMock.class, new JsonServiceTest_ACE(strResponse));
        ContactSearchController_ACE objContactSearchControllerAce = new ContactSearchController_ACE();
        objContactSearchControllerAce.createContact();
        Test.StopTest();


    }

    static testMethod void testBehaviorNegativeScenarioCreateCon() {

        String strFirstName = 'Nagendra%';
        String strLastName = 'Singh';
        ApexPages.currentPage().getParameters().put('firstName',strFirstName);
        ApexPages.currentPage().getParameters().put('lastName',strLastName);
        String strResponse = '{"title":"qui est esse"}';
        Test.StartTest();
        //We first set the fake web service.
        Test.setMock(HttpCalloutMock.class, new JsonServiceTest_ACE(strResponse));
        ContactSearchController_ACE objContactSearchControllerAce = new ContactSearchController_ACE();
        objContactSearchControllerAce.createContact();
        Test.StopTest();


    }
}