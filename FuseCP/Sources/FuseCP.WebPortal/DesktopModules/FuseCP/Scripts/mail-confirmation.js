// Shared mail-page confirmation helper with progress dialog integration.
(function (global) {
    "use strict";

    global.fuseCpConfirmWithProgress = function (confirmMessage, progressMessage) {
        if (!global.confirm(confirmMessage)) {
            return false;
        }

        if (typeof global.ShowProgressDialog === "function") {
            global.ShowProgressDialog(progressMessage);
        }

        return true;
    };
}(window));