hl.gesture({
    fingers = 3,
    direction = "right",
    action = function ()
        require("hyprland.utils").focus_nonempty_ws(1)
    end
})

hl.gesture({
    fingers = 3,
    direction = "left",
    action = function ()
        require("hyprland.utils").focus_nonempty_ws(-1)
    end
})

hl.gesture({
    fingers = 2,
    direction = "pinch",
    zoom_level = 1.5,
    mode = "live",
    action = "cursorZoom",
    mods = "SUPER"
})
