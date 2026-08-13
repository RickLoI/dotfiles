local mods = {
    plain = {
        main = "SUPER",
        sub  = "ALT",
        opt  = "CTRL"
    },

    strong = {
        main = "SUPER + SHIFT",
        sub  = "ALT + SHIFT",
        opt  = "CTRL + SHIFT"
    }
}

local ipc = "noctalia msg "
local utils = require("hyprland.utils")

--- Basic
-- Noctalia independent
hl.bind(
    mods.plain.main .. " + RETURN",
    hl.dsp.exec_cmd("kitty"),
    { description = "Open a new instance of kitty." }
)

hl.bind(
    mods.plain.main .. " + W",
    function()
        utils.exec_unique_by_class("class:zen", "zen-browser")
    end,
    { description = "Open or focus the web browser." }
)

hl.bind(
    mods.plain.main .. " + F",
    function()
        utils.exec_unique_by_class("class:thunar", "thunar")
    end,
    { description = "Open or focus the file explorer." }
)

hl.bind(
    mods.plain.main .. " + M",
    function()
        utils.exec_unique_by_title("title:Spotify", "spotify")
    end,
    { description = "Open or focus the default music player." }
)

hl.bind(
    mods.plain.main .. " + Z",
    hl.dsp.exec_cmd("zathura"),
    { description = "Open or focus the default PDF viewer." }
)

hl.bind(
    mods.plain.main .. ' + L',
    function()
        utils.exec_unique_by_title('title:LocalSend', 'localsend')
    end,
    { description = "Open or focus localsend." }
)

-- Noctalia dependent
hl.bind(
    mods.plain.main .. " + A",
    hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"),
    { description = "(Noctalia) Toggle the app launcher." }
)

hl.bind(
    'PRINT',
    hl.dsp.exec_cmd(ipc .. "screenshot-region"),
    { description = "(Noctalia) Select region to screenshot." }
)

hl.bind(
    mods.plain.main .. " + T",
    hl.dsp.exec_cmd(ipc .. "panel-toggle nightwatch75/todo:panel"),
    { description = "(Noctalia) Toggle To Do list." }
)

hl.bind(
    mods.plain.main .. " + P",
    hl.dsp.exec_cmd(ipc .. "panel-toggle thepunkoff/pomodoro:panel"),
    { description = "(Noctalia) Toggle pomodoro timer." }
)

hl.bind(
    mods.plain.sub .. " + K",
    hl.dsp.exec_cmd(ipc .. "panel-toggle blackbartblues/keymap:panel"),
    { description = "(Noctalia) Toggle this help." }
)

hl.bind(
    mods.plain.sub .. " + M",
    hl.dsp.exec_cmd(ipc .. "theme-mode-toggle"),
    { description = "(Noctalia) Toggle theme mode." }
)

--- Window control
hl.bind(
    mods.plain.main .. ' + Q',
    hl.dsp.window.close(),
    { description = "Close the active window." }
)

hl.bind(
    mods.plain.main .. ' + K',
    hl.dsp.window.kill(),
    { description = "Forcebly close the active window." }
)

hl.bind(
    mods.plain.sub .. ' + T',
    function()
        local win = hl.get_active_window()
        if not win then
            return
        end

        local monitor = hl.get_active_monitor()
        if not monitor then
            return
        end

        if win.floating then
            hl.dispatch(hl.dsp.window.float())
            return
        end

        hl.dispatch(hl.dsp.window.float())
        hl.dispatch(hl.dsp.window.resize({
            x = monitor.width * 0.75,
            y = monitor.height * 0.75
        }))
        hl.dispatch(hl.dsp.window.center())
    end,
    { description = "Toggle window floating." }
)

hl.bind(
    mods.plain.sub .. ' + F',
    function()
        local win = hl.get_active_window()
        if not win then
            return
        end

        local blacklist = {
            'LocalSend'
        }

        for _, blacklisted in ipairs(blacklist) do
            if win.title == blacklisted then
                return
            end
        end

        hl.dispatch(hl.dsp.window.fullscreen())
    end,
    { description = "Toggle fullscreen state for not black-listed windows." }
)

hl.bind(
    mods.plain.sub .. ' + L',
    function()
        local layout = hl.get_config('general.layout')
        if layout ~= 'dwindle' then
            hl.config({
                general = { layout = 'dwindle' }
            })
            return
        end

        hl.config({
            general = { layout = 'scrolling' }
        })
    end,
    { description = "Change active layout between dwindle and scrolling." }
)

hl.bind(
    mods.plain.sub .. ' + W',
    hl.dsp.exec_cmd(ipc .. 'panel-toggle wallpaper'),
    { description = "(Noctalia) Toggle wallpaper panel." }
)

