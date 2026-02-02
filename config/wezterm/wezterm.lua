local wezterm = require 'wezterm'
local status = require 'status'
local appearance = require 'appearance'
local config = wezterm.config_builder()

appearance.apply(config)
local act = wezterm.action
status.setup()

--------------------------------------------------------------------------------
-- KEYBINDINGS
--------------------------------------------------------------------------------
-- config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'Clipboard' },
  { key = 'p', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },

  -- Close pane/tab
  { key = 'q', mods = 'CTRL', action = act.CloseCurrentPane { confirm = false } },

  -- Tabs
  { key = 't', mods = 'CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
  {
    key = 'r',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  { key = 'e', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
  { key = 'o', mods = 'CTRL', action = act.ActivateTabRelative(1) },

  -- Scroll Mode
  { key = 'y', mods = 'CTRL', action = act.ScrollByPage(-0.5) },
  { key = 'i', mods = 'CTRL', action = act.ScrollByPage(0.5) },
  { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },

  -- Search Mode
  { key = 's', mods = 'CTRL|SHIFT', action = act.Search { CaseInSensitiveString = '' } },

  -- Workspace manager
  { key = 'w', mods = 'CTRL', action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' } },

  -------------------------------------------------------------------------------
  -- PANE MODE (Ctrl+s prefix)
  -------------------------------------------------------------------------------
  {
    key = 's',
    mods = 'CTRL',
    action = act.ActivateKeyTable {
      name = 'pane_mode',
      one_shot = false,
      timeout_milliseconds = 2000,
    },
  },

  -------------------------------------------------------------------------------
  -- RESIZE MODE (Ctrl+x prefix)
  -------------------------------------------------------------------------------
  {
    key = 'x',
    mods = 'CTRL',
    action = act.ActivateKeyTable {
      name = 'resize_mode',
      one_shot = false,
      timeout_milliseconds = 2000,
    },
  },
}

--------------------------------------------------------------------------------
-- KEY TABLES
--------------------------------------------------------------------------------

config.key_tables = {
  -- Pane mode (triggered by Ctrl+s)
  pane_mode = {
    { key = 'n', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'f', action = act.TogglePaneZoomState },
    { key = 't', action = act.PaneSelect { mode = 'SwapWithActive' } },
    
    -- Moving focus within panes
    { key = 'e', action = act.ActivatePaneDirection 'Left' },
    { key = 'i', action = act.ActivatePaneDirection 'Down' },
    { key = 'y', action = act.ActivatePaneDirection 'Up' },
    { key = 'o', action = act.ActivatePaneDirection 'Right' },

    -- Exit pane mode
    { key = 'Enter', action = 'PopKeyTable' },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 's', mods = 'CTRL', action = 'PopKeyTable' },
  },

  -- Resize mode (triggered by Ctrl+x)
  resize_mode = {
    { key = 'e', action = act.AdjustPaneSize { 'Left', 5 } },
    { key = 'i', action = act.AdjustPaneSize { 'Down', 5 } },
    { key = 'y', action = act.AdjustPaneSize { 'Up', 5 } },
    { key = 'o', action = act.AdjustPaneSize { 'Right', 5 } },
    { key = 'E', mods = 'SHIFT', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'I', mods = 'SHIFT', action = act.AdjustPaneSize { 'Down', 1 } },
    { key = 'Y', mods = 'SHIFT', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'O', mods = 'SHIFT', action = act.AdjustPaneSize { 'Right', 1 } },

    -- Exit resize mode
    { key = 'Enter', action = 'PopKeyTable' },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'x', mods = 'CTRL', action = 'PopKeyTable' },
  },
}

return config
