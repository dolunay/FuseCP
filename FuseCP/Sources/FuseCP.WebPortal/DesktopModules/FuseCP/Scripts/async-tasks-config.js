// Shared async-task bootstrap config consumed by Ajax utils scripts.
(function (global) {
    "use strict";

    var taskInput = document.querySelector("input[id$='taskID']");
    if (!taskInput) {
        return;
    }

    var taskConfig = document.querySelector("input[id$='taskConfig']");

    global._ctrlTaskID = taskInput.id;
    global._completeMessage = taskConfig ? (taskConfig.getAttribute("data-complete-message") || "") : "";
}(window));