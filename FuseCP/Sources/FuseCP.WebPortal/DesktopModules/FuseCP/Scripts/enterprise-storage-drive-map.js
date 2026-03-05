// Enterprise storage drive-map form interactions.
(function (global) {
    "use strict";

    if (!global.jQuery) {
        return;
    }

    global.jQuery(function ($) {
        $(".LabelAs input").bind("click", function () {
            $(".LabelAs input").val("");
        });

        $(".LabelAs input").bind("focusout", function () {
            if ($(".LabelAs input").val() === "") {
                $(".LabelAs input").val($(".Folders select option:selected").text());
            }
        });

        $(".Folders select").bind("change", function () {
            $(".LabelAs input").val($(".Folders select option:selected").text());
            $(".Url").text($(".Folders select option:selected").val());
            $(".Folders input").val($(".Folders select option:selected").text());
        });
    });
}(window));