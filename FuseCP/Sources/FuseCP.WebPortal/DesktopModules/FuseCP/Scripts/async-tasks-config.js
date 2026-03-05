// Shared async-task bootstrap config consumed by Ajax utils scripts.
(function (global) {
    "use strict";

    var taskInput = document.querySelector("input[id$='taskID']");
    if (!taskInput) {
        return;
    }

    global._ctrlTaskID = taskInput.id;
    global._completeMessage = taskInput.getAttribute("data-complete-message") || "";
}(window));