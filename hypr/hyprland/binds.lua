local mods = {
    main = { plain = 'SUPER', shift = 'SUPER + SHIFT' },
    sub = { plain = 'ALT', shift = 'ALT + SHIFT' },
    opt = { plain = 'CTRL', shift = 'CTRL + SHIFT' }
}

--- Support variables
-- local utils = require('hyprland.utils')

--- Essentials
hl.bind(mods.main.plain .. ' + RETURN', hl.dsp.exec_cmd('kitty'))
hl.bind(mods.main.plain .. ' + W', hl.dsp.exec_cmd('zen-browser'))

hl.bind(mods.main.plain .. ' + F', hl.dsp.exec_cmd('thunar'))
hl.bind(mods.main.plain .. ' + A', hl.dsp.exec_cmd('hyprlauncher'))

--- Apps
hl.bind(mods.main.plain .. ' + S', function()
    utils.focus_window_or_execute('title:Spotify .*', 'spotify')
end)

hl.bind(mods.main.plain .. ' + P', hl.dsp.exec_cmd('zathura'))
hl.bind(mods.main.plain .. ' + I', function()
    utils.focus_window_or_execute('title:btop', 'kitty -T btop -e btop')
end)

hl.bind(mods.main.plain .. ' + T', function()
    local cmd = string.format('kitty -T todos -e "nvim" %s', Paths.todo_file)
    utils.focus_window_or_execute('title:todos', cmd)
end)

hl.bind(mods.main.plain .. ' + L', function()
    utils.focus_window_or_execute('title:LocalSend', 'localsend')
end)

hl.bind('PRINT', hl.dsp.exec_cmd('hyprshot -m region -o ' .. Paths.shots_dir))

