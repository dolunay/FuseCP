// Legacy IE-specific fallback for thumbnail upload controls.
(function () {
    var agentStr = navigator.userAgent;
    if ((agentStr.indexOf("Trident/5") > -1) || (agentStr.indexOf("Trident/4") > -1) || (agentStr.indexOf("Trident") === -1)) {
        $(function () {
            $("#divUpThumbnailphoto").show();
            $(".btnload").hide();
        });
    }
}());
