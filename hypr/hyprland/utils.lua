local utils = {}

---Checks if any window has `win_title`.
---If any are found it gets foucused, otherwise `cmd` is executed
---@param win_title string
---@param cmd string
function utils.exec_unique_by_title(win_title, cmd)
    local win_exists = hl.get_window(win_title)
    if not win_exists then
        hl.dispatch(hl.dsp.exec_cmd(cmd))
        return
    end
    hl.dispatch(hl.dsp.focus({ window = win_title }))
end

---Checks if any window has `win_class`.
---If any are found it gets foucused, otherwise `cmd` is executed
---@param win_class string
---@param cmd string
function utils.exec_unique_by_class(win_class, cmd)
    local win_exists = hl.get_window(win_class)
    if not win_exists then
        hl.dispatch(hl.dsp.exec_cmd(cmd))
        return
    end
    hl.dispatch(hl.dsp.focus({ window = win_class }))
end

---Tries to focus the next available non-empty workspace base on the given direction.
---direction = 1 => Forward
---direction = -1 => Backward
---@param direction integer
function utils.focus_nonempty_ws(direction)
    local active = hl.get_active_workspace()
    if not active then return end

    local workspaces = hl.get_workspaces()
    table.sort(workspaces, function (ws1, ws2)
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

return utils
