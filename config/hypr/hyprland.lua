hypr_dir = os.getenv("HOME") .. "/.config/hypr"

--! ENVIRONMENT VARIABLES
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("HYPRCURSOR_THEME", "Notwaita-Black")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("TERMINAL", "kitty")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

--! MONITORS
hl.monitor({ output = "eDP-1",     mode = "1920x1080", position = "auto", scale = "auto" })
hl.monitor({ output = "HDMI-A-1",  mode = "1920x1080", position = "auto", scale = "auto" })
hl.monitor({ output = "Virtual-1", mode = "1920x1000", position = "auto", scale = "auto" })

--! AUTOSTART
hl.on("hyprland.start", function()
    hl.dispatch(hl.dsp.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"))
    hl.dispatch(hl.dsp.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"))
    hl.dispatch(hl.dsp.exec_cmd("hyprctl setcursor Notwaita-Black 24"))
    --
    hl.dispatch(hl.dsp.exec_cmd("awww-daemon"))
    hl.dispatch(hl.dsp.exec_cmd("hypridle"))
    hl.dispatch(hl.dsp.exec_cmd("qs -c noctalia-shell"))
    hl.dispatch(hl.dsp.exec_cmd("systemctl start --user polkit-gnome-authentication-agent-1"))
    hl.dispatch(hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/nushell/scripts/wset"))
end)

--! ANIMATIONS
dofile(hypr_dir .. "/animations/default.lua")

--! CONFIGURATION
dofile(hypr_dir .. "/confs/general.lua")
dofile(hypr_dir .. "/confs/layout.lua")
dofile(hypr_dir .. "/confs/colors.lua")
dofile(hypr_dir .. "/confs/misc.lua")
dofile(hypr_dir .. "/confs/input.lua")
dofile(hypr_dir .. "/confs/cursor.lua")

--! KEYBINDINGS
dofile(hypr_dir .. "/keybinds/windows.lua")
dofile(hypr_dir .. "/keybinds/layouts.lua")
dofile(hypr_dir .. "/keybinds/external.lua")

--! RULES
dofile(hypr_dir .. "/rules/window.lua")

--#=##=##=##=##=##=##=##=##=##=##=##=##=##=##=##=##=##=##=##=##=

-- hl.on("hyprland.start", function()
--     -- hl.dsp.exec_cmd("ashell --config-path " .. os.getenv("HOME") .. "/.config/ashell/config.toml")
--     -- hl.dsp.exec_cmd("qs -c dms")
--     -- hl.dsp.exec_cmd("qs -c caelestia")
-- end)
