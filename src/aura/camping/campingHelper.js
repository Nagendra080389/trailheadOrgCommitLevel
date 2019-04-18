/**
 * Description of the campingHelper.js.
 * <p /><p />
 * @author Nagendra Kumar Singh
 */
({

    startShowingText: function (workspaceAPI) {
        workspaceAPI.getFocusedTabInfo().then(function (response) {
            var focusedTabId = response.tabId;
            workspaceAPI.setTabHighlighted({
                tabId: focusedTabId,
                highlighted: true,
                options: {
                    pulse: true,
                    type: "success"
                }
            }).then(function (objPageInfo) {
                workspaceAPI.setTabLabel({
                    tabId: objPageInfo.tabId,
                    label: 'Member Search'
                })
            });
        })
    },

    stopShowingText: function (workspaceAPI) {
        workspaceAPI.getFocusedTabInfo().then(function (response) {
            var focusedTabId = response.tabId;
            workspaceAPI.setTabHighlighted({
                tabId: focusedTabId,
                highlighted: false,
                options: {
                    pulse: true,
                    type: "success"
                }
            }).then(function (objPageInfo) {
                workspaceAPI.setTabLabel({
                    tabId: objPageInfo.tabId,
                    label: ' '
                })
            });
        })
    },
})