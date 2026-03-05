// Shared checkbox-list validator for VPS replication pages.
function ValidateCheckBoxList(sender, args) {
    var checkboxes = document.querySelectorAll(".vhdContainer input[type='checkbox']");
    var isValid = false;

    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            isValid = true;
            break;
        }
    }

    args.IsValid = isValid;
}