hl.bind(
    mods.plain.sub .. ' + S',
    hl.dsp.exec_cmd(ipc .. 'settings-toggle'),
    { description = "(Noctalia) Toggle Noctalia settings." }
)

--- Window navigation
hl.bind(
    mods.plain.main .. ' + H',
    hl.dsp.focus({ direction = 'l' }),
    { repeating = true, description = "Focus the window on the left of the active one, if any." }
)

hl.bind(
    mods.plain.main .. ' + J',
    hl.dsp.focus({ direction = 'd' }),
    { repeating = true, description = "Focus the window below the active one, if any." }
)

hl.bind(
    mods.plain.main .. ' + K',
    hl.dsp.focus({ direction = 'u' }),
    { repeating = true, description = "Focus the window above the active one, if any." }
)

hl.bind(
    mods.plain.main .. ' + L',
    hl.dsp.focus({ direction = 'r' }),
    { repeating = true, description = "Focus the window on the right of the active one, if any." }
)

hl.bind(
    mods.plain.sub .. ' + TAB',
    hl.dsp.window.cycle_next(),
    { repeating = true, description = "Select the next available window in the workspace." }
)

hl.bind(
    mods.strong.sub .. ' + TAB',
    hl.dsp.window.cycle_next({ next = false }),
    { repeating = true, description = "Select the previous available window in the workspace." }
)

--- Move window to workspace
hl.bind(
    mods.strong.main .. ' + 1',
    hl.dsp.window.move({ workspace = 1, follow = false }),
    { description = "Move the active window to workspace 1." }
)

hl.bind(
    mods.strong.main .. ' + 2',
    hl.dsp.window.move({ workspace = 2, follow = false }),
    { description = "Move the active window to workspace 2." }
)

hl.bind(
    mods.strong.main .. ' + 3',
    hl.dsp.window.move({ workspace = 3, follow = false }),
    { description = "Move the active window to workspace 3." }
)

hl.bind(
    mods.strong.main .. ' + 4',
    hl.dsp.window.move({ workspace = 4, follow = false }),
    { description = "Move the active window to workspace 4." }
)

hl.bind(
    mods.strong.main .. ' + 5',
    hl.dsp.window.move({ workspace = 5, follow = false }),
    { description = "Move the active window to workspace 5." }
)

hl.bind(
    mods.strong.main .. ' + 6',
    hl.dsp.window.move({ workspace = 6, follow = false }),
    { description = "Move the active window to workspace 6." }
)

hl.bind(
    mods.strong.main .. ' + 7',
    hl.dsp.window.move({ workspace = 7, follow = false }),
    { description = "Move the active window to workspace 7." }
)

hl.bind(
    mods.strong.main .. ' + 8',
    hl.dsp.window.move({ workspace = 8, follow = false }),
    { description = "Move the active window to workspace 8." }
)

hl.bind(
    mods.strong.main .. ' + 9',
    hl.dsp.window.move({ workspace = 9, follow = false }),
    { description = "Move the active window to workspace 9." }
)

hl.bind(
    mods.strong.main .. ' + 0',
    hl.dsp.window.move({ workspace = 10, follow = false }),
    { description = "Move the active window to workspace 10." }
)

--- Focus workspace
hl.bind(
    mods.plain.main .. ' + 1',
    hl.dsp.focus({ workspace = 1 }),
    { description = "Switch focus to workspace 1." }
)

hl.bind(
    mods.plain.main .. ' + 2',
    hl.dsp.focus({ workspace = 2 }),
    { description = "Switch focus to workspace 2." }
)

hl.bind(
    mods.plain.main .. ' + 3',
    hl.dsp.focus({ workspace = 3 }),
    { description = "Switch focus to workspace 3." }
)

hl.bind(
    mods.plain.main .. ' + 4',
    hl.dsp.focus({ workspace = 4 }),
    { description = "Switch focus to workspace 4." }
)

hl.bind(
    mods.plain.main .. ' + 5',
    hl.dsp.focus({ workspace = 5 }),
    { description = "Switch focus to workspace 5." }
)

hl.bind(
    mods.plain.main .. ' + 6',
    hl.dsp.focus({ workspace = 6 }),
    { description = "Switch focus to workspace 6." }
)

hl.bind(
    mods.plain.main .. ' + 7',
    hl.dsp.focus({ workspace = 7 }),
    { description = "Switch focus to workspace 7." }
)

hl.bind(
    mods.plain.main .. ' + 8',
    hl.dsp.focus({ workspace = 8 }),
    { description = "Switch focus to workspace 8." }
)

