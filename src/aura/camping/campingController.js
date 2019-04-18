/**
 * Description of the campingController.js.
 * <p /><p />
 * @author Nagendra Kumar Singh
 */
({

    setFocusedTabHighlighted: function (component, event, helper) {
        var workspaceAPI = component.find("workspace");
        var counter = 1;
        setInterval(function() {
            if (counter++ % 2) {
                helper.startShowingText(workspaceAPI);
            } else {
                helper.stopShowingText(workspaceAPI);
            }
        }, 2000);
    }
})