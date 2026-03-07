// Shared RDP popup launcher for VPS general pages.
function OpenRemoteDesktopWindow(resolution, width, height) {
    var popup = window.$find ? window.$find("RdpPopup") : null;
    if (popup && typeof popup.hidePopup === "function") {
        popup.hidePopup();
    }

    var cfg = document.getElementById("vpsRdpPageUrl");
    var rdpUrl = cfg ? cfg.value : "";

    if (window.FuseCPRdpPopup && typeof window.FuseCPRdpPopup.open === "function") {
        window.FuseCPRdpPopup.open(rdpUrl + resolution, width, height, "RDP");
        return;
    }

    // Fallback to legacy behavior if shared helper is unavailable.
    var left = (screen.width - width) / 2;
    var top = (screen.height - height) / 2;
    window.open(rdpUrl + resolution, "RDP", "status=0,width=" + width + ",height=" + height + ",top=" + top + ",left=" + left);
}
