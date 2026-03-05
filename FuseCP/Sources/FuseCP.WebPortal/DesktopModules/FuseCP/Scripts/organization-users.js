// Organization users page client helpers.
(function (global) {
    "use strict";

    global.closePopup = function () {
        if (typeof global.$find === "function") {
            var modal = global.$find("DeleteUserModal");
            if (modal && typeof modal.hide === "function") {
                modal.hide();
            }
        }
    };
}(window));