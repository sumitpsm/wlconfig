local main_mod = "SUPER"

hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

-- Focus
hl.bind(main_mod .. " + U", hl.dsp.focus({ direction = "u" }))
hl.bind(main_mod .. " + N", hl.dsp.focus({ direction = "l" }))
hl.bind(main_mod .. " + E", hl.dsp.focus({ direction = "d" }))
hl.bind(main_mod .. " + I", hl.dsp.focus({ direction = "r" }))

-- Resize
hl.bind(main_mod .. " + SHIFT + U", hl.dsp.window.resize({ x = 0,   y = -50, relative = true }), { repeating = true })
hl.bind(main_mod .. " + SHIFT + N", hl.dsp.window.resize({ x = -50, y = 0,   relative = true }), { repeating = true })
hl.bind(main_mod .. " + SHIFT + E", hl.dsp.window.resize({ x = 0,   y = 50,  relative = true }), { repeating = true })
hl.bind(main_mod .. " + SHIFT + I", hl.dsp.window.resize({ x = 50,  y = 0,   relative = true }), { repeating = true })

-- Swap Window
hl.bind(main_mod .. " + CTRL + U", hl.dsp.window.swap({ direction = "u" }))
hl.bind(main_mod .. " + CTRL + N", hl.dsp.window.swap({ direction = "l" }))
hl.bind(main_mod .. " + CTRL + E", hl.dsp.window.swap({ direction = "d" }))
hl.bind(main_mod .. " + CTRL + I", hl.dsp.window.swap({ direction = "r" }))

-- Move Window
hl.bind(main_mod .. " + CTRL + SHIFT + U", hl.dsp.window.move({ direction = "u" }))
hl.bind(main_mod .. " + CTRL + SHIFT + N", hl.dsp.window.move({ direction = "l" }))
hl.bind(main_mod .. " + CTRL + SHIFT + E", hl.dsp.window.move({ direction = "d" }))
hl.bind(main_mod .. " + CTRL + SHIFT + I", hl.dsp.window.move({ direction = "r" }))

-- Close Window
hl.bind(main_mod .. " + Z", hl.dsp.window.close())
hl.bind(main_mod .. " + SHIFT + Z", hl.dsp.exit())

-- Fullscreen
hl.bind(main_mod .. " + L",         hl.dsp.window.fullscreen_state({ internal = 2, client = 0, action = "toggle" }))
hl.bind(main_mod .. " + SHIFT + L", hl.dsp.window.fullscreen_state({ internal = 1, client = 0, action = "toggle" }))

-- Float
hl.bind(main_mod .. " + CTRL + L",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + CTRL + SHIFT + L", hl.dsp.window.pseudo({ action = "toggle" }))
-- hl.bind(main_mod .. " + CTRL + SHIFT + L", hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allfloat"))

-- Groups
hl.bind(main_mod .. " + minus",          hl.dsp.group.toggle())                         -- create/destroy group from active window
hl.bind(main_mod .. " + SHIFT + minus",  hl.dsp.group.lock({ action = "toggle" }))      -- toggle lock on active group
hl.bind(main_mod .. " + comma",          hl.dsp.group.prev())                           -- switch to the previous window in a group
hl.bind(main_mod .. " + period",         hl.dsp.group.next())                           -- switch to the next window in a group
hl.bind(main_mod .. " + SHIFT + comma",  hl.dsp.group.move_window({ forward = false })) -- move a window backward in a group
hl.bind(main_mod .. " + SHIFT + period", hl.dsp.group.move_window({ forward = true }))  -- move a window forward in a group

-- Zoom
hl.bind(main_mod .. " + SHIFT + mouse_down", function()
    local current = hl.get_config("cursor:zoom_factor")
    local factor  = (current < 1) and 1 or current
    hl.config({ cursor = { zoom_factor = factor * 2.0 } })
end)

hl.bind(main_mod .. " + SHIFT + mouse_up", function()
    local current = hl.get_config("cursor:zoom_factor")
    local factor  = (current < 1) and 1 or current
    local next    = factor / 2.0
    hl.config({ cursor = { zoom_factor = (next < 1) and 1 or next } })
end)

-- Trackpad pinch zoom
hl.gesture({ fingers = 2, direction = "pinchin",  action = "cursorZoom", zoom_level = 2.0, mode = "mult" })
hl.gesture({ fingers = 2, direction = "pinchout", action = "cursorZoom", zoom_level = 0.5, mode = "mult" })
hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", zoom_level = 1, mode = "live" })
