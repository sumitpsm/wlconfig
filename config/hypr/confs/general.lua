local palette = require("./confs/palette")

hl.config({
    general = {
        border_size = 0, -- size of the border around windows
        gaps_in = 2, -- gaps between windows (top, right, bottom, left -> 5,10,15,20)
        gaps_out = 2, -- gaps between windows and monitor edges (top, right, bottom, left -> 5,10,15,20)
        float_gaps = 0, -- gaps between windows and monitor edges for floating windows -1 means default
        ["col.active_border"]          = palette.color8,
        ["col.inactive_border"]        = palette.color0,
        ["col.nogroup_border_active"]  = palette.color8,
        ["col.nogroup_border"]         = palette.color0,
        layout = "scrolling", -- [scrolling/dwindle/master/monocle]
        no_focus_fallback = true, -- if true, will not fall back to the next available window when moving focus in a direction where no window was found
        resize_on_border = true, -- enables resizing windows by clicking and dragging on borders and gaps
        extend_border_grab_area = 4, -- extends the area around the border where you can click and drag on only used when general:resize_on_border is on.
        hover_icon_on_border = true, -- show a cursor icon when hovering over borders, only used when general:resize_on_border is on.
        allow_tearing = true, -- master switch for allowing tearing to occur.
        resize_corner = 0, -- force floating windows to use a specific corner when being resized (1-4 going clockwise from top left, 0 to disable)
        -- locale = "en_US", -- overrides the system locale
        snap = {
            enabled = true, -- enable snapping for floating windows
            window_gap = 16, -- minimum gap in pixels between windows before snapping
            monitor_gap = 16, -- minimum gap in pixels between window and monitor edges before snapping
            border_overlap = false, -- if true, windows snap such that only one border’s worth of space is between them
            respect_gaps = true, -- if true, snapping will respect gaps between windows(set in general:gaps_in)
        }
    }
})

hl.config({
    decoration = {
        rounding = 8, -- rounded corner's radius (in layout px)
        rounding_power = 2.0, -- adjusts the curve used for rounding corners, larger is smoother, 2.0 is a circle, 4.0 is a squircle. [2.0 - 10.0]
        -- screen_shader = [[Empty]] -- a path to a custom shader to be applied at the end of rendering.
        blur = {
            enabled = true, -- enable kawase window background blur
            size = 6, -- blur size (distance)
            passes = 2, -- the amount of passes to perform
            ignore_opacity = false, -- make the blur layer ignore the opacity of the window
            xray = true, -- if enabled, floating windows will ignore tiled windows in their blur. Only available if new_optimizations is true. Will reduce overhead on floating blur significantly.
            noise = 0.0117, -- how much noise to apply. [0.0 - 1.0]
            contrast = 0.8916, -- contrast modulation for blur. [0.0 - 2.0]
            brightness = 0.8172, -- brightness modulation for blur. [0.0 - 2.0]
            vibrancy = 0.1696, -- Increase saturation of blurred colors. [0.0 - 1.0]
            vibrancy_darkness = 0.0, -- How strong the effect of vibrancy is on dark areas. [0.0 - 1.0]
            special = true, -- whether to blur behind the special workspace (note: expensive)
            popups = false, -- whether to blur popups (e.g. right-click menus)
            popups_ignorealpha = 0.2, -- works like ignorealpha in layer rules. If pixel opacity is below set value, will not blur. [0.0 - 1.0]
        },
        dim_modal = false, -- enables dimming of parents of modal windows
        dim_inactive = false, -- enables dimming of inactive windows
        dim_strength = 0.5, -- how much inactive windows should be dimmed [0.0 - 1.0]
        dim_special = 0.2, -- how much to dim the rest of the screen by when a special workspace is open. [0.0 - 1.0]
        dim_around = 0.4, -- how much the dimaround window rule should dim by. [0.0 - 1.0]
        shadow = {
            enabled = false, -- enable drop shadows on windows
            range = 2, -- Shadow range (“size”) in layout px
            render_power = 1, -- in what power to render the falloff (more power, the faster the falloff) [1 - 4]
            color          = palette.color2,
            color_inactive = palette.color0,
            scale = 1.0, -- shadow’s scale. [0.0 - 1.0]
        }
    }
})

