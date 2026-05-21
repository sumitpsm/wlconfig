local main_mod = "SUPER"

-- Workspaces
local ws_keys = { "W", "C", "P", "B", "G", "K", "D", "F", "X", "Z" }
for i, key in ipairs(ws_keys) do
    hl.bind(main_mod .. " + " .. key,               hl.dsp.focus({ workspace = i }))
    hl.bind(main_mod .. " + SHIFT + " .. key,       hl.dsp.window.move({ workspace = i }))
    hl.bind(main_mod .. " + CTRL + " .. key,        hl.dsp.window.move({ workspace = i, silent = true }))
end

-- Cycle layouts: scrolling -> dwindle -> master -> monocle
hl.bind(main_mod .. " + SHIFT + A", function()
    local current = hl.get_config("general:layout")
    local cycle = { scrolling = "dwindle", dwindle = "master", master = "monocle", monocle = "scrolling" }
    local next = cycle[current]
    if not next then
        return
    end
    hl.config({ general = { layout = next } })
    hl.notification.create({
        text    = " Layout: " .. next,
        timeout = 2000,
        icon    = "ok",
    })
end)


-- hl.bind(main_mod .. " + ",        hl.dsp.window.cycle_next("tiled"))      -- cycle next, tiled windows only

-- Scrolling
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("fit active"))            -- fit active window to screen
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("fit all"))               -- fit all columns to screen
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("fit visible"))           -- resize width of all window evenly
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("fit tobeg"))             -- fit all left columns evenly to screen wrt active column
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("fit toend"))             --! fit all right columns evenly to screen wrt active column
---
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("focus l"))               -- moves the focus to left and centers the layout
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("focus r"))               -- moves the focus to right and centers the layout
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("move +col"))             -- scroll viewport forward one column
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("move -col"))             -- scroll viewport back one column
-- 
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("colresize +conf"))       -- resize column: cycle wider
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("colresize -conf"))       -- resize column: cycle narrower
-- 
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("swapcol l"))             -- swap current column left
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("swapcol r"))             -- swap current column right
-- 
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("consume"))               -- consume adjacent window into current column (0.55+)
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("expel"))                 -- expel active window out of its column (0.55+)
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("consume_or_expel prev")) -- consume-or-expel left (0.55+)
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("consume_or_expel next")) -- consume-or-expel right (0.55+)
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("promote"))               -- move active window into its own column


-- Dwindle
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("rotatesplit"))           -- rotate the split
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("togglesplit"))           -- toggle horizontal/vertical split
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("swapsplit"))             -- swap the two siblings of the split
--
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("preselect u"))           -- next split: force up
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("preselect r"))           -- next split: force right
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("preselect d"))           -- next split: force down
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("preselect l"))           -- next split: force left
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("movetoroot"))            -- move active window to root of tree
--- 
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("splitratio 0.1"))        -- resize: grow current split
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("splitratio -0.1"))       -- resize: shrink current split
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("splitratio 1.0 exact"))  -- resize: set split to exact value


-- Master
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("orientationleft"))        -- set master area: left
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("orientationright"))       -- set master area: right
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("orientationtop"))         -- set master area: top
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("orientationbottom"))      -- set master area: bottom
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("orientationcenter"))      -- set master area: center
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("addmaster"))              -- increase master window count
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("removemaster"))           -- decrease master window count
---
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("cyclenext"))              -- focus next window in stack
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("cycleprev"))              -- focus previous window in stack
-- 
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("mfact 0.1"))              -- grow master, shink slaves
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("mfact -0.1"))             -- shrink master, grow slaves
-- 
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("rollprev"))               -- rotate stack backward (master changes)
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("rollnext"))               -- rotate stack forward (master changes)
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("swapprev"))               -- swaps focused window with prev window
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("swapnext"))               -- swaps focused window with next window
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("swapwithmaster master"))  -- swap active with master
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("swapwithmaster child"))   -- swap master with a child
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("swapwithmaster auto"))    -- swap auto pick


-- Monocle
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("cyclenext"))              -- focus next window (use cycle_next for float support)
-- hl.bind(main_mod .. " + ",        hl.dsp.layout("cycleprev"))              -- focus previous window
