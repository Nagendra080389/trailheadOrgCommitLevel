/**
 * Created by nagesingh on 8/16/2018.
 */
 ({
    fetchDataFromServer: function(component, event, helper) {
        // Start showing spinner.
        component.set("v.Spinner", true);
        var firstNameFromUI = component.get("v.contact.FirstName");
        var lastNameFromUI = component.get("v.contact.LastName");
        // Method on Controller side to search for contact
        var actionOnServer = component.get("c.runSearch");
        //Setting the Apex Parameter
        actionOnServer.setParams({
            strFirstName: firstNameFromUI,
            strLastName: lastNameFromUI
        });
        actionOnServer.setCallback(this, function(result) {
            var state = result.getState();
            //check if result is successfull
            if (state == "SUCCESS") {
                var dataFromServer = result.getReturnValue();
                if (dataFromServer.length <= 0) {
                    // Show a toast to user if no data is found
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title: 'No Data Found',
                        message: 'Please create one',
                        duration: '3000',
                        key: 'error',
                        type: 'error',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                    // Only enable the "New Contact" button when there is no contact found
                    component.find('createNew').set("v.disabled", false);
                } else {
                    component.find('createNew').set("v.disabled", true);
                }
                component.set("v.lstContactWrappers", dataFromServer);
            }
            // Stop showing spinner.
            component.set("v.Spinner", false);
        });
        // Fire the action
        $A.enqueueAction(actionOnServer);
    },
    createNewContact: function(component, event, helper) {
        // Start showing spinner.
        component.set("v.Spinner", true);
        var firstNameFromUI = component.get("v.contact.FirstName");
        var lastNameFromUI = component.get("v.contact.LastName");
        // Method on Controller side to create New Contact
        var createActionOnServer = component.get("c.createNewContact");
        //Setting the Apex Parameter
        createActionOnServer.setParams({
            strFirstName: firstNameFromUI,
            strLastName: lastNameFromUI
        });
        createActionOnServer.setCallback(this, function(result) {
            var state = result.getState();
            //check if result is successfull
            if (state == "SUCCESS") {
                var dataFromServer = result.getReturnValue();
                if (dataFromServer.length <= 0) {
                    // Only enable the "New Contact" button when there is no contact found
                    component.find('createNew').set("v.disabled", false);
                } else {
                    component.find('createNew').set("v.disabled", true);
                }
                component.set("v.lstContactWrappers", dataFromServer);
                // Show a toast to user that record is successfully saved
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: 'Success Message',
                    message: 'Record Saved successfully',
                    duration: '3000',
                    key: 'success',
                    type: 'success',
                    mode: 'dismissible'
                });
                toastEvent.fire();
            }
            // Stop showing spinner.
            component.set("v.Spinner", false);
        });
        // Fire the action
        $A.enqueueAction(createActionOnServer);
    }
})