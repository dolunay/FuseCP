// RDSServers page bootstrap.
(function (global) {
    "use strict";

    if (!global.jQuery) {
        return;
    }

    global.jQuery(function () {
        global.setTimeout(global.checkStatus, 3000);
    });
}(window));