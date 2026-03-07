// Shared client-side helpers for VPS monitoring pages.
(function (global) {
    "use strict";

    function getFieldValue(id) {
        var node = document.getElementById(id);
        return node ? node.value : "";
    }

    function showAsPanel(chartType, itemIdFieldId) {
        if (!global.jQuery || !global.jQuery.window) {
            return false;
        }

        var itemId = getFieldValue(itemIdFieldId);
        var sUrl = "/DesktopModules/FuseCP/VPSForPC/MonitoringPage.aspx?ItemID=" + itemId + "&chartType=" + chartType;
        var win = global.jQuery.window({
            title: "Performance Counter: " + chartType,
            url: sUrl,
            width: "590px"
        });

        win.getFrame().height(500);
        win.resize(600, 500);
        return false;
    }

    function initDatePicker() {
        if (!global.jQuery || !global.jQuery.fn || !global.jQuery.fn.datepicker) {
            return;
        }

        global.jQuery(document).ready(function () {
            global.jQuery(".txtDateTimePeriod").datepicker();
        });
    }

    global.FuseCPVpsMonitoring = {
        showAsPanel: showAsPanel
    };

    initDatePicker();
}(window));
