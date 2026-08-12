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
hl.bind(mods.plain.main .. " + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind(mods.plain.main .. " + W", function()
    utils.exec_unique_by_class("class:zen", "zen-browser")
end)

hl.bind(mods.plain.main .. " + F", function()
    utils.exec_unique_by_class("class:thunar", "thunar")
end)

hl.bind(mods.plain.main .. " + M", function()
    utils.exec_unique_by_title("title:Spotify", "spotify")
end)

hl.bind(mods.plain.main .. " + P", hl.dsp.exec_cmd("zathura"))

hl.bind(mods.plain.main .. ' + L', function()
    utils.exec_unique_by_title('title:LocalSend', 'localsend')
end)

-- Noctalia dependent
hl.bind(mods.plain.main .. " + A", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind('PRINT', hl.dsp.exec_cmd(ipc .. "screenshot-region"))

--- Window control
hl.bind(mods.plain.main .. ' + Q', hl.dsp.window.close())
hl.bind(mods.plain.main .. ' + K', hl.dsp.window.kill())
hl.bind(mods.plain.sub .. ' + T', function()
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
end)

hl.bind(mods.plain.sub .. ' + F', function()
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
end)

hl.bind(mods.plain.sub .. ' + L', function()
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
end)

--- Window navigation
hl.bind(mods.plain.main .. ' + H', hl.dsp.focus({ direction = 'l' }), { repeating = true })
hl.bind(mods.plain.main .. ' + J', hl.dsp.focus({ direction = 'd' }), { repeating = true })
hl.bind(mods.plain.main .. ' + K', hl.dsp.focus({ direction = 'u' }), { repeating = true })
hl.bind(mods.plain.main .. ' + L', hl.dsp.focus({ direction = 'r' }), { repeating = true })
hl.bind(mods.plain.sub .. ' + TAB', hl.dsp.window.cycle_next(), { repeating = true })
hl.bind(mods.strong.sub .. ' + TAB', hl.dsp.window.cycle_next({ next = false }), { repeating = true })

--- Move window to workspace
hl.bind(mods.strong.main .. ' + 1', hl.dsp.window.move({ workspace = 1, follow = false }))
hl.bind(mods.strong.main .. ' + 2', hl.dsp.window.move({ workspace = 2, follow = false }))
hl.bind(mods.strong.main .. ' + 3', hl.dsp.window.move({ workspace = 3, follow = false }))
hl.bind(mods.strong.main .. ' + 4', hl.dsp.window.move({ workspace = 4, follow = false }))
hl.bind(mods.strong.main .. ' + 5', hl.dsp.window.move({ workspace = 5, follow = false }))
hl.bind(mods.strong.main .. ' + 6', hl.dsp.window.move({ workspace = 6, follow = false }))
hl.bind(mods.strong.main .. ' + 7', hl.dsp.window.move({ workspace = 7, follow = false }))
hl.bind(mods.strong.main .. ' + 8', hl.dsp.window.move({ workspace = 8, follow = false }))
hl.bind(mods.strong.main .. ' + 9', hl.dsp.window.move({ workspace = 9, follow = false }))
hl.bind(mods.strong.main .. ' + 0', hl.dsp.window.move({ workspace = 10, follow = false }))

--- Focus workspace
hl.bind(mods.plain.main .. ' + 1', hl.dsp.focus({ workspace = 1 }))
hl.bind(mods.plain.main .. ' + 2', hl.dsp.focus({ workspace = 2 }))
hl.bind(mods.plain.main .. ' + 3', hl.dsp.focus({ workspace = 3 }))
hl.bind(mods.plain.main .. ' + 4', hl.dsp.focus({ workspace = 4 }))
hl.bind(mods.plain.main .. ' + 5', hl.dsp.focus({ workspace = 5 }))
hl.bind(mods.plain.main .. ' + 6', hl.dsp.focus({ workspace = 6 }))
hl.bind(mods.plain.main .. ' + 7', hl.dsp.focus({ workspace = 7 }))
hl.bind(mods.plain.main .. ' + 8', hl.dsp.focus({ workspace = 8 }))
hl.bind(mods.plain.main .. ' + 9', hl.dsp.focus({ workspace = 9 }))
hl.bind(mods.plain.main .. ' + 0', hl.dsp.focus({ workspace = 10 }))

hl.bind(
    mods.plain.main .. ' + TAB',
    hl.dsp.focus({ workspace = 'e+1' }),
    { repeating = true }
)

hl.bind(
    mods.strong.main .. ' + TAB',
    hl.dsp.focus({ workspace = 'e-1' }),
    { repeating = true }
)

--- Submaps
hl.bind(
    mods.plain.opt .. ' + R',
    hl.dsp.submap('resize')
)

hl.define_submap(
    'resize',
    function()
        local resize = hl.dsp.window.resize
        hl.bind('H', resize({ x = -10, y = 0, relative = true }), { repeating = true })
        hl.bind('J', resize({ x = 0, y = -10, relative = true }), { repeating = true })
        hl.bind('K', resize({ x = 0, y = 10, relative = true }), { repeating = true })
        hl.bind('L', resize({ x = 10, y = 0, relative = true }), { repeating = true })

        hl.bind('catchall', hl.dsp.submap('reset'))
    end
)

hl.bind(
    mods.plain.opt .. ' + S',
    hl.dsp.submap('swap')
)

hl.define_submap(
    'swap',
    function()
        local swap = hl.dsp.window.swap
        hl.bind('H', swap({ direction = 'l' }), { repeating = true })
        hl.bind('J', swap({ direction = 'd' }), { repeating = true })
        hl.bind('K', swap({ direction = 'u' }), { repeating = true })
        hl.bind('L', swap({ direction = 'r' }), { repeating = true })

        hl.bind('catchall', hl.dsp.submap('reset'))
    end
)

--- Volume, player and backlight
hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_cmd(ipc .. "volume-up"))
hl.bind('XF86AudioLowerVolume', hl.dsp.exec_cmd(ipc .. "volume-down"))
hl.bind('XF86AudioMute', hl.dsp.exec_cmd(ipc .. "volume-mute"))
hl.bind('XF86AudioMicMute', hl.dsp.exec_cmd(ipc .. "mic-mute"))
hl.bind('XF86AudioPlay', hl.dsp.exec_cmd(ipc .. "media toggle"))
hl.bind('XF86AudioStop', hl.dsp.exec_cmd(ipc .. "media stop"))
hl.bind('XF86AudioNext', hl.dsp.exec_cmd(ipc .. "media next"))
hl.bind('XF86AudioPrev', hl.dsp.exec_cmd(ipc .. "media previous"))

hl.bind('XF86MonBrightnessUp', hl.dsp.exec_cmd(ipc .. "brightness-up"))
hl.bind('XF86MonBrightnessDown', hl.dsp.exec_cmd(ipc .. "brightness-down"))
