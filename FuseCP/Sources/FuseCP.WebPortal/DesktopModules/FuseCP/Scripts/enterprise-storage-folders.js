// Shared startup hook for enterprise storage folders pages.
$(document).ready(function () {
    if (typeof getFolderData === "function") {
        setTimeout(getFolderData, 3000);
    }
});