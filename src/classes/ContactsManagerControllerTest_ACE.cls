/**
 * Test class for ContactsManagerController_ACE.
 * <p /><p />
 * @author Nikhil Palekar
 */
@isTest
public class ContactsManagerControllerTest_ACE {
    /**
     * This method setup the data for test methods.
     */
	@testSetup
    static void createDataForTesting(){
        Contact objContact = new Contact(FirstName='Nikhil', LastName='Palekar');
        DMLOperationsClass_CF.insertRecord(objContact);
    }
    
    /*
     * This method test the create new contact functionality and checks if contact created using assert statement.
     */
    static testMethod void testCreateNewContact(){
        Test.startTest();
        ContactsManagerController_ACE objContactsManagerController_ACE = new ContactsManagerController_ACE();
        objContactsManagerController_ACE.strNewFirstName = 'Nik';
        objContactsManagerController_ACE.strNewLastName = 'Pal';
        objContactsManagerController_ACE.createNewContact();
        System.assertEquals(2, [SELECT Count() FROM Contact]);
        Test.stopTest();
    }
    
    /*
     * This method test the search contact functionality and checks if correct number of contacts are returned.
     */
    static testMethod void testSearchContact(){
        Test.startTest();
        ContactsManagerController_ACE objContactsManagerController_ACE = new ContactsManagerController_ACE();
        objContactsManagerController_ACE.strNewFirstName = 'Nik';
        objContactsManagerController_ACE.strNewLastName = 'Pal';
        //setting fake web service call
        Test.setMock(HttpCalloutMock.class, new ContactsManagerCalloutTest_ACE()); 
        objContactsManagerController_ACE.searchContacts();
        ContactsManagerController_ACE objContactsManagerController_ACEWithoutFirstName = new ContactsManagerController_ACE();
        objContactsManagerController_ACEWithoutFirstName.strNewLastName = 'Pal';
        System.assertEquals(1, [SELECT Count() FROM Contact]);
        Test.stopTest();
    }
    
    /*
     * This method test the search contact functionality but only with the last name and 
     * checks if correct number of contacts are returned.
     */
    static testMethod void testSearchContactWithoutFirstName(){
        Test.startTest();
        ContactsManagerController_ACE objContactsManagerController_ACE = new ContactsManagerController_ACE();
        objContactsManagerController_ACE.strNewFirstName = '';
        objContactsManagerController_ACE.strNewLastName = 'Pal';
        //setting fake web service call
        Test.setMock(HttpCalloutMock.class, new ContactsManagerCalloutTest_ACE()); 
        objContactsManagerController_ACE.searchContacts();
        System.assertEquals(1, [SELECT Count() FROM Contact]);
        Test.stopTest();
    }
    
    /*
     * This method tests the exception handling.
     */
    static testMethod void testException(){
        Test.startTest();
        ContactsManagerController_ACE objContactsManagerController_ACE = new ContactsManagerController_ACE();
        objContactsManagerController_ACE.strNewFirstName = '';
        objContactsManagerController_ACE.strNewLastName = '';
        objContactsManagerController_ACE.createNewContact();
        System.assertEquals(1, [SELECT Count() FROM Contact]);
        Test.stopTest();
    }
}