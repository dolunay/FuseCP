// Shared client-side helpers for Proxmox VpsDetailsGeneral page.
(function (global) {
    "use strict";

    function getRdpUrl() {
        var field = document.getElementById("proxmoxRdpPageUrl");
        return field ? field.value : "";
    }

    function openRemoteDesktopWindow(width, height) {
        var popup = global.$find ? global.$find("RdpPopup") : null;
        if (popup && typeof popup.hidePopup === "function") {
            popup.hidePopup();
        }

        var rdpUrl = getRdpUrl();
        if (global.FuseCPRdpPopup && typeof global.FuseCPRdpPopup.open === "function") {
            global.FuseCPRdpPopup.open(rdpUrl, width, height, "RDP");
            return false;
        }

        var left = (screen.width - width) / 2;
        var top = (screen.height - height) / 2;
        global.window.open(rdpUrl, "RDP", "status=0,width=" + width + ",height=" + height + ",top=" + top + ",left=" + left).focus();
        return false;
    }

    function initThumbnailRefresh(imageId) {
        var img = document.getElementById(imageId);
        if (!img) {
            return;
        }

        var imgUrl = img.src;
        img.onload = function () {
            global.setTimeout(function () {
                img.src = imgUrl + "&stamp=" + Math.random();
            }, 1000);
        };
        img.src = imgUrl + "&stamp=" + Math.random();
    }

    global.FuseCPProxmoxVpsGeneral = {
        openRemoteDesktopWindow: openRemoteDesktopWindow,
        initThumbnailRefresh: initThumbnailRefresh
    };

    if (document.getElementById("imgThumbnail")) {
        initThumbnailRefresh("imgThumbnail");
    }
}(window));
