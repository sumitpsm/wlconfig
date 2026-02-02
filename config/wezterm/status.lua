local wezterm = require 'wezterm'

local STATUS = {}

-- Battery icon based on percentage
local function battery_icon(percent)
  if percent > 80 then
    return '󰁹'
  elseif percent > 60 then
    return '󰂀'
  elseif percent > 40 then
    return '󰁾'
  elseif percent > 20 then
    return '󰁼'
  else
    return '󰁺'
  end
end

-- Format battery info
local function battery_info()
  local battery_state = ''
  
  for _, b in ipairs(wezterm.battery_info()) do
    local icon = battery_icon(b.state_of_charge * 100)
    local percent = string.format('%.0f%%', b.state_of_charge * 100)
    
    if b.state == 'Charging' then
      icon = '󰂄'
    end
    
    battery_state = icon .. ' ' .. percent
  end
  
  return battery_state
end

-- Setup the status bar
function STATUS.setup()
  wezterm.on('update-right-status', function(window, pane)
    -- local date = wezterm.strftime('%a %b %-d')
    local time = wezterm.strftime('%H:%M')
    local battery = battery_info()
    
    local elements = {}
    
    -- table.insert(elements, date)
    table.insert(elements, time)
    
    if battery ~= '' then
      table.insert(elements, battery)
    end
    
    -- Join with separator
    local status = table.concat(elements, ' │ ')
    
    window:set_right_status(wezterm.format({
      { Foreground = { Color = '#8A8A8A' } },
      { Text = ' ' .. status .. ' ' },
    }))
  end)
end

return STATUS
