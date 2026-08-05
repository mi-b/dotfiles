-- Input configuration
--
-- Keyboard, mouse, touchpad, and gestures.
-- See https://wiki.hypr.land/Configuring/Variables/#input

hl.config({
    input = {
        kb_layout = "ch",
        kb_variant = "de",
        kb_model = "",
        kb_options = "ctrl:nocaps",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = true
        }
    }
})

-- Three-finger horizontal swipe to switch workspaces
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})
