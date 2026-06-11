vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = "1.*" },
})

require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<CR>"] = { "accept", "fallback" },
	},
})
