-- General
hl.window_rule({ match = { fullscreen = true }, rounding = 0, border_size = 0 })

-- Terminal
hl.window_rule({ match = { class = "kitty|Alacritty|org.wezfurlong.wezterm", float = true }, border_size = 2 })
hl.window_rule({ match = { class = "kitty|Alacritty|org.wezfurlong.wezterm" }, opacity = "1.0 override 1.0 override 0.9 override" })

-- GIMP - Image Editor
hl.window_rule({ match = { class = "gimp", title = "New Layer" },                    float = true, center = true, size = { "60%", "60%" } })
hl.window_rule({ match = { class = "gimp", title = "Open Image as Layers" },         float = true, center = true, size = { "60%", "60%" } })
hl.window_rule({ match = { class = "gimp", title = "Search Actions" },               float = true, center = true, size = { "60%", "60%" } })
hl.window_rule({ match = { class = "gimp", title = "Preferences" },                  float = true, center = true, size = { "70%", "70%" } })
hl.window_rule({ match = { class = "gimp", title = "Configure Keyboard Shortcuts" }, float = true, center = true, size = { "50%", "70%" } })
hl.window_rule({ match = { class = "^file-.*", title = "^Export Image as .*" },      float = true, center = true, size = { "40%", "30%" } })

-- Blender
hl.window_rule({ match = { class = "blender", title = "Preferences" }, float = true, center = true, size = { "60%", "60%" } })

-- Inkscape - Image Editor
hl.window_rule({ match = { class = "org.inkscape.Inkscape", title = ".* - Inkscape$" },          maximize = true })
hl.window_rule({ match = { class = "org.inkscape.Inkscape" },                                    float = true, center = true })
hl.window_rule({ match = { class = "org.inkscape.Inkscape", title = "New From Template" },       size = { "60%", "60%" } })
hl.window_rule({ match = { class = "org.inkscape.Inkscape", title = "Select file to open" },     size = { "60%", "60%" } })
hl.window_rule({ match = { class = "org.inkscape.Inkscape", title = "Select file to save to" },  size = { "60%", "60%" } })
hl.window_rule({ match = { class = "org.inkscape.Inkscape", title = "Select file to import" },   size = { "60%", "60%" } })
hl.window_rule({ match = { class = "org.inkscape.Inkscape", title = "^Filter Gallery - .*" },    size = { "60%", "60%" } })
hl.window_rule({ match = { class = "org.inkscape.Inkscape", title = "^Extension Gallery - .*" }, size = { "60%", "60%" } })
hl.window_rule({ match = { class = "org.inkscape.Inkscape" },                                    size = { "30%", "15%" } })

-- Calculator
hl.window_rule({ match = { title = "Calculator" }, float = true, center = true })

-- Zen Browser
hl.window_rule({ match = { class = "zen-beta", title = "Zen - Choose User Profile" }, float = true, center = true })
hl.window_rule({ match = { class = "zen-beta", title = "Developer Tools.*" }, tile = true })
hl.window_rule({ match = { title = "Save Image" },  float = true, center = true, size = { "70%", "70%" } })
hl.window_rule({ match = { title = "File Upload" }, float = true, center = true, size = { "70%", "70%" } })

-- Brave Browser
hl.window_rule({ match = { title = ".* wants to open$" },          float = true, center = true, size = { "70%", "70%" } })
hl.window_rule({ match = { title = ".* wants to save$" },          float = true, center = true, size = { "70%", "70%" } })
hl.window_rule({ match = { title = "All Files" },                  float = true, center = true, size = { "70%", "70%" } })
hl.window_rule({ match = { title = "Select Recording Directory" }, float = true, center = true, size = { "70%", "70%" } })

-- Fix some dragging issues with XWayland (Uncomment if needed; the 'no_focus' effect may differ in the Lua API)
-- hl.window_rule({ match = { xwayland = true, float = true, fullscreen = false, pinned = false }, no_focus = true })
