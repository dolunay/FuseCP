// Shared behavior for WebSitesEditHeliconApeFolder editor page.
(function () {
    "use strict";

    function onReady(handler) {
        if (window.jQuery) {
            window.jQuery(document).ready(handler);
            return;
        }

        if (document.readyState === "loading") {
            document.addEventListener("DOMContentLoaded", handler);
            return;
        }

        handler();
    }

    function initDebuggerLink() {
        if (!window.jQuery) {
            return;
        }

        window.jQuery(".LinkDebuggingPage").click(function () {
            return true;
        });
    }

    function initCodeMirrorEditor() {
        if (!window.jQuery || typeof window.CodeMirror === "undefined") {
            return;
        }

        var editors = window.jQuery(".CodeEditor");
        if (!editors.length) {
            return;
        }

        window.CodeMirror.fromTextArea(editors[0], {
            lineNumbers: true,
            autofocus: true
        });
    }

    onReady(function () {
        initDebuggerLink();
        initCodeMirrorEditor();
    });
}());
