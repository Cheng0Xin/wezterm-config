local wezterm = require 'wezterm'

local function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    -- return "Catppuccin Mocha"
    return "Dawn (terminal.sexy)"
  else
    -- return "Catppuccin Latte"
    return "Unikitty Light (base16)"
  end
end

return { color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()) }
