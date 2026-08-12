--- Startup commands
hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia")
    hl.exec_cmd('hypridle & hyprpaper & hyprsunset')
    hl.exec_cmd('brightnessctl -s set 25%')
    hl.exec_cmd('rfkill unblock bluetooth & bluetoothctl power off')
    hl.exec_cmd('systemctl --user start hyprpolkitagent')
    hl.exec_cmd('systemctl --user start hyprland-session.target')
end)

hl.on('hyprland.shutdown', function ()
    os.execute('systemctl --user stop hyprland-session.target && sleep 0.1')
end)

hl.on("window.fullscreen", function ()
    hl.dsp.exec_cmd("noctalia msg bar-toggle")
end)
