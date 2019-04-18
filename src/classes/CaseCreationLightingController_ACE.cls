/**
 * This class is controller for CaseRelatedArticleComponent_ACE.cmp and CaseCreationApplicationComponent_ACE.cmp
 * Class Name : CaseCreationLightingController_ACE
 * <p /><p />
 * @author Nagendra Singh
 */

public without sharing class CaseCreationLightingController_ACE {
	
	/**
	 * Creates the case and Case Comment record adds errorList to be displayed on UI if any.
	 * @param strContactId The contact Id from page.
	 * @param strStatus The case status from the component.
	 * @param strOrigin The case origin from the component.
	 * @param strComments The case comments from the component.
	 * @return KnowledgeArticleWrapper_ACE Returns an wrapper object to UI.
	 */
	@AuraEnabled
	public static KnowledgeArticleWrapper_ACE createCase(String strContactId, String strStatus, String strOrigin, String strComments) {
		List<String> lstCommentsForArticlesComponents = new List<String>();
		List<String> lstErrors = new List<String>();
		CaseComment objCaseComment = null;
		try {
			Case objCase = new Case(Origin = strOrigin, Status = strStatus, ContactId = Id.valueOf(strContactId));
			DMLOperationResultClass_CF objDmlOperationResultClass = DMLOperationsClass_CF.insertRecord(objCase);
			//Only start creating Case comments when the case is created successfully.
			if (!objDmlOperationResultClass.lstResults.isEmpty()) {
				for (DMLResultClass_CF objDmlResultClass : objDmlOperationResultClass.lstResults) {
					if (objDmlResultClass.boolIsSuccess) {
						objCaseComment = new CaseComment(ParentId = objCase.Id, CommentBody = strComments);
						break;
					}
				}
				if (objCaseComment != null) {
					DMLOperationsClass_CF.insertRecord(objCaseComment);
					//Only add comments to lstCommentsForArticlesComponents if CaseComment is created successfully.
					lstCommentsForArticlesComponents.addAll(strComments.split(' '));
				}
			}
		} catch (Exception objException) {
			//Add the error number if an exception is thrown and then return lstArticleWrapper.
			/*List<ErrorLog_CF__c> lstErrorLog = ErrorLogClass_CF.processException(objException);
			String name = [SELECT Name FROM ErrorLog_CF__c WHERE Id = :lstErrorLog[0].Id].Name;
			lstErrors.add(name);*/
			return new KnowledgeArticleWrapper_ACE(null, null, null, null);
		}
		return new KnowledgeArticleWrapper_ACE(null, null, lstCommentsForArticlesComponents, lstErrors);
	}
	
	/**
	 * This method is called from event listener of CaseRelatedArticleComponent_ACE.cmp. This method fires an
	 * SOSL query on Knowledge Article record and searches for all fields for the @param lstComments passed from UI.
	 * It wraps each knowledge article to a wrapper which just contains an ID and display name.
	 *
	 * @param lstComments The case comments which got inserted from Case
	 *
	 * @return list of KnowledgeArticleWrapper_ACE,
	 */
	@AuraEnabled
	public static List<KnowledgeArticleWrapper_ACE> fetchKnowledgeArticles(List<String> lstComments) {
		List<KnowledgeArticleWrapper_ACE> lstArticleWrapper = new List<KnowledgeArticleWrapper_ACE>();
		List<String> lstErrors = new List<String>();
		Search.SearchResults objSearchResults = null;
		//Generating a dynamic "OR" string which needs to be passed as a search parameter to the SOSL
		try {
			//Joining the list of comments to create the search string
			String strSearchTerms = String.join(lstComments, ' OR ');
			List<Search.SearchResult> lstSearchResults = new List<Search.SearchResult>();
			if (!String.isEmpty(strSearchTerms)) {
				objSearchResults = Search.find('FIND :strSearchTerms IN ALL FIELDS RETURNING KnowledgeArticleVersion(Id, Title, UrlName WHERE PublishStatus = \'Online\' ORDER BY ' +
					'CreatedDate DESC LIMIT 3)');
				lstSearchResults = objSearchResults.get('KnowledgeArticleVersion');
			}
			//Create the wrapper only if data is found else just add 'No articles found' and return it back.
			if (!lstSearchResults.isEmpty()) {
				for (Search.SearchResult searchResult : lstSearchResults) {
					KnowledgeArticleVersion objArticleVersion = (KnowledgeArticleVersion) searchResult.getSObject();
					lstArticleWrapper.add(new KnowledgeArticleWrapper_ACE(String.valueOf(objArticleVersion.Id), objArticleVersion.Title, null, lstErrors));
				}
			} else {
				lstArticleWrapper.add(new KnowledgeArticleWrapper_ACE(null, 'No articles found', null, lstErrors));
			}
		} catch (Exception objException) {
			//Add the error number if an exception is thrown. And then return lstArticleWrapper.
			/*List<ErrorLog_CF__c> lstErrorLog = ErrorLogClass_CF.processExceptionAndReturnErrorLog(objException);
			String name = [SELECT Name FROM ErrorLog_CF__c WHERE Id = :lstErrorLog[0].Id].Name;
			lstErrors.add(name);
			lstArticleWrapper.add(new KnowledgeArticleWrapper_ACE(null, null, null, lstErrors));*/
		}
		return lstArticleWrapper;
	}
}