---- Windows
--- Named
hl.window_rule({
    name = "Move everything to last workspace",
    match = { class = ".*" },
    workspace = 10
})

--- Unnamed
-- Kitty related
hl.window_rule({
    match = { class = "kitty" },
    workspace = 1
})

-- Zen Browser related
hl.window_rule({
    match = { class = "zen" },
    workspace = 2
})

-- Printer, LocalSend and Thunar related
hl.window_rule({
    match = { class = "((.*)printer)|(print|thunar)" },
    workspace = 3
})

hl.window_rule({
    match = {
        class = "thunar",
        title = "((Rename|Create)(.*))"
    },
    float = true,
    center = true,
    size = "(monitor_w*0.2) (monitor_h*0.1)"
})

-- Zathura, IMV, MPV and Spotify related
hl.window_rule({
    match = { class = "((.*)zathura)|(imv|mpv|Spotify)" },
    workspace = 4,
})

-- Steam related
hl.window_rule({
    match = { class = "steam" },
    workspace = 5,
})

-- Gimp related
hl.window_rule({
    match = { class = "gimp|(file(.*))" },
    workspace = 6,
})

hl.window_rule({
    match = {
        class = "gimp|(file(.*))",
        title = "negative:(GIMP Startup|Welcome(.*))",
        float = true
    },
    center = true,
    size = "(monitor_w*0.5) (monitor_h*0.5)"
})

-- Others
hl.window_rule({
    match = {
        class = "((.*)localsend_app)|(xdg-desktop-portal-gtk)|(qalculate(.*))",
    },
    workspace = "unset",
    float = true,
    center = true,
    size = "(monitor_w*0.5) (monitor_h*0.5)"
})

hl.window_rule({
    match = { 
        float = true,
        class = "negative:(((.*)localsend_app)|(gimp|xdg-desktop-portal-gtk)|(qalculate(.*)))"
    },
    center = true,
    size = "(monitor_w*0.75) (monitor_h*0.75)"
})

--- Workspace
hl.workspace_rule({
    workspace = "1",
    persistent = true,
    default_name = "一"
})

hl.workspace_rule({
    workspace = "2",
    persistent = true,
    default_name = "二"
})

hl.workspace_rule({
    workspace = "3",
    persistent = true,
    default_name = "三"
})

hl.workspace_rule({
    workspace = "4",
    persistent = true,
    default_name = "四",
    layout = "scrolling"
})

hl.workspace_rule({
    workspace = "5",
    persistent = true,
    default_name = "五"
})

hl.workspace_rule({
    workspace = "6",
    default_name = "六"
})

hl.workspace_rule({
    workspace = "7",
    default_name = "七"
})

hl.workspace_rule({
    workspace = "8",
    default_name = "八"
})

hl.workspace_rule({
    workspace = "9",
    default_name = "九"
})

hl.workspace_rule({
    workspace = "10",
    default_name = "十",
    layout = "scrolling"
})

--- Layer
hl.layer_rule({
    name = "noctalia",
    match = {
        namespace = "^noctalia(.*)$",
    },
    no_anim = true,
    ignore_alpha = 0.5,
    blur = true,
    blur_popups = true,
})
