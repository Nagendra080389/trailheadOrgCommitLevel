/**
 * Created by nagesingh on 2/21/2018. Yetyt
 */

@IsTest(SeeAllData = false)
private class AnimalLocatorTest {
    static testMethod void testGetCallout() {
        // Set mock callout class
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        string animal_name = AnimalLocator.getAnimalNameById(1);
        String expectedValue = 'chicken';
        System.assertEquals(animal_name, expectedValue);
    }
}