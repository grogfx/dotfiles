-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

config.font = wezterm.font("NotoSansM NF")

-- or, changing the font size and color scheme.
config.font_size = 16
config.color_scheme = "Breeze"
config.window_decorations = "RESIZE"

local act = wezterm.action

local mykeys = {}
for i = 1, 9 do
	-- ALT + number to activate that tab
	table.insert(mykeys, {
		key = tostring(i),
		mods = "ALT",
		action = act.ActivateTab(i - 1),
	})
end

-- move tab
table.insert(mykeys, { key = "{", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) })
table.insert(mykeys, { key = "}", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) })

-- switch active tab
table.insert(mykeys, { key = "[", mods = "CTRL", action = act.ActivateTabRelative(-1) })
table.insert(mykeys, { key = "]", mods = "CTRL", action = act.ActivateTabRelative(1) })
table.insert(mykeys, {
	key = "R",
	mods = "CTRL|SHIFT",
	action = act.PromptInputLine({
		description = "Enter new name for tab",
		action = wezterm.action_callback(function(window, pane, line)
			-- line will be `nil` if they hit escape without entering anything
			-- An empty string if they just hit enter
			-- Or the actual line of text they wrote
			if line then
				window:active_tab():set_title(line)
			end
		end),
	}),
})

config.keys = mykeys

-- Finally, return the configuration to wezterm:
return config
