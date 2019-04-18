/**
 * This is a helper for CaseCreationApplicationComponent_ACE.cmp.
 * <p /><p />
 * @author Nagendra Singh
 */
({
    /*
     * Helper method for createCaseController.
     */
    createCaseHelper: function (component, event, helper) {

        //Start showing the spinner on UI.
        component.set("v.boolSpinner", true);
        var strStatus = component.find('statusId').get('v.value');
        var strOrigin = component.find('originId').get('v.value');
        var strContactId = component.get("v.idContact");
        var strComments = component.find('commentId').get('v.value');
        var createCaseAction = component.get("c.createCase");

        //Setting the apex parameter.
        createCaseAction.setParams({
            strContactId: strContactId,
            strStatus: strStatus,
            strOrigin: strOrigin,
            strComments: strComments
        });

        //Callback for the createCaseAction Action.
        createCaseAction.setCallback(this, function (result) {
            var state = result.getState();

            //Check if result is successful.
            if (state === "SUCCESS") {
                var knowledgeWrapper = result.getReturnValue();
                if (knowledgeWrapper.lstErrorFromServer.length > 0) {
                    component.set("v.boolError", true);
                    component.set("v.strErrorNumber", knowledgeWrapper.lstErrorFromServer[0]);
                } else {
                    component.set("v.boolSuccess", true);
                    var evt = $A.get("e.c:CaseCreationEvent_ACE");
                    evt.setParams({
                        "CaseComments": knowledgeWrapper.lstComments
                    });
                    evt.fire();
                }
            }

             //Stop showing the spinner on UI.
            component.set("v.boolSpinner", false);
        });

        //Fires the action.
        $A.enqueueAction(createCaseAction);
    },
});