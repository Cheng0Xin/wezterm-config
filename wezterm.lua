local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Colorscheme
local my_colorscheme = require("colorscheme")
config.color_scheme = my_colorscheme.color_scheme
-- config.window_background_image = my_colorscheme.window_background_image
-- config.window_background_image_hsb = my_colorscheme.window_background_image_hsb
config.text_background_opacity = my_colorscheme.text_background_opacity
config.window_background_opacity = my_colorscheme.window_background_opacity
config.macos_window_background_blur = 20

-- For macos: Native fullscreen
config.native_macos_fullscreen_mode = true
config.enable_wayland = false
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 4,
  right = 0,
  top = 10,
  bottom = 0,
}
config.enable_scroll_bar = false

-- Font
config.font = wezterm.font_with_fallback({
  "Maple Mono NF CN",
  "Hack Nerd Font Mono",
  "JetBrainsMono Nerd Font Mono",
  "DejaVuSansMono Nerd Font Mono",
  "ShureTechMono Nerd Font Propo",
  "IosevkaTermSlab Nerd Font Mono",
  "CodeNewRoman Nerd Font Propo",
  "BlexMono Nerd Font Propo",
})
config.font_size = 22

-- Tab Theme
local my_color = require("tabtheme")
config.window_frame = my_color.window_frame
config.colors = my_color.colors
config.tab_bar_at_bottom = my_color.tab_bar_at_bottom
config.use_fancy_tab_bar = my_color.use_fancy_tab_bar

-- Keybinding
-- local my_keybinding = require("keybinding")
-- my_keybinding.configure_key(config)

function configure_key(config)
  config.keys = {
    -- Move tab
    {
      key = "H",
      mods = "CTRL|SHIFT",
      action = wezterm.action.DisableDefaultAssignment,
    },
    {
      key = "L",
      mods = "CTRL|SHIFT",
      action = wezterm.action.DisableDefaultAssignment,
    },
    -- German letter
    -- Map Option + U + A to ä
    { key = "a", mods = "OPT|CTRL", action = wezterm.action { SendString = "ä" } },
    -- Map Option + U + O to ö
    { key = "o", mods = "OPT|CTRL", action = wezterm.action { SendString = "ö" } },
    -- Map Option + U + U to ü
    { key = "u", mods = "OPT|CTRL", action = wezterm.action { SendString = "ü" } },
    -- Map Option + S to ß
    { key = "s", mods = "OPT|CTRL", action = wezterm.action { SendString = "ß" } },
  }
end

configure_key(config)

return config
