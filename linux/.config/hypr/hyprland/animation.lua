local am = require("hyprland.modules.animation")

hl.config({ animations = { enabled = true } })

am.define_beziers({
	{ name = "easeOutQuint", points = { { 0.23, 1 }, { 0.32, 1 } } },
	{ name = "easeInOutCubic", points = { { 0.65, 0.05 }, { 0.36, 1 } } },
	{ name = "linear", points = { { 0, 0 }, { 1, 1 } } },
	{ name = "almostLinear", points = { { 0.5, 0.5 }, { 0.75, 1 } } },
	{ name = "quick", points = { { 0.15, 0 }, { 0.1, 1 } } },
	{ name = "overshot", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } },
})

am.define_springs({
	{ name = "windowsSpring", duration = 1.0, bounce = 0.25 },
	{ name = "windowsMoveSpring", duration = 1.2, bounce = 0.22 },
	{ name = "workspaceSpring", duration = 0.9, bounce = 0.22 },
})

am.define_animations({
	{ leaf = "global", enabled = true, curve = "default", speed = 10 },
	{ leaf = "windows", enabled = true, curve = "windowsSpring", speed = 1, style = "slide" },
	{ leaf = "windowsIn", enabled = true, curve = "windowsSpring", speed = 1, style = "popin" },
	{ leaf = "windowsOut", enabled = true, curve = "windowsSpring", speed = 1, style = "popin" },
	{ leaf = "windowsMove", enabled = true, curve = "windowsMoveSpring", speed = 1, style = "slide" },
	{ leaf = "layers", enabled = true, curve = "easeOutQuint", speed = 3.81 },
	{ leaf = "layersIn", enabled = true, curve = "easeOutQuint", speed = 4, style = "fade" },
	{ leaf = "layersOut", enabled = true, curve = "linear", speed = 1.5, style = "fade" },
	{ leaf = "fade", enabled = true, curve = "quick", speed = 3.03 },
	{ leaf = "fadeIn", enabled = true, curve = "almostLinear", speed = 1.73 },
	{ leaf = "fadeOut", enabled = true, curve = "almostLinear", speed = 1.46 },
	{ leaf = "fadeLayersIn", enabled = true, curve = "almostLinear", speed = 1.79 },
	{ leaf = "fadeLayersOut", enabled = true, curve = "almostLinear", speed = 1.39 },
	{ leaf = "workspaces", enabled = true, curve = "workspaceSpring", speed = 1, style = "slidevert" },
	{ leaf = "specialWorkspace", enabled = true, curve = "workspaceSpring", speed = 1, style = "slidevert" },
	{ leaf = "border", enabled = true, curve = "easeOutQuint", speed = 5.39 },
	{ leaf = "zoomFactor", enabled = true, curve = "quick", speed = 7 },
})
