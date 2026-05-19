local palette = require("./confs/palette")

hl.config({
    general = {
        ["col.active_border"]          = palette.color8,
        ["col.inactive_border"]        = palette.color0,
        ["col.nogroup_border_active"]  = palette.color8,
        ["col.nogroup_border"]         = palette.color0,
    },
})

hl.config({
    decoration = {
        shadow = {
            color          = palette.color2,
            color_inactive = palette.color0,
        },
    },
})

hl.config({
    group = {
        ["col.border_active"]          = palette.color5,
        ["col.border_inactive"]        = palette.background,
        ["col.border_locked_active"]   = palette.color11,
        ["col.border_locked_inactive"] = palette.color11,
        groupbar = {
            text_color              = palette.foreground,
            ["col.active"]          = palette.color8,
            ["col.inactive"]        = palette.color0,
            ["col.locked_active"]   = palette.color8,
            ["col.locked_inactive"] = palette.color0,
        },
    },
})
