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
        var $noResultsText = $root.find("input[id$='hfNoResultsText']");
        var $goToSearchText = $root.find("input[id$='hfGoToSearchText']");
        var $submit = $root.find("a[id$='ImageButton1']");
        var $mobileShell = $root.closest(".search-top");
        var isMobileShell = $mobileShell.length > 0;
        var noResultsText = $.trim(($noResultsText.val() || ""));
        var goToSearchText = $.trim(($goToSearchText.val() || ""));

        if (!noResultsText) {
            noResultsText = "No results found";
        }

        if (!goToSearchText) {
            goToSearchText = "Go to search page";
        }

        function buildNoResultsItem() {
            return {
                label: noResultsText,
                value: "",
                noResults: true
            };
        }

        function buildGoToSearchItem(term) {
            return {
                label: goToSearchText + ': "' + term + '"',
                value: term,
                goToSearch: true
            };
        }

        function clearSelectedEntityFields() {
            $searchColumnType.val("");
            $searchFullType.val("");
            $objectId.val("");
            $packageId.val("");
            $accountId.val("");
        }

        function suppressPlainEnter(e) {
            var key = e.which || e.keyCode;
            if (key !== 13) {
                return;
            }

            // Always block Enter in textbox to prevent default SearchObject redirect.
            // Intentional navigation still works via explicit click/select actions.
            e.preventDefault();
            e.stopPropagation();
            if (e.stopImmediatePropagation) {
                e.stopImmediatePropagation();
            }
            return false;
        }

        $search.on("keydown", suppressPlainEnter);
        $search.on("keypress", suppressPlainEnter);

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
            appendTo: "body",
            position: {
                my: "left top",
                at: "left bottom+6",
                of: isMobileShell ? $mobileShell : $search,
                collision: "fit flip"
            },
            source: function (request, response) {
                $.ajax({
                    type: "post",
                    dataType: "json",
                    data: {
                        term: request.term
                    },
                    url: "AjaxHandler.ashx",
                    success: function (data) {
                        var mapped = $.map(data || [], function (item) {
                            return {
                                label: item.TextSearch + " [" + item.FullTypeLocalized + "]",
                                code: item
                            };
                        });

                        if (!mapped.length) {
                            var term = $.trim(request.term || "");
                            var noResultsItems = [buildNoResultsItem()];

                            if (term.length > 0) {
                                noResultsItems.push(buildGoToSearchItem(term));
                            }

                            response(noResultsItems);
                            return;
                        }

                        response(mapped);
                    },
                    error: function () {
                        var term = $.trim(request.term || "");
                        var errorItems = [buildNoResultsItem()];

                        if (term.length > 0) {
                            errorItems.push(buildGoToSearchItem(term));
                        }

                        response(errorItems);
                    }
                });
            },
            focus: function (event, ui) {
                if (ui.item && ui.item.noResults) {
                    event.preventDefault();
                    return false;
                }
            },
            select: function (event, ui) {
                if (ui.item && ui.item.noResults) {
                    event.preventDefault();
                    return false;
                }

                if (ui.item && ui.item.goToSearch) {
                    event.preventDefault();
                    clearSelectedEntityFields();
                    $searchText.val($.trim($search.val() || ui.item.value || ""));
                    $submit.trigger("click");
                    $submit.attr("disabled", "disabled");
                    return false;
                }

                var item = ui.item;
                $searchColumnType.val(item.code.ColumnType);
                $searchFullType.val(item.code.FullType);
                $searchText.val(item.code.TextSearch);
                $objectId.val(item.code.ItemID);
                $packageId.val(item.code.PackageID);
                $accountId.val(item.code.AccountID);
                $submit.trigger("click");
                $submit.attr("disabled", "disabled");
            },
            open: function () {
                var widget = $search.autocomplete("widget");
                var useShell = isMobileShell && $mobileShell.is(":visible");
                var width = useShell ? $mobileShell.outerWidth() : $search.outerWidth();

                widget
                    .addClass("fcp-global-search-menu")
                    .css({
                        width: width + "px",
                        zIndex: 2000
                    });

                if (useShell) {
                    widget.position({
                        my: "left top",
                        at: "left bottom+6",
                        of: $mobileShell,
                        collision: "fit flip"
                    });

                    // Reposition once after the search shell transition settles.
                    setTimeout(function () {
                        widget.css("width", $mobileShell.outerWidth() + "px");
                        widget.position({
                            my: "left top",
                            at: "left bottom+6",
                            of: $mobileShell,
                            collision: "fit flip"
                        });
                    }, 40);
                }
            }
        });

        var acInstance = $search.autocomplete("instance");
        if (acInstance) {
            acInstance._renderItem = function (ul, item) {
                var $li = $("<li>")
                    .toggleClass("fcp-no-results", !!item.noResults)
                    .toggleClass("fcp-go-to-search", !!item.goToSearch);
                return $li.append($("<a>").text(item.label || "")).appendTo(ul);
            };
        }

        if (document.referrer.search("pid=Login") > 0 || window.location.href.search("pid=SearchObject") > 0) {
            $search.focus();
        }
    });
});