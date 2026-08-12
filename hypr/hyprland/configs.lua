--- Noctalia
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
    },

    decoration = {
        rounding = 20,
        rounding_power = 2,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "#ee1a1a1a",
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            vibrancy = 0.1696,
        },
    },

    input = {
        kb_layout          = 'it',
        numlock_by_default = true
    },

    gestures = {
        workspace_swipe_invert     = false,
        workspace_swipe_create_new = false
    },

    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        font_family              = 'Lilex Nerd Font',
        background_color         = '#181b29',
        enable_anr_dialog        = false
    },

    xwayland = {
        force_zero_scaling = true
    },

    dwindle = {
        force_split = 2
    },

    scrolling = {
        column_width = 1,
        direction    = 'left'
    },
})
