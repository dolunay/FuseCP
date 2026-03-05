// SearchUsers page autocomplete initialization.
(function (global) {
    "use strict";

    if (!global.jQuery) {
        return;
    }

    global.jQuery(function ($) {
        $("#tbSearch").autocomplete({
            zIndex: 100,
            source: function (request, response) {
                $.ajax({
                    type: "post",
                    dataType: "json",
                    data: {
                        term: request.term,
                        fullType: "Users",
                        columnType: "'" + $("#ddlFilterColumn").val() + "'"
                    },
                    url: "AjaxHandler.ashx",
                    success: function (data) {
                        response($.map(data, function (item) {
                            return {
                                label: item.TextSearch,
                                code: item
                            };
                        }));
                    }
                });
            },
            select: function (event, ui) {
                var item = ui.item;
                $("#ddlFilterColumn").val(item.code.ColumnType);
                $("#tbSearchFullType").val(item.code.FullType);
                $("#tbSearchText").val(item.code.TextSearch);
            }
        });
    });
}(window));