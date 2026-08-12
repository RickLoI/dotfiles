--- Hyprland main config file

Paths = {
    shots_dir = '$HOME/Pictures/screenshots/',
    walls_dir = '$HOME/Pictures/Wallpapers/',
    todo_file = '$HOME/Documents/.ToDos.md'
}

require("hyprland.binds")
require("hyprland.configs")
require("hyprland.envs")
require("hyprland.events")
require("hyprland.gestures")
require("hyprland.monitors")
require("hyprland.rules")

-- For Noctalia Color templates
require("noctalia").apply_theme()
