local u = require("utils")
return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		keys = function()
			local builtin = require("telescope.builtin")
			return {
				{ u.leader("ff"), builtin.find_files, desc = "Find files" },
				{ u.leader(" "), builtin.find_files, desc = "Find files" },
			}
		end,
	},
}
