// Shared checkbox helpers used by Exchange email-address list pages.
(function (global) {
    "use strict";

    function setChecked(selector, isChecked) {
        var boxes = document.querySelectorAll(selector);
        for (var i = 0; i < boxes.length; i++) {
            boxes[i].checked = isChecked;
        }
    }

    function checkAll(selectAllCheckbox) {
        if (!selectAllCheckbox) {
            return;
        }

        setChecked("td input[type='checkbox']", !!selectAllCheckbox.checked);
    }

    function unCheckSelectAll(selectCheckbox) {
        if (!selectCheckbox || selectCheckbox.checked) {
            return;
        }

        setChecked("th input[type='checkbox']", false);
    }

    // Keep legacy function names for existing inline onclick bindings.
    global.checkAll = checkAll;
    global.unCheckSelectAll = unCheckSelectAll;
}(window));
