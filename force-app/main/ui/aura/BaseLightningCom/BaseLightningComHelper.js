/**
 * Created by nagesingh on 12/6/2019.
 */

({
    dispatchCustomEvents : function () {
        let objResponse = {
            test: 'test123',
            parentTabId : undefined
        };
        window.dispatchEvent(new CustomEvent('TestMessage', {detail: JSON.stringify(objResponse), bubbles: true}));
    },
});