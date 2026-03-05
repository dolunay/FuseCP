// User actions panel progress handlers.
(function (global) {
    "use strict";

    if (!global.jQuery) {
        return;
    }

    global.CloseAndShowUserActionProgress = function (text) {
        global.jQuery(".Popup").hide();
        return global.ShowProgressDialog(text);
    };

    global.ShowUserActionProgress = function (btn) {
        var action = global.jQuery(btn).prev().val();

        if (action === "1") {
            global.ShowProgressDialog("Disabling users...");
        } else if (action === "2") {
            global.ShowProgressDialog("Enabling users...");
        } else if (action === "3") {
            global.ShowProgressDialog("Prepare...");
        } else if (action === "4") {
            global.ShowProgressDialog("Setting VIP...");
        } else if (action === "5") {
            global.ShowProgressDialog("Unsetting VIP...");
        } else if (action === "7" || action === "8") {
            global.ShowProgressDialog("Sending password reset notification...");
        }

        return true;
    };
}(window));