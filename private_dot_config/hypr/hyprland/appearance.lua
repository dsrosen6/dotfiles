local mocha = require("hyprland.modules.mocha")

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 4,

		border_size = 2,

		col = {
			active_border = mocha.colors.sapphire,
			inactive_border = mocha.colors.surface0,
		},

		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 0,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = false,
	},
})
