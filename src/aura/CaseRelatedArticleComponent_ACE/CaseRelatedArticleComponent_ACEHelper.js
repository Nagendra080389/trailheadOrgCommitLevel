/**
 * This is a Controller for CaseRelatedArticleComponent_ACE.cmp
 * <p /><p />
 * @author Nagendra Singh
 */
({
    // Helper method for showRelatedArticles
    showRelatedArticlesHelper: function (component, event, helper) {
        var evtParams = event.getParam("CaseComments");
        var findRelatedArticleAction = component.get("c.fetchKnowledgeArticles");

        //Setting the Apex Parameter
        findRelatedArticleAction.setParams({
            lstComments: evtParams
        });

        //Callback for findRelatedArticleAction
        findRelatedArticleAction.setCallback(this, function (result) {
            var state = result.getState();

            //Check if result is successful.
            if (state === "SUCCESS") {
                var knowledgeWrapper = result.getReturnValue();
                var errorList = [];
                for (var i in knowledgeWrapper) {
                    if (knowledgeWrapper[i].lstErrorFromServer.length > 0) {
                        for (var j in knowledgeWrapper[i].lstErrorFromServer) {
                            errorList.push(knowledgeWrapper[i].lstErrorFromServer[j])
                        }
                    }
                }

                //Show the error panel if error list size is greater than 0, else show the knowledge articles.
                if (errorList.length > 0) {
                    component.set('v.showError', true);
                    component.set('v.errorNumber',errorList[0]);
                } else {
                    component.set('v.showError', false);
                    component.set('v.lstArticles', knowledgeWrapper);
                }
            }
        });

        //Fires the findRelatedArticleAction action.
        $A.enqueueAction(findRelatedArticleAction);
    }
});