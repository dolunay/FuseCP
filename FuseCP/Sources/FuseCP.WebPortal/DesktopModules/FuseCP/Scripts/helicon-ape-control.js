// Shared security panel toggling for Helicon Ape controls.
$(document).ready(function () {
    $("#ShowSecurityPanelButton").click(function () {
        $("#ShowSecurityPanelButton").slideUp();
        $("#SecurityPanel").slideDown();
    });
});