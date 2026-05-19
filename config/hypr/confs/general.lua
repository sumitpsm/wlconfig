hl.config({
  general = {
    border_size = 0, -- size of the border around windows
    gaps_in = 2, -- gaps between windows (top, right, bottom, left -> 5,10,15,20)
    gaps_out = 2, -- gaps between windows and monitor edges (top, right, bottom, left -> 5,10,15,20)
    layout = dwindle, -- [dwindle/master]
    no_focus_fallback = true, -- if true, will not fall back to the next available window when moving focus in a direction where no window was found
    resize_corner = 0, -- force floating windows to use a specific corner when being resized (1-4 going clockwise from top left, 0 to disable)
    hover_icon_on_border = true, -- show a cursor icon when hovering over borders, only used when general:resize_on_border is on.
    snap = {
      enabled = true, -- enable snapping for floating windows
      window_gap = 16, -- minimum gap in pixels between windows before snapping
      monitor_gap = 16, -- minimum gap in pixels between window and monitor edges before snapping
      border_overlap = false, -- if true, windows snap such that only one border’s worth of space is between them
    }
  }
})

hl.config({
  decoration = {
    rounding = 8, -- rounded corner's radius (in layout px)
    active_opacity = 1.0, -- opacity of active windows. [0.0 - 1.0]
    inactive_opacity = 1.0, -- opacity of inactive windows. [0.0 - 1.0]
    blur = {
      enabled = true, -- enable kawase window background blur
      size = 6, -- blur size (distance)
      passes = 2, -- the amount of passes to perform
      ignore_opacity = false, -- make the blur layer ignore the opacity of the window
      xray = true, -- if enabled, floating windows will ignore tiled windows in their blur. Only available if new_optimizations is true. Will reduce overhead on floating blur significantly.
      special = true, -- whether to blur behind the special workspace (note: expensive)
      popups = false, -- whether to blur popups (e.g. right-click menus)
      popups_ignorealpha = 0.2, -- works like ignorealpha in layer rules. If pixel opacity is below set value, will not blur. [0.0 - 1.0]
      noise = 0.0117, -- how much noise to apply. [0.0 - 1.0]
      contrast = 0.8916, -- contrast modulation for blur. [0.0 - 2.0]
      brightness = 0.8172, -- brightness modulation for blur. [0.0 - 2.0]
      vibrancy = 0.1696, -- Increase saturation of blurred colors. [0.0 - 1.0]
      vibrancy_darkness = 0.0, -- How strong the effect of vibrancy is on dark areas. [0.0 - 1.0]
    },
    dim_inactive = false, -- enables dimming of inactive windows
    dim_strength = 0.5, -- how much inactive windows should be dimmed [0.0 - 1.0]
    dim_special = 0.2, -- how much to dim the rest of the screen by when a special workspace is open. [0.0 - 1.0]
    dim_around = 0.4, -- how much the dimaround window rule should dim by. [0.0 - 1.0]
    shadow = {
      enabled = false, -- enable drop shadows on windows
      range = 2, -- Shadow range (“size”) in layout px
      render_power = 1, -- in what power to render the falloff (more power, the faster the falloff) [1 - 4]
      scale = 1.0, -- shadow’s scale. [0.0 - 1.0]
    }
  }
})

hl.config({
  group = {
    auto_group = true, -- whether new windows will be automatically grouped into the focused unlocked group. Note: if you want to disable auto_group only for specific windows, use the “group barred” window rule instead
    insert_after_current = false, -- whether new windows in a group spawn after current or at group tail
    focus_removed_window = true, -- whether Hyprland should focus on the window that has just been moved out of the group
    drag_into_group = 1, -- whether dragging a window into a unlocked group will merge them. Options: 0 (disabled), 1 (enabled), 2 (only when dragging into the groupbar)
    merge_groups_on_drag = true, -- whether window groups can be dragged into other groups
    merge_floated_into_tiled_on_groupbar = false, -- whether dragging a floating window into a tiled window groupbar will merge them
    groupbar = {
      enabled = true, -- enables groupbars
      scrolling = false, -- whether scrolling in the groupbar changes group active window
      -- font_family = [[Empty]], -- font used to display groupbar titles, use misc:font_family if not specified
      font_size = 8, -- font size of groupbar title
      height = 14, -- height of the groupbar
      gaps_in = 2, -- gap size between gradients
      gaps_out = 2, -- gap size between gradients and window
      gradients = true, -- enables gradients
      gradient_rounding = 4, -- how much to round the gradients
      gradient_round_only_edges = false, -- round only the gradient edges of the entire groupbar
    }
  }
})

----------------------------------------------------------------------------------

hl.config({
  decoration = {
    rounding_power = 2.0, -- adjusts the curve used for rounding corners, larger is smoother, 2.0 is a circle, 4.0 is a squircle. [2.0 - 10.0]
    fullscreen_opacity = 1.0, -- opacity of fullscreen windows. [0.0 - 1.0]
    blur = {
      new_optimizations = true, -- whether to enable further optimizations to the blur. Recommended to leave on, as it will massively improve performance.
      input_methods = false, -- whether to blur input methods (e.g. fcitx5)
      input_methods_ignorealpha = 0.2, -- works like ignorealpha in layer rules. If pixel opacity is below set value, will not blur. [0.0 - 1.0]
    }
  }
})

hl.config({
  group = {
    merge_groups_on_groupbar = false, -- whether one group will be merged with another when dragged into its groupbar
    group_on_movetoworkspace = false, -- whether using movetoworkspace[silent] will merge the window into the workspace’s solitary unlocked group
    groupbar = {
      indicator_height = 0, -- height of the groupbar indicator
      rounding = 1, -- how much to round the indicator
      round_only_edges = true, -- round only the indicator edges of the entire groupbar
      priority = 3, -- sets the decoration priority for groupbars
    }
  }
})
