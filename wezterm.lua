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

-- For macos: Native fullscreen
config.native_macos_fullscreen_mode = true
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
	"CodeNewRoman Nerd Font Propo",
	"DejaVuSansMono Nerd Font Mono",
	"FantasqueSansM Nerd Font Propo",
	"ShureTechMono Nerd Font Propo",
	"BlexMono Nerd Font Propo",
})
config.font_size = 20

-- Tab Theme
local my_color = require("tabtheme")
config.window_frame = my_color.window_frame
config.colors = my_color.colors
config.tab_bar_at_bottom = my_color.tab_bar_at_bottom
config.use_fancy_tab_bar = my_color.use_fancy_tab_bar

-- Keybinding
local my_keybinding = require("keybinding")
my_keybinding.configure_key(config)

return config
