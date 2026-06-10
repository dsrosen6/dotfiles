vim.pack.add({ "https://github.com/folke/which-key.nvim" })
local wk = require("which-key")

wk.setup({
	preset = "helix",
})

wk.add({
	-- categories
	{ "<leader>c", desc = "code" },
	{ "<leader>f", group = "file/find" },
	{ "<leader>g", group = "git" },
	{ "<leader>x", desc = "diagnostics/quickfix" },

	-- hidden
	{ "<leader> ", hidden = true }, -- space-space telescope shortcut
})
