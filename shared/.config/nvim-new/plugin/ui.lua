vim.pack.add({
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/folke/snacks.nvim",
})

require("snacks.scroll").enable()
require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = true,
	},
})
