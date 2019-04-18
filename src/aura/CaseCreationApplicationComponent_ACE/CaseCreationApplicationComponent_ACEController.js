/**
 * This is a Controller for CaseCreationApplicationComponent_ACE.cmp.
 * <p /><p />
 * @author Nagendra Singh
 */
({
    /*
     * This function gets called as soon as the component is created on the UI.
     */
    doInit: function (component, event, helper) {
        component.set("v.boolSpinner", false);
    },

    /*
     * Just validate the form fields here and then call the helper method.
     */
    createCaseController: function (component, event, helper) {
        var checkStatusValid = component.find("statusId");
        var checkOriginValid = component.find("originId");
        var checkCommentsValid = component.find("commentId");
        checkStatusValid.showHelpMessageIfInvalid();
        checkOriginValid.showHelpMessageIfInvalid();
        checkCommentsValid.showHelpMessageIfInvalid();
        if (checkStatusValid.get("v.validity").valid && checkOriginValid.get("v.validity").valid && checkCommentsValid.get("v.validity").valid) {
            helper.createCaseHelper(component, event, helper);
        }
    },

    /*
     * Sets all the fields on CaseCreationApplicationComponent_ACE.cmp component to its default state.
     */
    clearFields: function (component, event, helper) {
        component.find("statusId").set('v.value', "");
        component.find("originId").set('v.value', "");
        component.find("commentId").set('v.value', "");
    },

    /*
     * Refreshes the view.
     */
    refreshScreen: function (component, event, helper) {
        component.set('v.boolError', false);
        component.set('v.boolSuccess', false);
        component.find("statusId").set('v.value', "");
        component.find("originId").set('v.value', "");
        component.find("commentId").set('v.value', "");
        $A.get('e.force:refreshView').fire();
    }
});