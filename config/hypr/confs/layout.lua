hl.config({
    layout = {
        single_window_aspect_ratio = {0, 0}, -- whenever only a single window is shown on a screen, add padding so that it conforms to the specified aspect ratio. A value like 4 3 on a 16:9 screen will make it a 4:3 window in the middle with padding to the sides.
        single_window_aspect_ratio_tolerance = 0.1, -- sets a tolerance for single_window_aspect_ratio, so that if the padding that would have been added is smaller than the specified fraction of the height or width of the screen, it will not attempt to adjust the window size [0 - 1]
    }
})

hl.config({
    scrolling = {
        fullscreen_on_one_column = true, -- when enabled, a single column on a workspace will always span the entire screen.
        column_width = 0.5, -- the default width of a column, [0.1 - 1.0]
        focus_fit_method = 1, -- When a column is focused, what method should be used to bring it into view. 0 = center, 1 = fit
        follow_focus = true, -- when a window is focused, should the layout move to bring it into view automatically
        follow_min_visible = 0.2, -- when a window is focused, require that at least a given fraction of it is visible for focus to follow. Hard input (e.g. binds, clicks) will always follow. [0.0 - 1.0]
        explicit_column_widths = "0.333, 0.5, 0.667, 1.0", -- A comma-separated list of preconfigured widths for colresize +conf/-conf
        wrap_focus = true, -- When enabled, causes hl.dsp.layoutmsg("focus l/r") to wrap around at the beginning and end.
        wrap_swapcol = true, -- When enabled, causes hl.dsp.layoutmsg("swapcol l/r") to wrap around at the beginning and end.
        direction = "right", -- Direction in which new windows appear and the layout scrolls. "left"/"right"/"down"/"up"
    }
})

hl.config({
    dwindle = {
        force_split = 0, -- 0 -> split follows mouse, 1 -> always split to the left (new = left or top) 2 -> always split to the right (new = right or bottom)
        use_active_for_splits = true, -- whether to prefer the active window or the mouse position for splits
        split_width_multiplier = 1.0, -- specifies the auto-split width multiplier
        special_scale_factor = 0.9, -- specifies the scale factor of windows on the special workspace [0 - 1]
        preserve_split = true, -- if enabled, the split (side/top) will not change regardless of what happens to the container.
        smart_split = false, -- if enabled, allows a more precise control over the window split direction based on the cursor’s position. The window is conceptually divided into four triangles, and cursor’s triangle determines the split direction. This feature also turns on preserve_split
        smart_resizing = true, -- if enabled, resizing direction will be determined by the mouse’s position on the window (nearest to which corner). Else, it is based on the window’s tiling position
        default_split_ratio = 1.0, -- the default split ratio on window open. 1 means even 50/50 split. [0.1 - 1.9]
        split_bias = 0, -- specifies which window will receive the larger half of a split. positional - 0, current window - 1, opening window - 2 [0/1/2]
        permanent_direction_override = false, -- if enabled, makes the preselect direction persist until either this mode is turned off, another direction is specified, or a non-direction is specified (anything other than l,r,u/t,d/b)
    }
})

hl.config({
    master = {
        new_status = master, -- master: new window becomes master; slave: new windows are added to slave stack; inherit: inherit from focused window
        mfact = 0.55, -- the size as a percentage of the master window, for example mfact = 0.70 would mean 70% of the screen will be the master window, and 30% the slave [0.0 - 1.0]
        new_on_top = true, -- whether a newly open window should be on the top of the stack
        orientation = left, -- default placement of the master area, can be left, right, top, bottom or center
        slave_count_for_center_master = 4, -- when using orientation=center, make the master window centered only when at least this many slave windows are open. (Set 0 to always_center_master)
        center_master_fallback = left, -- Set fallback for center master when slaves are less than slave_count_for_center_master, can be left ,right ,top ,bottom
        drop_at_cursor = true, -- when enabled, dragging and dropping windows will put them at the cursor position. Otherwise, when dropped at the stack side, they will go to the top/bottom of the stack depending on new_on_top.
        always_keep_position = false, -- whether to keep the master window in its configured position when there are no slave windows
        special_scale_factor = 0.9, -- the scale of the special workspace windows. [0.0 - 1.0]
        smart_resizing = true, -- if enabled, resizing direction will be determined by the mouse’s position on the window (nearest to which corner). Else, it is based on the window’s tiling position.

        allow_small_split = false, -- enable adding additional master windows in a horizontal split style
        new_on_active = none, -- before, after: place new window relative to the focused window; none: place new window according to the value of new_on_top.
    }
})
