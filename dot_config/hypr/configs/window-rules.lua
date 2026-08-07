-- Window rules
--
-- See https://wiki.hypr.land/Configuring/Window-Rules/

-- Suppress maximize events from all applications
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize"
})

-- Fix dragging issues with XWayland windows
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false
    },
    no_focus = true
})

-- Float settings applications
hl.window_rule({
    match = { class = "^(nm-applet|nm-connection-editor|bluetuith)$" },
    tag = "+settings"
})

hl.window_rule({
    match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol)$" },
    tag = "+settings"
})

hl.window_rule({
    match = { tag = "settings" },
    float = true
})
