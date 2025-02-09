local wezterm = require("wezterm")
local waction = wezterm.action

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
end

return { configure_key = configure_key }
