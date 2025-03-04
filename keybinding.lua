local wezterm = require("wezterm")
local waction = wezterm.action


function configure_key_simple(config)
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

function configure_key(config)
	config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
	config.keys = {
		-- Full screen support
		{
			key = "F",
			mods = "CTRL|SHIFT",
			action = waction.ToggleFullScreen,
		},
		-- Tmux-like pane manage
		-- Split horizontally or vertically
		{
			key = "|",
			mods = "LEADER|SHIFT",
			action = waction.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "-",
			mods = "LEADER",
			action = waction.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		-- Move among panes
		{
			key = "k",
			mods = "LEADER",
			action = waction.ActivatePaneDirection("Up"),
		},
		{
			key = "j",
			mods = "LEADER",
			action = waction.ActivatePaneDirection("Down"),
		},
		{
			key = "h",
			mods = "LEADER",
			action = waction.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "LEADER",
			action = waction.ActivatePaneDirection("Right"),
		},
		-- Toggle zoom: current pane
		{
			key = "z",
			mods = "LEADER",
			action = waction.TogglePaneZoomState,
		},
		-- Close current pane
		{
			key = 'c',
			mods = 'LEADER',
			action = waction.CloseCurrentPane { confirm = false }
		},
		-- Size adjust
		{
			key = "e",
			mods = "LEADER",
			action = waction.AdjustPaneSize({ "Down", 2 }),
		},
		{
			key = "e",
			mods = "LEADER|SHIFT",
			action = waction.AdjustPaneSize({ "Up", 2 }),
		},
		-- Create new tab
		{
			key = "c",
			mods = "LEADER",
			action = waction.SpawnTab("CurrentPaneDomain"),
		},
		-- Home button
		{
			key = "a",
			mods = "LEADER|CTRL",
			action = waction.SendKey({ key = "Home" }),
		},
		-- Move tab
		{
			key = "H",
			mods = "CTRL|SHIFT",
			action = waction.ActivateTabRelative(-1),
		},
		{
			key = "L",
			mods = "CTRL|SHIFT",
			action = waction.ActivateTabRelative(1),
		},
		-- Rename tab
		{
			key = 'r',
			mods = 'LEADER',
			action = wezterm.action.PromptInputLine {
				description = 'Enter new name for tab',
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			},
		}, -- Detach session
		{
			key = 'd',
			mods = 'LEADER',
			action = wezterm.action.DetachDomain 'CurrentPaneDomain',
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

	-- Activate tabs
	for i = 1, 8 do
		table.insert(config.keys, {
			key = tostring(i),
			mods = "LEADER",
			action = waction.ActivateTab(i - 1),
		})
	end

	-- Activate Copy mode
	table.insert(config.keys, {
		key = "[",
		mods = "LEADER",
		action = waction.ActivateCopyMode,
	})

	table.insert(config.keys, {
		key = "C",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
	})

	table.insert(config.keys, {
		key = "V",
		mods = "CTRL|SHIFT",
		action = wezterm.action.PasteFrom("Clipboard"),
	})

	-- Resize panel
	table.insert(config.keys, {
		key = "=",
		mods = 'LEADER',
		action = wezterm.action.ActivateKeyTable {
			name = 'resize_pane',
			one_shot = false,
			timeout_milliseconds = 1000,
		},
	})
	config.key_tables = {
		-- Defines the keys that are active in our resize-pane mode.
		-- Since we're likely to want to make multiple adjustments,
		-- we made the activation one_shot=false. We therefore need
		-- to define a key assignment for getting out of this mode.
		-- 'resize_pane' here corresponds to the name="resize_pane" in
		-- the key assignments above.
		resize_pane = {
			{ key = 'LeftArrow',  action = wezterm.action.AdjustPaneSize { 'Left', 4 } },
			{ key = 'h',          action = wezterm.action.AdjustPaneSize { 'Left', 4 } },

			{ key = 'RightArrow', action = wezterm.action.AdjustPaneSize { 'Right', 4 } },
			{ key = 'l',          action = wezterm.action.AdjustPaneSize { 'Right', 4 } },

			{ key = 'UpArrow',    action = wezterm.action.AdjustPaneSize { 'Up', 4 } },
			{ key = 'k',          action = wezterm.action.AdjustPaneSize { 'Up', 4 } },

			{ key = 'DownArrow',  action = wezterm.action.AdjustPaneSize { 'Down', 4 } },
			{ key = 'j',          action = wezterm.action.AdjustPaneSize { 'Down', 4 } },

			-- Cancel the mode by pressing escape
			{ key = 'Escape',     action = 'PopKeyTable' },
		},
	}
end

return { configure_key = configure_key }
