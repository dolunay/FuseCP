// Shared client-side helpers for VPS2012 general page.
(function (global) {
    "use strict";

    function readTextById(id) {
        var node = document.getElementById(id);
        if (!node) {
            return "";
        }

        return node.innerText || node.textContent || "";
    }

    function openRemoteDesktopWindow(resolution, width, height) {
        var popup = global.$find ? global.$find("RdpPopup") : null;
        if (popup && typeof popup.hidePopup === "function") {
            popup.hidePopup();
        }

        var rdpUrl = readTextById("litRdpPageUrl");
        var finalUrl = rdpUrl + resolution;

        if (global.FuseCPRdpPopup && typeof global.FuseCPRdpPopup.open === "function") {
            global.FuseCPRdpPopup.open(finalUrl, width, height, "RDP");
            return;
        }

        var left = (screen.width - width) / 2;
        var top = (screen.height - height) / 2;
        global.window.open(finalUrl, "RDP", "status=0,width=" + width + ",height=" + height + ",top=" + top + ",left=" + left);
    }

    function updateNameChanged(chk) {
        var warning = document.getElementById("divReboot");
        if (!warning || !chk) {
            return;
        }

        if (chk.checked) {
            warning.classList.remove("hidden");
        } else {
            warning.classList.add("hidden");
        }
    }

    global.OpenRemoteDesktopWindow = openRemoteDesktopWindow;
    global.updateNameChanged = updateNameChanged;
}(window));
