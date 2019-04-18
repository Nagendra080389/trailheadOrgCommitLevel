/**
 * This is a Controller for CaseRelatedArticleComponent_ACE.cmp
 * <p /><p />
 * @author Nagendra Singh
 */
({
    /*
     * Triggered when an event is caught with CaseCreationEvent_ACE.evt.
     */
    showRelatedArticles: function(component, event, helper) {
        helper.showRelatedArticlesHelper(component, event, helper);
    },

    /*
     * Navigates to the specified sObject.
     */
    gotoURL: function(component, event, helper) {
        var viewRecordEvent = $A.get("e.force:navigateToSObject");
        var objectId = event.target.id;
        if (objectId.length > 0) {
            viewRecordEvent.setParams({
                "recordId": event.target.id
            });
            viewRecordEvent.fire();
        }
    },
});