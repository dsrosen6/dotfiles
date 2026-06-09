local u = require("utils")
return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		opts = {
			window = {
				mappings = {
					["h"] = "close_node",
					["l"] = "open",
				},
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
		},
		keys = {
			{ u.leader("e"), ":Neotree toggle<CR>", desc = "Neotree" },
		},
	},
}
