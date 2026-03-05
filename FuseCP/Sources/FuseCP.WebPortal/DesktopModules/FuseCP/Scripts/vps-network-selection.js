// Shared checkbox select-all helper for VPS network grids.
(function (global) {
    "use strict";

    global.SelectAllCheckboxes = function (box) {
        var state = box.checked;
        var elm = box.parentElement.parentElement.parentElement.parentElement.getElementsByTagName("INPUT");

        for (var i = 0; i < elm.length; i++) {
            if (elm[i].type === "checkbox" && elm[i].id !== box.id && elm[i].checked !== state && !elm[i].disabled) {
                elm[i].checked = state;
            }
        }
    };
}(window));