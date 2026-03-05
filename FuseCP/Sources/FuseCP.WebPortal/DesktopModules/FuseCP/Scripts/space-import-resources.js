// Space import tree interaction helpers.
(function (global) {
    "use strict";

    function isActionImage(target) {
        if (!target || target.tagName !== "IMG") {
            return false;
        }

        var href = target.href || "";
        return href.indexOf("folder.png") === -1 && href.indexOf("empty.gif") === -1;
    }

    global.TreeViewCheckBoxClicked = function (checkEvent) {
        var objElement = null;

        try {
            objElement = global.event ? global.event.srcElement : null;
        } catch (error) {
            objElement = null;
        }

        if (isActionImage(objElement)) {
            global.ShowProgressDialog("");
            global.ShowProgressDialogInternal();
            return;
        }

        if (checkEvent && isActionImage(checkEvent.target)) {
            global.ShowProgressDialog("");
            global.ShowProgressDialogInternal();
        }
    };
}(window));