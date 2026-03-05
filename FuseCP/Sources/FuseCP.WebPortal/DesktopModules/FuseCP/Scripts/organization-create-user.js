// Shared display-name builder for organization user creation forms.
(function (global) {
    "use strict";

    function byId(id) {
        return document.getElementById(id);
    }

    function getValue(id) {
        var node = byId(id);
        return node ? node.value : "";
    }

    function updateDisplayName(config) {
        var display = byId(config.displayId);
        if (!display) {
            return;
        }

        var first = getValue(config.firstId);
        var initials = getValue(config.initialsId);
        var last = getValue(config.lastId);
        var value = "";

        if (first !== "") {
            value += first + " ";
        }
        if (initials !== "") {
            value += initials + " ";
        }
        if (last !== "") {
            value += last;
        }

        display.value = value;
    }

    global.FuseCPOrganizationCreateUser = {
        buildDisplayName: function () {
            var host = document.getElementById("orgCreateUserConfig");
            if (!host) {
                return;
            }

            updateDisplayName({
                displayId: host.getAttribute("data-display-id"),
                firstId: host.getAttribute("data-first-id"),
                initialsId: host.getAttribute("data-initials-id"),
                lastId: host.getAttribute("data-last-id")
            });
        }
    };
}(window));