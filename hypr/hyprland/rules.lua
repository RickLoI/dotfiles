--- Window
-- Named
hl.window_rule({
    name = "Move everything to last workspace",
    match = { class = ".*" },
    workspace = 10
})

-- Unnamed
hl.window_rule({
    match = { class = "kitty" },
    workspace = 1
})

hl.window_rule({
    match = { class = "zen" },
    workspace = 2
})

hl.window_rule({
    match = { class = "((.*)printer)|(print|thunar)" },
    workspace = 3
})

hl.window_rule({
    match = { class = "((.*)zathura)|(imv|mpv|Spotify)" },
    workspace = 4,
})

hl.window_rule({
    match = { class = "steam" },
    workspace = 5,
})

hl.window_rule({
    match = { class = 'gimp|(file-(.*))' },
    workspace = 6,
})

hl.window_rule({
    match = { float = true },
    center = true,
    size = '(monitor_w*0.75) (monitor_h*0.75)'
})

hl.window_rule({
    match  = {
        class         = 'gimp|(file-(.*))',
        initial_title = 'negative:(GIMP|GNU|Welcome)(.*)',
    },
    float  = true,
    center = true,
    size   = '(monitor_w*0.5) (monitor_h*0.5)',
})

hl.window_rule({
    match  = {
        class = 'thunar',
        title = 'negative:((.*) - Thunar)|(Thunar Preferences)',
    },
    float  = true,
    center = true,
    size   = '(monitor_w*0.5) (monitor_h*0.5)',
})

hl.window_rule({
    match = {
        class = 'thunar',
        title = 'Rename .*'
    },
    float = true,
    center = true,
    size = '(monitor_w*0.2) (monitor_h*0.1)'
})

hl.window_rule({
    match  = { class = '((.*)printer)|(print|localsend)|(blueman|qalculate)(.*)' },
    float  = true,
    center = true,
    size   = '(monitor_w*0.5) (monitor_h*0.5)',
})

hl.window_rule({
    match  = {
        class         = 'zen',
        title         = '(.*)',
        initial_title = 'negative:((.*)(— ))?(Zen Browser)',
    },
    float  = true,
    center = true,
    size   = '(monitor_w*0.5) (monitor_h*0.5)',
})

hl.window_rule({
    match  = {
        class = 'steam',
        title = '(Sign|Friends)(.*)'
    },
    float  = true,
    center = true,
    size   = 'exact (monitor_w*0.5) (monitor_h*0.5)',
})

--- Workspace
hl.workspace_rule({
    workspace = '4',
    layout = 'scrolling'
})

hl.workspace_rule({
    workspace = '10',
    layout = 'scrolling'
})

hl.workspace_rule({ workspace = "1", persistent = true, default_name = "web" })
hl.workspace_rule({ workspace = "2", persistent = true, default_name = "code" })
hl.workspace_rule({ workspace = "3", persistent = true, default_name = "chat" })
hl.workspace_rule({ workspace = "4", persistent = true, default_name = "game" })
hl.workspace_rule({ workspace = "5", persistent = true, default_name = "design" })

--- Layer
hl.layer_rule({
  name = "noctalia",
  match = {
    namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
  },
  no_anim = true,
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true,
})
