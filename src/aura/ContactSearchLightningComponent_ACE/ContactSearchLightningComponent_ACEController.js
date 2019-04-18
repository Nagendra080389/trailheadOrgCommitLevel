/**
 * Created by nagesingh on 8/16/2018.
 */
 ({
    doInit: function(component, event, helper) {
         // Make the spinner disappear on load and "New Contact" button as disable
        component.set("v.Spinner", false);
        component.find('createNew').set("v.disabled", true);
    },
    doSearch: function(component, event, helper) {
         // Just check for validations on controller and push all the logic to helper
        var checkLastNameValid = component.find("lastName");
        checkLastNameValid.showHelpMessageIfInvalid();
        if (checkLastNameValid.get("v.validity").valid) {
            helper.fetchDataFromServer(component, event, helper);
        }
    },
    createNewCon: function(component, event, helper) {
        // Just check for validations on controller and push all the logic to helper
        var checkLastNameValid = component.find("lastName");
        checkLastNameValid.showHelpMessageIfInvalid();
        if (checkLastNameValid.get("v.validity").valid) {
            helper.createNewContact(component, event, helper);
        }
    },
})