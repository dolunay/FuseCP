// Shared tab click helper to keep legacy progress dialog behavior consistent.
(function (global) {
    "use strict";

    global.tabClicked = function () {
        if (typeof global.ShowProgressDialog === "function") {
            global.ShowProgressDialog("Loading");
        }

        if (typeof global.ShowProgressDialogInternal === "function") {
            global.ShowProgressDialogInternal();
        }

        return true;
    };
}(window));