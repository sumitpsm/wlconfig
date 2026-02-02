local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

-- Define color schemes
local color_schemes = {
  ['ghostty'] = {
    foreground = '#d8d8d8',
    selection_bg = '#bbbbbb',
    selection_fg = '#000000',
    ansi = { '#1d1f21', '#cc6666', '#b5bd68', '#f0c674', '#81a2be', '#b294bb', '#8abeb7', '#c5c8c6' },
    brights = { '#666666', '#d54e53', '#b9ca4a', '#e7c547', '#7aa6da', '#c397d8', '#70c0b1', '#eaeaea' },
  },
  
  ['alacritty'] = {
    foreground = '#d8d8d8',
    selection_bg = '#bbbbbb',
    selection_fg = '#000000',
    ansi = { '#181818', '#ac4242', '#90a959', '#f4bf75', '#6a9fb5', '#aa759f', '#75b5aa', '#d8d8d8' },
    brights = { '#0f0f0f', '#712b2b', '#5f6f3a', '#a17e4d', '#456877', '#704d68', '#4d7770', '#8e8e8e' },
  },
  
  ['kitty'] = {
    foreground = '#ffffff',
    selection_bg = '#bbbbbb',
    selection_fg = '#000000',
    ansi = { '#393939', '#da4939', '#9acc79', '#d0d26b', '#6d9cbe', '#9f5079', '#435d75', '#c2c2c2' },
    brights = { '#474747', '#da4939', '#9acc79', '#d0d26b', '#6d9cbe', '#9f5079', '#435d75', '#c2c2c2' },
  },

  ['bright'] = {
    foreground = '#d8d8d8',
    selection_bg = '#bbbbbb',
    selection_fg = '#000000',
    ansi = { '#15161e', '#f7768e', '#9ece6a', '#e0af68', '#7aa2f7', '#bb9af7', '#7dcfff', '#a9b1d6' },
    brights = { '#0f1015', '#a6505e', '#6b8e45', '#9c7a46', '#526ca6', '#7c66a6', '#568ca6', '#737aa2' },
  },
}

-- Apply all settings to config
function M.apply(config)
  -- Color schemes
  config.color_schemes = color_schemes
  
  -- Appearance
  config.color_scheme = 'ghostty'
  config.font = wezterm.font("Dejavu Sans Mono")
  config.font_size = 15.0
  config.disable_default_key_bindings = true
  config.window_decorations = "RESIZE"
  config.enable_scroll_bar = false
  config.enable_tab_bar = true
  config.use_fancy_tab_bar = false
  config.show_tab_index_in_tab_bar = true
  config.hide_tab_bar_if_only_one_tab = true
  config.tab_bar_at_bottom = true
  config.tab_max_width = 25
  config.underline_thickness = '1pt'
  config.window_close_confirmation = 'NeverPrompt'
  config.window_padding = { left = 4, right = 2, top = 2, bottom = 2 }
  config.inactive_pane_hsb = { saturation = 1, brightness = 1 }
  config.colors = {
    tab_bar = {
      background         = 'rgba(0, 0, 0, 0.4)',
      active_tab         = { bg_color = '#AFFF00', fg_color = '#000000', intensity = 'Bold' },
      inactive_tab       = { bg_color = '#8A8A8A', fg_color = '#000000' },
      inactive_tab_hover = { bg_color = '#9A9A9A', fg_color = '#000000' },
      new_tab            = { bg_color = '#8A8A8A', fg_color = '#000000' },
      new_tab_hover      = { bg_color = '#AFFF00', fg_color = '#000000' },
    },
  }
  
  -- Behavior
  config.max_fps = 120
  config.front_end = 'WebGpu' -- @type 'WebGpu' | 'OpenGL' | 'Software'
  config.scrollback_lines = 8192
  config.enable_kitty_keyboard = true
  config.enable_csi_u_key_encoding = true
  config.mouse_bindings = {
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = act.CompleteSelection 'ClipboardAndPrimarySelection',
    },
  }
  
  -- Cache environment variables (computed once, not per tab update)
  local HOME = os.getenv("HOME") or os.getenv("USERPROFILE") or ""
  local SHELL = os.getenv("SHELL") or ""
  local SHELL_NAME = SHELL:match("([^/\\]+)$") or ""

  -- Register tab title formatting event
  wezterm.on('format-tab-title', function(tab)
    local process = tab.active_pane.foreground_process_name
    local cwd = tab.active_pane.current_working_dir
    local index = tab.tab_index + 1

    -- Get directory name
    local dir_name = "~"
    if cwd then
      local path = cwd.file_path or ""
      
      -- Check if current directory is home (fast string comparison)
      if path == HOME then
        dir_name = "~"
      else
        -- Extract basename (single pattern match)
        dir_name = path:match("([^/\\]+)$") or "~"
      end
    end  

    -- Get process basename (only if process exists)
    if process then
      local proc_name = process:match("([^/\\]+)$")
      
      -- Remove .exe extension if present (single gsub call)
      if proc_name:sub(-4) == ".exe" then
        proc_name = proc_name:sub(1, -5)
      end
      
      -- Show process name only if it's not the shell
      if proc_name ~= SHELL_NAME then
        return string.format(' %d: %s #%s ', index, dir_name, proc_name)
      end
    end
    
    return string.format(' %d: %s ', index, dir_name)
  end)
end

return M
