// Shared progress-dialog helpers for bulk action dropdown controls.
(function (global) {
    "use strict";

    function getActionValue(btn) {
        if (!global.jQuery || !btn) {
            return "";
        }

        return global.jQuery(btn).prev().val();
    }

    function showByMap(btn, messages) {
        var action = getActionValue(btn);
        var message = messages[action];

        if (message && typeof global.ShowProgressDialog === "function") {
            global.ShowProgressDialog(message);
        }

        return true;
    }

    global.ShowDomainActionProgress = function (btn) {
        return showByMap(btn, {
            "1": "Enabling Dns...",
            "2": "Disabling Dns...",
            "3": "Creating Preview Domain...",
            "4": "Removing Preview Domain..."
        });
    };

    global.ShowMailAccountActionProgress = function (btn) {
        return showByMap(btn, {
            "1": "Enabling mail account...",
            "2": "Disabling mail account..."
        });
    };

    global.ShowWebsiteActionProgress = function (btn) {
        return showByMap(btn, {
            "1": "Stopping websites...",
            "2": "Starting websites...",
            "3": "Restarting App Pools..."
        });
    };
}(window));