hl.config({
    cursor = {
        enable_hyprcursor = true, -- whether to enable hyprcursor support
        -- default_monitor = [[EMPTY]], -- the name of a default monitor for the cursor to be set to on startup (see hyprctl monitors for names)
        inactive_timeout = 0, -- in seconds, after how many seconds of cursor’s inactivity to hide it. Set to 0 for never.
        hide_on_key_press = false, -- Hides the cursor when you press any key until the mouse is moved.
        hide_on_touch = true, -- Hides the cursor when the last input was a touch input until a mouse input is done
        hotspot_padding = 0, -- the padding, in logical px, between screen edges and the cursor
        persistent_warps = false, -- When a window is refocused, the cursor returns to its last position relative to that window, rather than to the centre.
        warp_on_change_workspace = 0, -- Move the cursor to the last focused window after changing the workspace. Options: 0 (Disabled), 1 (Enabled), 2 (Force - ignores cursor:no_warps option)
        zoom_factor = 1.0, -- the factor to zoom by around the cursor. Like a magnifying glass. Minimum 1.0 (meaning no zoom)
        zoom_rigid = false, -- whether the zoom should follow the cursor rigidly (cursor is always centered if it can be) or loosely
        no_break_fs_vrr = 2, -- disables scheduling new frames on cursor movement for fullscreen apps with VRR enabled to avoid framerate spikes (may require no_hardware_cursors = true) 0 - off, 1 - on, 2 - auto (on with content type ‘game’)
        min_refresh_rate = 24, -- minimum refresh rate for cursor movement when no_break_fs_vrr is active. Set to minimum supported refresh rate or higher
    }
})

--#=##=##=##=##=##=##=##=##=##=##=##=##=##=##=##=##=##=##=##=##=

hl.config({
  general = {
    gaps_workspaces = 100, -- gaps between workspaces. Stacks with gaps_out.
    modal_parent_blocking = true -- whether parent windows of modals will be interactive
  }
})

hl.config({
    decoration = {
        active_opacity = 1.0, -- opacity of active windows. [0.0 - 1.0]
        inactive_opacity = 1.0, -- opacity of inactive windows. [0.0 - 1.0]
        fullscreen_opacity = 1.0, -- opacity of fullscreen windows. [0.0 - 1.0]
        border_part_of_window = false, -- whether the window border should be a part of the window
        blur = {
            new_optimizations = true, -- whether to enable further optimizations to the blur. Recommended to leave on, as it will massively improve performance.
            input_methods = false, -- whether to blur input methods (e.g. fcitx5)
            input_methods_ignorealpha = 0.2, -- works like ignorealpha in layer rules. If pixel opacity is below set value, will not blur. [0.0 - 1.0]
        },
        shadow = {
          sharp = false, -- if enabled, will make the shadows sharp, akin to an infinite render power
          offset = {0, 0}, -- shadow’s rendering offset
        },
        glow = {
            enabled = false, -- enable inner glow on windows
            range = 10, -- Glow range (“size”) in layout px
            render_power = 3, -- in what power to render the falloff (more power, the faster the falloff) [1 - 4]
            color = 0xee1a1a1a, -- glow’s color. Alpha dictates glow’s opacity.
            color_inactive = unset, -- inactive glow color. (if not set, will fall back to color)
        }
    }
})

hl.config({
    cursor = {
        sync_gsettings_theme = true, -- sync xcursor theme with gsettings, it applies cursor-theme and cursor-size on theme load to gsettings making most CSD gtk based clients use same xcursor theme and size.
        no_hardware_cursors = 2, -- disables hardware cursors. 0 - use hw cursors if possible, 1 - don’t use hw cursors, 2 - auto (disable when tearing)
        use_cpu_buffer = 2, -- Makes HW cursors use a CPU buffer. Required on Nvidia to have HW cursors. 0 - off, 1 - on, 2 - auto (nvidia only)
        -- warp_on_toggle_special = 0, -- Move the cursor to the last focused window when toggling a special workspace. Options: 0 (Disabled), 1 (Enabled), 2 (Force - ignores cursor:no_warps option)	
        no_warps = false, -- if true, will not warp the cursor in many cases (focusing, keybinds, etc)
        warp_back_after_non_mouse_input = false, -- Warp the cursor back to where it was after using a non-mouse input to move it, and then returning back to mouse
    }
})
