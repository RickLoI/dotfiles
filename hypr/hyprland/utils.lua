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

return utils