hl.bind(
    mods.plain.main .. ' + 9',
    hl.dsp.focus({ workspace = 9 }),
    { description = "Switch focus to workspace 9." }
)

hl.bind(
    mods.plain.main .. ' + 0',
    hl.dsp.focus({ workspace = 10 }),
    { description = "Switch focus to workspace 10." }

)

hl.bind(
    mods.plain.main .. ' + TAB',
    hl.dsp.focus({ workspace = 'e+1' }),
    { repeating = true, description = "Switch focus to the next workspace." }
)

hl.bind(
    mods.strong.main .. ' + TAB',
    hl.dsp.focus({ workspace = 'e-1' }),
    { repeating = true, description = "Switch focus to the previous workspace." }
)

--- Submaps
hl.bind(
    mods.plain.opt .. ' + R',
    hl.dsp.submap('resize'),
    { description = "Enter the resize submap." }
)

hl.define_submap(
    'resize',
    function()
        local resize = hl.dsp.window.resize
        hl.bind(
            'H',
            resize({ x = -10, y = 0, relative = true }),
            { repeating = true, description = "(Submap) Shrink the active window's width." }
        )

        hl.bind(
            'J',
            resize({ x = 0, y = -10, relative = true }),
            { repeating = true, description = "(Submap) Shrink the active window's height." }
        )

        hl.bind(
            'K',
            resize({ x = 0, y = 10, relative = true }),
            { repeating = true, description = "(Submap) Grow the active window's height." }
        )

        hl.bind(
            'L',
            resize({ x = 10, y = 0, relative = true }),
            { repeating = true, description = "(Submap) Grow the active window's width." }
        )

        hl.bind(
            'catchall',
            hl.dsp.submap('reset'),
            { description = "Exit the resize submap." }
        )
    end
)

hl.bind(
    mods.plain.opt .. ' + S',
    hl.dsp.submap('swap'),
    { description = "Enter the swap submap." }
)

hl.define_submap(
    'swap',
    function()
        local swap = hl.dsp.window.swap
        hl.bind(
            'H',
            swap({ direction = 'l' }),
            { repeating = true, description = "(Submap) Swap the active window with the one on its left." }
        )

        hl.bind(
            'J',
            swap({ direction = 'd' }),
            { repeating = true, description = "(Submap) Swap the active window with the one below it." }
        )

        hl.bind(
            'K',
            swap({ direction = 'u' }),
            { repeating = true, description = "(Submap) Swap the active window with the one above it." }
        )

        hl.bind(
            'L',
            swap({ direction = 'r' }),
            { repeating = true, description = "(Submap) Swap the active window with the one on its right." }
        )

        hl.bind(
            'catchall',
            hl.dsp.submap('reset'),
            { description = "Exit the swap submap." }
        )
    end
)

--- Noctalia dependent media, volume and brightness controls
hl.bind(
    'XF86AudioRaiseVolume',
    hl.dsp.exec_cmd(ipc .. "volume-up"),
    { description = "(Noctalia) Raise the volume." }
)

hl.bind(
    'XF86AudioLowerVolume',
    hl.dsp.exec_cmd(ipc .. "volume-down"),
    { description = "(Noctalia) Lower the volume." }
)

hl.bind(
    'XF86AudioMute',
    hl.dsp.exec_cmd(ipc .. "volume-mute"),
    { description = "(Noctalia) Toggle audio mute." }
)

hl.bind(
    'XF86AudioMicMute',
    hl.dsp.exec_cmd(ipc .. "mic-mute"),
    { description = "(Noctalia) Toggle microphone mute." }
)

hl.bind(
    'XF86AudioPlay',
    hl.dsp.exec_cmd(ipc .. "media toggle"),
    { description = "(Noctalia) Toggle media playback." }
)

hl.bind(
    'XF86AudioStop',
    hl.dsp.exec_cmd(ipc .. "media stop"),
    { description = "(Noctalia) Stop media playback." }
)

hl.bind(
    'XF86AudioNext',
    hl.dsp.exec_cmd(ipc .. "media next"),
    { description = "(Noctalia) Skip to the next track." }
)

hl.bind('XF86AudioPrev',
    hl.dsp.exec_cmd(ipc .. "media previous"),
    { description = "(Noctalia) Return to the previous track." }
)

hl.bind(
    'XF86MonBrightnessUp',
    hl.dsp.exec_cmd(ipc .. "brightness-up"),
    { description = "(Noctalia) Raise screen brightness." }
)

hl.bind(
    'XF86MonBrightnessDown',
    hl.dsp.exec_cmd(ipc .. "brightness-down"),
    { description = "(Noctalia) Lower screen brightness." }
)
