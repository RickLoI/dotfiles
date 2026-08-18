--- Startup commands
hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia")
    hl.exec_cmd("noctalia msg brightness-set 25%")
    hl.exec_cmd("noctalia msg bluetooth-disable")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("systemctl --user start hyprland-session.target")
end)

hl.on("hyprland.shutdown", function()
    os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
end)

hl.on("window.fullscreen", function()
    hl.dsp.exec_cmd("noctalia msg bar-toggle")
end)

