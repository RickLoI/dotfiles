local utils = {}

---@param direction integer
function utils.focus_nonempty_ws(direction)
    local active = hl.get_active_workspace()
    if not active then return end

    local workspaces = hl.get_workspaces()
    table.sort(workspaces, function(ws1, ws2)
        return ws1.id < ws2.id
    end)

    local n = #workspaces
    local idx
    for i, ws in ipairs(workspaces) do
        if ws.id == active.id then
            idx = i
            break
        end
    end
    if not idx then return end

    for step = 1, n - 1 do
        local i = ((idx - 1 + direction * step) % n) + 1
        local ws = workspaces[i]
        if ws.windows >= 1 then
            hl.dispatch(hl.dsp.focus({ workspace = ws }))
            return
        end
    end
end

---@param class_or_title string -- The class or (exclusive) the title of a window.
---@param cmd string -- Which command to excute if no window has `class_or_title.
function utils.exec_unique(class_or_title, cmd)
    local win = hl.get_window(class_or_title)
    if not win then
        hl.dispatch(hl.dsp.exec_cmd(cmd))
        return
    end

    hl.dispatch(hl.dsp.focus({ window = win }))
end

function utils.handle_kitty()
    local win = hl.get_active_window()
    if not win or win.class ~= "kitty" then
        return
    end

    local handler = io.popen("noctalia msg wallpaper-get")
    if not handler then
        return
    end

    local wallpaper = handler:read("*l")
    handler:close()

    local kitten = string.format(
        "kitten @ --to unix:/tmp/kitty-%d set-background-image \'%s\'",
        win.pid,
        win.fullscreen == 2 and wallpaper or "none"
    )

    hl.dispatch(hl.dsp.exec_cmd(kitten))
end

return utils
