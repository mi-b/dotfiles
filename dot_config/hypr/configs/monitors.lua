-- Monitor configuration
--
-- Auto-detect everything. No hardcoded resolution, position, or lid logic.
-- Adjust once you know your actual monitor names (use `hyprctl monitors`).
-- See https://wiki.hypr.land/Configuring/Monitors/

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})
