local wezterm = require("wezterm")
local utils = require("utils")

local colors = {
	latte = {
		rosewater = "#dc8a78",
		flamingo = "#dd7878",
		pink = "#ea76cb",
		mauve = "#8839ef",
		red = "#d20f39",
		maroon = "#e64553",
		peach = "#fe640b",
		yellow = "#df8e1d",
		green = "#40a02b",
		teal = "#179299",
		sky = "#04a5e5",
		sapphire = "#209fb5",
		blue = "#1e66f5",
		lavender = "#7287fd",
		text = "#4c4f69",
		subtext1 = "#5c5f77",
		subtext0 = "#6c6f85",
		overlay2 = "#7c7f93",
		overlay1 = "#8c8fa1",
		overlay0 = "#9ca0b0",
		surface2 = "#acb0be",
		surface1 = "#bcc0cc",
		surface0 = "#ccd0da",
		crust = "#dce0e8",
		mantle = "#e6e9ef",
		base = "#eff1f5",
	},
	frappe = {
		rosewater = "#f2d5cf",
		flamingo = "#eebebe",
		pink = "#f4b8e4",
		mauve = "#ca9ee6",
		red = "#e78284",
		maroon = "#ea999c",
		peach = "#ef9f76",
		yellow = "#e5c890",
		green = "#a6d189",
		teal = "#81c8be",
		sky = "#99d1db",
		sapphire = "#85c1dc",
		blue = "#8caaee",
		lavender = "#babbf1",
		text = "#c6d0f5",
		subtext1 = "#b5bfe2",
		subtext0 = "#a5adce",
		overlay2 = "#949cbb",
		overlay1 = "#838ba7",
		overlay0 = "#737994",
		surface2 = "#626880",
		surface1 = "#51576d",
		surface0 = "#414559",
		base = "#303446",
		mantle = "#292c3c",
		crust = "#232634",
	},
	macchiato = {
		rosewater = "#f4dbd6",
		flamingo = "#f0c6c6",
		pink = "#f5bde6",
		mauve = "#c6a0f6",
		red = "#ed8796",
		maroon = "#ee99a0",
		peach = "#f5a97f",
		yellow = "#eed49f",
		green = "#a6da95",
		teal = "#8bd5ca",
		sky = "#91d7e3",
		sapphire = "#7dc4e4",
		blue = "#8aadf4",
		lavender = "#b7bdf8",
		text = "#cad3f5",
		subtext1 = "#b8c0e0",
		subtext0 = "#a5adcb",
		overlay2 = "#939ab7",
		overlay1 = "#8087a2",
		overlay0 = "#6e738d",
		surface2 = "#5b6078",
		surface1 = "#494d64",
		surface0 = "#363a4f",
		base = "#24273a",
		mantle = "#1e2030",
		crust = "#181926",
	},
	mocha = {
		rosewater = "#f5e0dc",
		flamingo = "#f2cdcd",
		pink = "#f5c2e7",
		mauve = "#cba6f7",
		red = "#f38ba8",
		maroon = "#eba0ac",
		peach = "#fab387",
		yellow = "#f9e2af",
		green = "#a6e3a1",
		teal = "#94e2d5",
		sky = "#89dceb",
		sapphire = "#74c7ec",
		blue = "#89b4fa",
		lavender = "#b4befe",
		text = "#cdd6f4",
		subtext1 = "#bac2de",
		subtext0 = "#a6adc8",
		overlay2 = "#9399b2",
		overlay1 = "#7f849c",
		overlay0 = "#6c7086",
		surface2 = "#585b70",
		surface1 = "#45475a",
		surface0 = "#313244",
		base = "#1e1e2e",
		mantle = "#181825",
		crust = "#11111b",
	},
}

local mappings = {
	mocha = "Catppuccin Mocha",
	macchiato = "Catppuccin Macchiato",
	frappe = "Catppuccin Frappe",
	latte = "Catppuccin Latte",
}

local function select(palette, flavor, accent)
	local c = palette[flavor]
	return {
		tab_bar = {
			background = c.crust,
			active_tab = {
				bg_color = c[accent],
				fg_color = c.crust,
			},
			inactive_tab = {
				bg_color = c.mantle,
				fg_color = c.text,
			},
			inactive_tab_hover = {
				bg_color = c.base,
				fg_color = c.text,
			},
			new_tab = {
				bg_color = c.surface0,
				fg_color = c.text,
			},
			new_tab_hover = {
				bg_color = c.surface1,
				fg_color = c.text,
			},
			-- fancy tab bar
			inactive_tab_edge = c.surface0,
		},

		visual_bell = c.surface0,

		window_frame = {
			active_titlebar_bg = c.crust,
			active_titlebar_fg = c.text,
			inactive_titlebar_bg = c.crust,
			inactive_titlebar_fg = c.text,
			button_fg = c.text,
			button_bg = c.base,
		},
	}
