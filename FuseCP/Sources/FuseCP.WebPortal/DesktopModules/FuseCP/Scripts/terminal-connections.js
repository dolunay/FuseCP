// Terminal connections page async postback hook.
(function (global) {
    "use strict";

    function endRequest() {
        if (typeof global.CloseProgressDialog === "function") {
            global.CloseProgressDialog();
        }
    }

    if (!global.jQuery || !global.Sys || !global.Sys.WebForms || !global.Sys.WebForms.PageRequestManager) {
        return;
    }

    global.jQuery(function () {
        var prm = global.Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(endRequest);
    });
}(window));