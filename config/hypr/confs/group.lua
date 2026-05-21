local palette = require("./confs/palette")

hl.config({
    group = {
        auto_group = true, -- whether new windows will be automatically grouped into the focused unlocked group. Note: if you want to disable auto_group only for specific windows, use the “group barred” window rule instead
        insert_after_current = false, -- whether new windows in a group spawn after current or at group tail
        focus_removed_window = true, -- whether Hyprland should focus on the window that has just been moved out of the group
        drag_into_group = 1, -- whether dragging a window into a unlocked group will merge them. Options: 0 (disabled), 1 (enabled), 2 (only when dragging into the groupbar)
        merge_groups_on_drag = true, -- whether window groups can be dragged into other groups
        merge_groups_on_groupbar = false, -- whether one group will be merged with another when dragged into its groupbar
        merge_floated_into_tiled_on_groupbar = false, -- whether dragging a floating window into a tiled window groupbar will merge them
        group_on_movetoworkspace = false, -- whether using movetoworkspace[silent] will merge the window into the workspace’s solitary unlocked group
        ["col.border_active"]          = palette.color5,
        ["col.border_inactive"]        = palette.background,
        ["col.border_locked_active"]   = palette.color11,
        ["col.border_locked_inactive"] = palette.color11,
        groupbar = {
            enabled = true, -- enables groupbars
            -- font_family = [[Empty]], -- font used to display groupbar titles, use misc:font_family if not specified
            font_size = 8, -- font size of groupbar title
            font_weight_active = "normal", -- font weight of active groupbar title
            font_weight_inactive = "normal", -- font weight of inactive groupbar title
            gradients = true, -- enables gradients
            height = 14, -- height of the groupbar
            indicator_gap = 0, -- height of gap between groupbar indicator and title	
            indicator_height = 0, -- height of the groupbar indicator
            stacked = false, -- render the groupbar as a vertical stack
            priority = 3, -- sets the decoration priority for groupbars
            render_titles = true, -- whether to render titles in the group bar decoration
            text_offset = 0, -- adjust vertical position for titles
            text_padding = 0, -- set horizontal padding for titles
            scrolling = false, -- whether scrolling in the groupbar changes group active window
            rounding = 1, -- how much to round the indicator
            rounding_power = 2.0, -- adjusts the curve used for rounding groupbar corners, larger is smoother, 2.0 is a circle, 4.0 is a squircle, 1.0 is a triangular corner. [1.0 - 10.0]
            gradient_rounding = 4, -- how much to round the gradients
            gradient_rounding_power = 2.0, -- adjusts the curve used for rounding gradient corners, larger is smoother, 2.0 is a circle, 4.0 is a squircle, 1.0 is a triangular corner. [1.0 - 10.0]
            round_only_edges = true, -- round only the indicator edges of the entire groupbar
            gradient_round_only_edges = false, -- round only the gradient edges of the entire groupbar
            text_color                 = palette.foreground,
            text_color_inactive        = unset,
            text_color_locked_active   = unset,
            text_color_locked_inactive = unset,
            ["col.active"]             = palette.color8,
            ["col.inactive"]           = palette.color0,
            ["col.locked_active"]      = palette.color8,
            ["col.locked_inactive"]    = palette.color0,
            gaps_in = 2, -- gap size between gradients
            gaps_out = 2, -- gap size between gradients and window
            keep_upper_gap = true, -- add or remove upper gap
            middle_click_close = true, -- whether middle clicking the groupbar closes the clicked window
            blur = false, -- applies blur to the groupbar indicators and gradients
        }
    }
})