--- Window control
hl.bind(mods.main.plain .. ' + Q', hl.dsp.window.close())
hl.bind(mods.main.plain .. ' + K', hl.dsp.window.kill())
hl.bind(mods.sub.plain .. ' + T', function()
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

hl.bind(mods.sub.plain .. ' + F', function()
    local win = hl.get_active_window()
    if not win then
        return
    end

    local blacklist = {
        'todos',
        'btop',
        'LocalSend'
    }

    for _, blacklisted in ipairs(blacklist) do
        if win.title == blacklisted then
            return
        end
    end

    hl.dispatch(hl.dsp.window.fullscreen())
end)

hl.bind(mods.sub.plain .. ' + L', function()
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
hl.bind(mods.main.plain .. ' + H', hl.dsp.focus({ direction = 'l' }), { repeating = true })
hl.bind(mods.main.plain .. ' + J', hl.dsp.focus({ direction = 'd' }), { repeating = true })
hl.bind(mods.main.plain .. ' + K', hl.dsp.focus({ direction = 'u' }), { repeating = true })
hl.bind(mods.main.plain .. ' + L', hl.dsp.focus({ direction = 'r' }), { repeating = true })
hl.bind(mods.sub.plain .. ' + TAB', hl.dsp.window.cycle_next(), { repeating = true })
hl.bind(mods.sub.shift .. ' + TAB', hl.dsp.window.cycle_next({ next = false }), { repeating = true })


--- Move window to workspace
hl.bind(mods.main.shift .. ' + 1', hl.dsp.window.move({ workspace = 1, follow = false }))
hl.bind(mods.main.shift .. ' + 2', hl.dsp.window.move({ workspace = 2, follow = false }))
hl.bind(mods.main.shift .. ' + 3', hl.dsp.window.move({ workspace = 3, follow = false }))
hl.bind(mods.main.shift .. ' + 4', hl.dsp.window.move({ workspace = 4, follow = false }))
hl.bind(mods.main.shift .. ' + 5', hl.dsp.window.move({ workspace = 5, follow = false }))
hl.bind(mods.main.shift .. ' + 6', hl.dsp.window.move({ workspace = 6, follow = false }))
hl.bind(mods.main.shift .. ' + 7', hl.dsp.window.move({ workspace = 7, follow = false }))
hl.bind(mods.main.shift .. ' + 8', hl.dsp.window.move({ workspace = 8, follow = false }))
hl.bind(mods.main.shift .. ' + 9', hl.dsp.window.move({ workspace = 9, follow = false }))
hl.bind(mods.main.shift .. ' + 0', hl.dsp.window.move({ workspace = 10, follow = false }))

--- Focus workspace
hl.bind(mods.main.plain .. ' + 1', hl.dsp.focus({ workspace = 1 }))
hl.bind(mods.main.plain .. ' + 2', hl.dsp.focus({ workspace = 2 }))
hl.bind(mods.main.plain .. ' + 3', hl.dsp.focus({ workspace = 3 }))
hl.bind(mods.main.plain .. ' + 4', hl.dsp.focus({ workspace = 4 }))
hl.bind(mods.main.plain .. ' + 5', hl.dsp.focus({ workspace = 5 }))
hl.bind(mods.main.plain .. ' + 6', hl.dsp.focus({ workspace = 6 }))
hl.bind(mods.main.plain .. ' + 7', hl.dsp.focus({ workspace = 7 }))
hl.bind(mods.main.plain .. ' + 8', hl.dsp.focus({ workspace = 8 }))
hl.bind(mods.main.plain .. ' + 9', hl.dsp.focus({ workspace = 9 }))
hl.bind(mods.main.plain .. ' + 0', hl.dsp.focus({ workspace = 10 }))

hl.bind(
    mods.main.plain .. ' + TAB',
    hl.dsp.focus({ workspace = 'e+1' }),
    { repeating = true }
)

hl.bind(
    mods.main.shift .. ' + TAB',
    hl.dsp.focus({ workspace = 'e-1' }),
    { repeating = true }
)

--- Submaps
hl.bind(
    mods.opt.plain .. ' + R',
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
    mods.opt.plain .. ' + S',
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
-- hl.bind(
--     'XF86AudioRaiseVolume',
--     function()
--         local handle = io.popen('wpctl get-volume @DEFAULT_AUDIO_SINK@')
--         if not handle then
--             return
--         end
--
--         local output = handle:read('*l')
--         local volume = tonumber(output:match('Volume:%s*([%d.]+)'))
--         if volume and volume < 1.0 then
--             hl.dispatch(hl.dsp.exec_cmd(('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+')))
--         end
--     end,
--     { locked = true, repeating = true }
-- )
--
-- hl.bind(
--     'XF86AudioLowerVolume',
--     hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'),
--     { locked = true, repeating = true }
-- )
--
-- hl.bind(
--     'XF86AudioMute',
--     hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'),
--     { locked = true }
-- )
--
-- hl.bind(
--     'XF86AudioMicMute',
--     hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle'),
--     { locked = true }
-- )
--
-- hl.bind(
--     'XF86AudioPlay',
--     hl.dsp.exec_cmd('playerctl play-pause'),
--     { locked = true }
-- )
--
-- hl.bind(
--     'XF86AudioStop',
--     hl.dsp.exec_cmd('playerctl play-pause'),
--     { locked = true }
-- )
-- hl.bind(
--     'XF86AudioNext',
--     hl.dsp.exec_cmd('playerctl next'),
--     { locked = true }
-- )
--
-- hl.bind(
--     'XF86AudioPrev',
--     hl.dsp.exec_cmd('playerctl previous'),
--     { locked = true }
-- )
--
-- hl.bind(
--     'XF86MonBrightnessUp',
--     hl.dsp.exec_cmd('brightnessctl set 10%+'),
--     { locked = true, repeating = true }
-- )
--
-- hl.bind(
--     'XF86MonBrightnessDown',
--     hl.dsp.exec_cmd('brightnessctl set 10%-'),
--     { locked = true, repeating = true }
-- )
--
local ipc = "noctalia msg "

hl.bind(mods.main.plain .. "+ Space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mods.main.plain .. "+ C", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
hl.bind(mods.main.plain .. "+ Comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher"))

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"))

-- Noctalia Settings
hl.window_rule({
    match = { class = "dev.noctalia.Noctalia" },
    float = true,
    size = { 1080, 920 },
})
