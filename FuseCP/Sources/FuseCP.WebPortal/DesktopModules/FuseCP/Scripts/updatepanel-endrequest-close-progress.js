// Shared helper to close progress dialog after UpdatePanel async callbacks.
$(document).ready(function () {
    if (!window.Sys || !Sys.WebForms || !Sys.WebForms.PageRequestManager) {
        return;
    }

    var prm = Sys.WebForms.PageRequestManager.getInstance();
    prm.add_endRequest(function () {
        if (typeof CloseProgressDialog === "function") {
            CloseProgressDialog();
        }
    });
});