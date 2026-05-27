hl.window_rule({
	name = "float-special-workspace",
	match = {
		workspace = "special:S",
	},
	float = true,
	size = { 1000, 800 },
})

hl.window_rule({
	name = "float-image-viewer",
	match = {
		class = "org.gnome.Loupe",
	},
	float = true,
})
