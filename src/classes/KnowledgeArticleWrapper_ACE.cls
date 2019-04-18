/**
 * This is a wrapper class which is used to pass data to UI.
 * <p /><p />
 * Class Name : KnowledgeArticleWrapper_ACE.cls
 * @author Nagendra Singh
 */

public class KnowledgeArticleWrapper_ACE {

    @AuraEnabled public String strId{get;set;}
    @AuraEnabled public String strDisplayName{get;set;}
    @AuraEnabled public List<String> lstComments{get;set;}
    @AuraEnabled public List<String> lstErrorFromServer{get;set;}

    /**
     * Constructor of the class.
     * @param strId - The Id of the Contact.
     * @param strDisplayName - The Knowledge article name to be displayed.
     * @param lstComments - List of comments for CaseComment object.
     * @param lstErrorFromServer - List of errors to be displayed on UI.
     */
    public KnowledgeArticleWrapper_ACE(String strId, String strDisplayName, List<String> lstComments, List<String> lstErrorFromServer){
        this.strId = strId;
        this.strDisplayName = strDisplayName;
        this.lstComments = lstComments;
        this.lstErrorFromServer = lstErrorFromServer;
    }
}