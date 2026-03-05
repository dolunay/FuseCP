// Shared helper for password fields that should mask on blur and reveal on focus.
(function (global) {
    "use strict";

    if (!global.jQuery) {
        return;
    }

    global.jQuery(function ($) {
        $(".hideContentOnBlur")
            .off("blur.fusecpPassword focus.fusecpPassword")
            .on("blur.fusecpPassword", function () {
                this.type = "password";
            })
            .on("focus.fusecpPassword", function () {
                this.type = "text";
            });
    });
}(window));