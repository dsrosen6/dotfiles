vim.pack.add({
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/akinsho/bufferline.nvim",
})

require("bufferline").setup()
require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = true,
	},
})
