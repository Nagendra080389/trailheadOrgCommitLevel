/**
 * This test class covers basically three scenarios.
 * 1) When a case is inserted and comments are inserted and a Published article is used- Positive scenario.
 * 2) When a case is inserted and comments are inserted and a Non-Published article is used- Positive scenario with no Articles.
 * 3) Test for exceptions by passing values which can throw null.
 * <p /><p />
 * @author Nagendra Singh
 */

@IsTest(SeeAllData=false)
private class CaseCreationLightningControllerTest_ACE {

	private static Id IdknowledgeArticle;

	@TestSetup
	static void setUpData() {

		// Create user for running test classes
		User objUser = TestUtilitiesClass_CF.createTestUser('System Administrator', true);
		System.runAs(objUser) {
			Contact contact = new Contact(FirstName = 'Nagendra', LastName = 'Singh');

			// Insert contact.
			DMLOperationsClass_CF.insertRecord(contact);
			Knowledge__kav objKav = new Knowledge__kav(Title = 'TestTitle', UrlName = 'TestTitle');

			// Insert knowledge article
			DMLOperationsClass_CF.insertRecord(objKav);
			IdknowledgeArticle = objKav.Id;
			System.debug(objKav.Id);

		}
	}

	static testMethod void testBehaviorPublishedArticle() {
		User objUser = [SELECT Id FROM User LIMIT 1];
		System.runAs(objUser) {
			String strContactId = String.valueOf([SELECT Id FROM Contact LIMIT 1].Id);
			System.debug(IdknowledgeArticle);
			Knowledge__kav objKav = [SELECT Id,Title,KnowledgeArticleId FROM knowledge__kav WHERE Id = :IdknowledgeArticle];

			// Publish the article
			KbManagement.PublishingService.publishArticle(objKav.KnowledgeArticleId, true);
			Test.startTest();

			// Set the KAV id to Test class so that SOSL retrieves it properly
			Id [] fixedSearchResults = new Id[1];
			fixedSearchResults[0] = objKav.Id;
			Test.setFixedSearchResults(fixedSearchResults);
			CaseCreationLightingController_ACE.createCase(strContactId, 'New', 'Phone', 'TestTitle');
			List<KnowledgeArticleWrapper_ACE> lstArticleWrapper = CaseCreationLightingController_ACE.fetchKnowledgeArticles(new List<String>{'TestTitle'});
			Test.stopTest();
			Case objCase = [SELECT Id, Status, Origin FROM Case LIMIT 1];
			CaseComment objCaseComment = [SELECT Id, CommentBody, ParentId FROM CaseComment LIMIT 1];

			// Assertions to validate the result
			System.assertEquals(objCase.Id, objCaseComment.ParentId);
			System.assertEquals('New', objCase.Status);
			System.assertEquals('Phone', objCase.Origin);
			System.assertEquals('TestTitle', lstArticleWrapper[0].strDisplayName);
		}
	}

	static testMethod void testBehaviorForNonPublishedArticle() {
		User objUser = [SELECT Id FROM User LIMIT 1];
		System.runAs(objUser) {
			String strContactId = String.valueOf([SELECT Id FROM Contact LIMIT 1].Id);
			Knowledge__kav objKav = [SELECT Id,Title,KnowledgeArticleId FROM knowledge__kav LIMIT 1];
			Test.startTest();

			// Don't publish the article and check if SOSL searches for it.
			Id [] fixedSearchResults = new Id[1];
			fixedSearchResults[0] = objKav.Id;
			Test.setFixedSearchResults(fixedSearchResults);
			CaseCreationLightingController_ACE.createCase(strContactId, 'New', 'Phone', 'TestTitle');
			List<KnowledgeArticleWrapper_ACE> lstArticleWrapper = CaseCreationLightingController_ACE.fetchKnowledgeArticles(new List<String>{'TestTitle'});
			Test.stopTest();
			Case objCase = [SELECT Id, Status, Origin FROM Case LIMIT 1];
			CaseComment objCaseComment = [SELECT Id, CommentBody, ParentId FROM CaseComment LIMIT 1];

			// Assertions to validate the result
			System.assertEquals(objCase.Id, objCaseComment.ParentId);
			System.assertEquals('New', objCase.Status);
			System.assertEquals('Phone', objCase.Origin);
			System.assertEquals('No articles found', lstArticleWrapper[0].strDisplayName);
		}
	}

	static testMethod void testBehaviorNegativeScenario() {
		User objUser = [SELECT Id FROM User LIMIT 1];
		System.runAs(objUser) {
			String strContactId = String.valueOf([SELECT Id FROM Contact LIMIT 1].Id);
			Test.startTest();

			// Create Case with Origin as 'Web' and Status as 'Escalated', this should throw an exception message
			KnowledgeArticleWrapper_ACE objArticleWrapper = CaseCreationLightingController_ACE.createCase(strContactId, 'Escalated', 'Web', 'TestTitle');
			CaseCreationLightingController_ACE.fetchKnowledgeArticles(null);
			Test.stopTest();
			List<Case> lstCases = [SELECT Id FROM Case];
			List<CaseComment> lstCaseComments = [SELECT Id FROM CaseComment];

			// Assertions to validate the result
			System.assertEquals(0, lstCases.size());
			System.assertEquals(0, lstCaseComments.size());
			System.assertEquals(1, objArticleWrapper.lstErrorFromServer.size());
		}
	}
}