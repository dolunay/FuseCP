(function (window) {
    if (!window) {
        return;
    }

    function buildFeatures(width, height, left, top) {
        return "status=0,resizable=1,scrollbars=1,width=" + width + ",height=" + height + ",top=" + top + ",left=" + left;
    }

    function openPopup(url, width, height, name) {
        var popupName = name || "RDP";
        var left = (window.screen.width - width) / 2;
        var top = (window.screen.height - height) / 2;
        var popup = window.open(url, popupName, buildFeatures(width, height, left, top));

        if (popup && typeof popup.focus === "function") {
            popup.focus();
        }

        return popup;
    }

    window.FuseCPRdpPopup = {
        buildFeatures: buildFeatures,
        open: openPopup
    };
})(window);
