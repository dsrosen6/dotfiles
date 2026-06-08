return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "auto", -- picks up your colorscheme automatically
				globalstatus = true, -- single statusline across all splits
			},
		},
	},
}
