local main_mod = "SUPER"

hl.bind(main_mod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(main_mod .. " + SHIFT + Return", hl.dsp.exec_cmd("alacritty --hold --command zellij options --session-serialization false --on-force-close quit"))
hl.bind(main_mod .. " + CTRL + Return", hl.dsp.exec_cmd("[float on; size monitor_w*0.7 monitor_h*0.7; center on] alacritty"))

hl.bind(main_mod .. " + SPACE", hl.dsp.exec_cmd("[workspace 3 silent] zen-beta -P default"))
hl.bind(main_mod .. " + SHIFT + SPACE", hl.dsp.exec_cmd("[workspace 4 silent] zen-beta -P alternate"))
hl.bind(main_mod .. " + CTRL + SPACE", hl.dsp.exec_cmd("[workspace 5 silent] zen-beta -P dopamine"))

hl.bind(main_mod .. " + Tab", hl.dsp.exec_cmd("pgrep wldash && pkill wldash || wldash"))
hl.bind(main_mod .. " + SHIFT + Tab", hl.dsp.exec_cmd("pidof swaylock || swaylock -f -c 3c3c3c --indicator-radius 128 --indicator-thickness 32"))
-- SUPER + CTRL + Tab
-- SUPER + CTRL + SHIFT + Tab

hl.bind(main_mod .. " + A", hl.dsp.exec_cmd("[float on; pin on; size monitor_w*1 monitor_h*1] alacritty --command nu -c \"open ~/.local/share/emojis.csv | select emoji name category | input list --fuzzy | get emoji | wl-copy\""))
hl.bind(main_mod .. " + SHIFT + A", hl.dsp.exec_cmd("hyprpicker | wl-copy"))
-- SUPER + CTRL + A
-- SUPER + CTRL + SHIFT + A

-- SUPER + R
local record_script = "$HOME/.config/hypr/scripts/record.nu"
hl.bind(main_mod .. " + SHIFT + R",        hl.dsp.exec_cmd("nu " .. record_script .. " full"))
hl.bind(main_mod .. " + CTRL + R",         hl.dsp.exec_cmd("nu " .. record_script .. " region"))
hl.bind(main_mod .. " + CTRL + SHIFT + R", hl.dsp.exec_cmd("nu " .. record_script .. " video"))

hl.bind(main_mod .. " + S", hl.dsp.exec_cmd("grim -g \"$(slurp)\" $HOME/media/.screenshots/$(date +%Y-%m-%d_%T).png"))
hl.bind(main_mod .. " + SHIFT + S", hl.dsp.exec_cmd("grim $HOME/media/.screenshots/$(date +%Y-%m-%d_%T).png"))
hl.bind(main_mod .. " + CTRL + S", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy --type image/png"))
hl.bind(main_mod .. " + CTRL + SHIFT + S", hl.dsp.exec_cmd("grim - | wl-copy --type image/png"))

-- SUPER + T
-- SUPER + SHIFT + T
-- SUPER + CTRL + T
-- SUPER + CTRL + SHIFT + T

hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 10%+"),                           { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"),                           { locked = true, repeating = true })

hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause",        hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

--#=##=##=##=##=##=##=##=##=##=##=##=##=##=##=##=##=##=##=##=##=

hl.bind(main_mod .. " + apostrophe", function()
    hl.dispatch(hl.dsp.exec_cmd("hyprctl reload"))
    hl.notification.create({ text = "Hyprland Configuration Refreshed", timeout = 2000, icon = "ok" })
end)

hl.bind(main_mod .. " + SHIFT + apostrophe", hl.dsp.exec_cmd("nu $HOME/.config/hypr/scripts/wset.nu"))
