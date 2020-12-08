/**
 * Created by Nagendra on 11/28/2020.
 */

@IsTest
public with sharing class abcServiceTest {
    @TestSetup
    public static void testSetup(){

    }


    @IsTest static void testPositiveScenario(){

        User u = [SELECT Id FROM User WHERE Name LIKE '%Nagendra%' LIMIT 1];
        System.runAs(u){


            UserAppInfo userAppInfoObj = new UserAppInfo(AppDefinitionId = '12344455');
            insert userAppInfoObj;
            /*AppDefinition appDefinitionObj = new AppDefinition(DurableId = userAppInfoObj.AppDefinitionId, Label = 'Test App AA');
            insert appDefinitionObj;
            String appName = appDefinitionObj.Label;*/

            //Test that records are inserted
            List<Account> testList = abcService.xyzMethod();
            System.debug('testList--------->' + testList);
            System.debug('testList--------->' + testList.size());
            System.assertEquals(testList.size(),2);

        }
    }
}