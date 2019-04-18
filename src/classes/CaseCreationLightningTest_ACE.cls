/**
 * Created by nagesingh on 8/23/2018.
 * <p>This test class covers CaseCreationLightingController_ACE.cls.
 * </p>
 * Class Name : CaseCreationLightningTest_ACE
 */

@IsTest(SeeAllData=false)
private class CaseCreationLightningTest_ACE {

	@TestSetup
	static void setUpData() {

		//Create user for running test classes
		User objUser = TestUtilitiesClass_CF.createTestUser('System Administrator', true);
		System.runAs(objUser) {
			Contact contact = new Contact(FirstName = 'Nagendra', LastName = 'Singh');

			//Insert contact.
			DMLOperationsClass_CF.insertRecord(contact);
		}
	}
	//When a case is inserted and comments are inserted and a Published article is used- Positive scenario.
	static testMethod void testBehaviorPublishedArticle() {
		User objUser = [SELECT Id FROM User LIMIT 1];
		System.runAs(objUser) {
			String strContactId = String.valueOf([SELECT Id FROM Contact LIMIT 1].Id);
			Knowledge__kav objKav = new Knowledge__kav(Title = 'TestTitle', UrlName = 'TestTitle');
			DMLOperationsClass_CF.insertRecord(objKav);
			objKav = [SELECT Id,Title,KnowledgeArticleId FROM knowledge__kav WHERE Id = :objKav.Id];

			//Publish the article
			KbManagement.PublishingService.publishArticle(objKav.KnowledgeArticleId, true);
			Test.startTest();

			//Set the KAV id to Test class so that SOSL retrieves it properly
			Id [] fixedSearchResults = new Id[1];
			fixedSearchResults[0] = objKav.Id;
			Test.setFixedSearchResults(fixedSearchResults);
			CaseCreationLightingController_ACE.createCase(strContactId, 'New', 'Phone', 'TestTitle');
			List<KnowledgeArticleWrapper_ACE> lstArticleWrapper = CaseCreationLightingController_ACE.fetchKnowledgeArticles(new List<String>{
					'TestTitle'
			});
			Test.stopTest();
			Case objCase = [SELECT Id, Status, Origin FROM Case LIMIT 1];
			CaseComment objCaseComment = [SELECT Id, CommentBody, ParentId FROM CaseComment LIMIT 1];

			//Assertions to validate the result
			System.assertEquals(objCase.Id, objCaseComment.ParentId);
			System.assertEquals('New', objCase.Status);
			System.assertEquals('Phone', objCase.Origin);
			System.assertEquals('TestTitle', lstArticleWrapper[0].strDisplayName);
		}
	}

	//When a case is inserted and comments are inserted and a Non-Published article is used- Positive scenario with no Articles.
	static testMethod void testBehaviorForNonPublishedArticle() {
		User objUser = [SELECT Id FROM User LIMIT 1];
		System.runAs(objUser) {
			String strContactId = String.valueOf([SELECT Id FROM Contact LIMIT 1].Id);
			Knowledge__kav objKav = new Knowledge__kav(Title = 'TestTitle', UrlName = 'TestTitle');
			DMLOperationsClass_CF.insertRecord(objKav);
			objKav = [SELECT Id,Title,KnowledgeArticleId FROM knowledge__kav WHERE Id = :objKav.Id];
			Test.startTest();

			//Don't publish the article and check if SOSL searches for it.
			Id [] fixedSearchResults = new Id[1];
			fixedSearchResults[0] = objKav.Id;
			Test.setFixedSearchResults(fixedSearchResults);
			CaseCreationLightingController_ACE.createCase(strContactId, 'New', 'Phone', 'TestTitle');
			List<KnowledgeArticleWrapper_ACE> lstArticleWrapper = CaseCreationLightingController_ACE.fetchKnowledgeArticles(new List<String>{
					'TestTitle'
			});
			Test.stopTest();
			Case objCase = [SELECT Id, Status, Origin FROM Case LIMIT 1];
			CaseComment objCaseComment = [SELECT Id, CommentBody, ParentId FROM CaseComment LIMIT 1];

			//Assertions to validate the result
			System.assertEquals(objCase.Id, objCaseComment.ParentId, 'CaseComment parent ID same as Case Id');
			System.assertEquals('New', objCase.Status, 'New Case with status NEW');
			System.assertEquals('Phone', objCase.Origin, 'New Case origin with origin PHONE');
			System.assertEquals('No articles found', lstArticleWrapper[0].strDisplayName, 'No articles found');
		}
	}

	//Test for exceptions by passing values which can throw null.
	static testMethod void testBehaviorNegativeScenario() {
		User objUser = [SELECT Id FROM User LIMIT 1];
		System.runAs(objUser) {
			String strContactId = String.valueOf([SELECT Id FROM Contact LIMIT 1].Id);
			Test.startTest();

			//Create Case with Origin as 'Web' and Status as 'Escalated', this should throw an exception message
			KnowledgeArticleWrapper_ACE objArticleWrapper = CaseCreationLightingController_ACE.createCase(strContactId, 'Escalated', 'Web', 'TestTitle');
			CaseCreationLightingController_ACE.fetchKnowledgeArticles(null);
			Test.stopTest();
			List<Case> lstCases = [SELECT Id FROM Case];
			List<CaseComment> lstCaseComments = [SELECT Id FROM CaseComment];

			//Assertions to validate the result
			System.assertEquals(0, lstCases.size(), 'No cases created');
			System.assertEquals(0, lstCaseComments.size(), 'No casecomments created');
			System.assertEquals(1, objArticleWrapper.lstErrorFromServer.size(), 'Exception thrown from method createCase');
		}
	}
}