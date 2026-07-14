local am = require("hyprland.modules.animation")

hl.config({ animations = { enabled = true } })

am.define_beziers({
	{ name = "easeInCubic", points = { { 0.32, 0 }, { 0.67, 0 } } },
	{ name = "easeOutCubic", points = { { 0.33, 1 }, { 0.68, 1 } } },
	{ name = "easeInOutCubic", points = { { 0.65, 0 }, { 0.35, 1 } } },
	{ name = "linear", points = { { 0, 0 }, { 1, 1 } } },
	{ name = "almostLinear", points = { { 0.5, 0.5 }, { 0.75, 1 } } },
})

am.define_animations({
	{ leaf = "global", enabled = true, curve = "default", speed = 10 },
	{ leaf = "fade", enabled = true, curve = "almostLinear", speed = 3.03 },

	{ leaf = "windows", enabled = true, curve = "easeOutCubic", speed = 3, style = "popin" },
	{ leaf = "windowsIn", enabled = true, curve = "easeOutCubic", speed = 3, style = "popin" },
	{ leaf = "windowsOut", enabled = true, curve = "easeInCubic", speed = 3, style = "popin" },
	{ leaf = "windowsMove", enabled = true, curve = "easeInOutCubic", speed = 3, style = "slide" },
	{ leaf = "fadeIn", enabled = true, curve = "almostLinear", speed = 2 },
	{ leaf = "fadeOut", enabled = true, curve = "almostLinear", speed = 2 },

	{ leaf = "layers", enabled = true, curve = "easeOutCubic", speed = 1, style = "fade" },
	{ leaf = "layersIn", enabled = true, curve = "easeOutCubic", speed = 1, style = "fade" },
	{ leaf = "layersOut", enabled = true, curve = "easeOutCubic", speed = 1, style = "fade" },
	{ leaf = "fadeLayersIn", enabled = true, curve = "almostLinear", speed = 1.79 },
	{ leaf = "fadeLayersOut", enabled = true, curve = "almostLinear", speed = 1.39 },

	{ leaf = "workspaces", enabled = true, curve = "easeInOutCubic", speed = 2.5, style = "slidefade" },
	{ leaf = "specialWorkspace", enabled = true, curve = "easeInOutCubic", speed = 2, style = "fade" },

	{ leaf = "border", enabled = true, curve = "easeOutCubic", speed = 5.39 },
	{ leaf = "zoomFactor", enabled = true, curve = "almostLinear", speed = 7 },
})
