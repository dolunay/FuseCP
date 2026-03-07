// Shared client-side behavior for WebSitesEditHeliconApeUser.
function authTypeChanged(el) {
    if ("Basic" == el.value) {
        if (el.checked) {
            $(".EncType").show();
            $(".DigestRealm").hide();
        } else {
            $(".EncType").hide();
            $(".DigestRealm").show();
        }
    } else if ("Digest" == el.value) {
        if (el.checked) {
            $(".EncType").hide();
            $(".DigestRealm").show();
        } else {
            $(".EncType").show();
            $(".DigestRealm").hide();
        }
    }
}

function pageLoad() {
    $(".AuthType input").change(function () {
        authTypeChanged(this);
    });

    authTypeChanged($(".AuthType input")[0]);
}
