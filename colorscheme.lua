local wezterm = require("wezterm")

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
		-- return "Dawn (terminal.sexy)"
	else
		return "Catppuccin Latte"
		-- return "Unikitty Light (base16)"
	end
end

local function background_for_appearance(appearance)
	if appearance:find("Dark") then
		return {
			image = wezterm.config_dir .. "/background/dark.png",
			brightness = 0.2,
			hue = 1,
			saturation = 0.5,
			opacity = 0.5,
			text_opacity = 0.8,
		}
	else
		return {
			image = wezterm.config_dir .. "/background/light.jpg",
			brightness = 2,
			hue = 0.5,
			saturation = 0.5,
			opacity = 0.8,
			text_opacity = 0.8,
		}
	end
end

local appearance = wezterm.gui.get_appearance()
local background = background_for_appearance(appearance)

return {
	color_scheme = scheme_for_appearance(appearance),
	window_background_image = background.image,
	window_background_image_hsb = {
		brightness = background.brightness,
		hue = background.hue,
		saturation = background.saturation,
	},
	window_background_opacity = background.opacity,
	text_background_opacity = background.text_opacity,
}
