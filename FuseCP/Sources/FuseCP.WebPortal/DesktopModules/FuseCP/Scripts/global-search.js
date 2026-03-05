// Shared GlobalSearch client behavior for autocomplete and quick-submit.
$(document).ready(function () {
    $(".fcp-global-search").each(function () {
        var $root = $(this);
        var $search = $root.find("input[id$='tbSearch']");
        var $searchColumnType = $root.find("input[id$='tbSearchColumnType']");
        var $searchFullType = $root.find("input[id$='tbSearchFullType']");
        var $searchText = $root.find("input[id$='tbSearchText']");
        var $objectId = $root.find("input[id$='tbObjectId']");
        var $packageId = $root.find("input[id$='tbPackageId']");
        var $accountId = $root.find("input[id$='tbAccountId']");
        var $submit = $root.find("a[id$='ImageButton1']");

        if ($search.length === 0) {
            return;
        }

        $search.keypress(function (e) {
            if (e.keyCode !== 13) {
                $searchText.val("");
                $objectId.val("");
                $packageId.val("");
                $accountId.val("");
            }
        });

        $search.autocomplete({
            zIndex: 100,
            source: function (request, response) {
                $.ajax({
                    type: "post",
                    dataType: "json",
                    data: {
                        term: request.term
                    },
                    url: "AjaxHandler.ashx",
                    success: function (data) {
                        response($.map(data, function (item) {
                            return {
                                label: item.TextSearch + " [" + item.FullTypeLocalized + "]",
                                code: item
                            };
                        }));
                    }
                });
            },
            select: function (event, ui) {
                var item = ui.item;
                $searchColumnType.val(item.code.ColumnType);
                $searchFullType.val(item.code.FullType);
                $searchText.val(item.code.TextSearch);
                $objectId.val(item.code.ItemID);
                $packageId.val(item.code.PackageID);
                $accountId.val(item.code.AccountID);
                $submit.trigger("click");
                $submit.attr("disabled", "disabled");
            }
        });

        if (document.referrer.search("pid=Login") > 0 || window.location.href.search("pid=SearchObject") > 0) {
            $search.focus();
        }
    });
});