end

local function scheme_for_tab(appearance)
	if appearance:find("Dark") then
		return select(colors, "mocha", "mauve")
	else
		return select(colors, "latte", "mauve")
	end
end

local function create_tab_title(tab, tabs, panes, config, hover, max_width)
	local user_title = tab.active_pane.user_vars.panetitle
	if user_title ~= nil and #user_title > 0 then
		return tab.tab_index + 1 .. ":" .. user_title
	end

	local title = wezterm.truncate_right(utils.basename(tab.active_pane.foreground_process_name), max_width)
	if title == "" then
		local dir = string.gsub(tab.active_pane.title, "(.*[: ])(.*)]", "%2")
		dir = utils.convert_useful_path(dir)
		title = wezterm.truncate_right(dir, max_width)
	end

	local copy_mode, n = string.gsub(tab.active_pane.title, "(.+) mode: .*", "%1", 1)
	if copy_mode == nil or n == 0 then
		copy_mode = ""
	else
		copy_mode = copy_mode .. ": "
	end
	return copy_mode .. tab.tab_index + 1 .. ":" .. title
end

local scheme = scheme_for_tab(wezterm.gui.get_appearance())

-- wezterm.on("update-right-status", function(window, pane)
-- 	-- Each element holds the text for a cell in a "powerline" style << fade
-- 	local cells = {}
--
-- 	-- Figure out the cwd and host of the current pane.
-- 	-- This will pick up the hostname for the remote host if your
-- 	-- shell is using OSC 7 on the remote host.
-- 	local cwd_uri = pane:get_current_working_dir()
-- 	if cwd_uri then
-- 		cwd_uri = cwd_uri:sub(8)
-- 		local slash = cwd_uri:find("/")
-- 		local cwd = ""
-- 		local hostname = ""
-- 		if slash then
-- 			hostname = cwd_uri:sub(1, slash - 1)
-- 			-- Remove the domain name portion of the hostname
-- 			local dot = hostname:find("[.]")
-- 			if dot then
-- 				hostname = hostname:sub(1, dot - 1)
-- 			end
-- 			-- and extract the cwd from the uri
-- 			cwd = cwd_uri:sub(slash)
--
-- 			-- table.insert(cells, cwd);
-- 			-- table.insert(cells, hostname);
-- 		end
-- 	end
--
-- 	-- I like my date/time in this style: "Wed Mar 3 08:14"
-- 	local date = wezterm.strftime("%a %b %-d %H:%M")
-- 	table.insert(cells, date)
--
-- 	-- An entry for each battery (typically 0 or 1 battery)
-- 	-- for _, b in ipairs(wezterm.battery_info()) do
-- 	-- 	table.insert(cells, string.format("%.0f%%", b.state_of_charge * 100))
-- 	-- end
--
-- 	-- The powerline < symbol
-- 	local LEFT_ARROW = utf8.char(0xe0b3)
-- 	-- The filled in variant of the < symbol
-- 	local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
--
-- 	local appearance = wezterm.gui.get_appearance()
--
-- 	local scheme = {}
--
-- 	if appearance:find("Dark") then
-- 		scheme = colors["mocha"]
-- 	else
-- 		scheme = colors["latte"]
-- 	end
-- 	-- Color palette for the backgrounds of each cell
-- 	local colors = {
-- 		scheme.base,
-- 		scheme.crust,
-- 		scheme.mantle,
-- 		scheme.surface0,
-- 	}
--
-- 	-- Foreground color for the text across the fade
-- 	local text_fg = scheme.text
--
-- 	-- The elements to be formatted
-- 	local elements = {}
-- 	-- How many cells have been formatted
-- 	local num_cells = 0
--
-- 	-- Translate a cell into elements
-- 	function push(text, is_last)
-- 		local cell_no = num_cells + 1
-- 		table.insert(elements, { Foreground = { Color = text_fg } })
-- 		table.insert(elements, { Background = { Color = colors[cell_no] } })
-- 		table.insert(elements, { Text = " " .. text .. " " })
-- 		if not is_last then
-- 			table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
-- 			table.insert(elements, { Text = SOLID_LEFT_ARROW })
-- 		end
-- 		num_cells = num_cells + 1
-- 	end
--
-- 	while #cells > 0 do
-- 		local cell = table.remove(cells, 1)
-- 		push(cell, #cells == 0)
-- 	end
--
-- 	window:set_right_status(wezterm.format(elements))
-- end)

return {
	window_frame = scheme.window_frame,
	colors = {
		tab_bar = scheme.tab_bar,
		visual_bell = scheme.visual_bell,
	},
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
}
