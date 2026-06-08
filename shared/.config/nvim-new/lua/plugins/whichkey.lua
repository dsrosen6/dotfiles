local u = require("utils")
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix",
	},
	keys = {
		{
			u.leader("f"),
			"<nop>",
			desc = "Find",
		},
		{
			u.leader("?"),
			function() require("which-key").show({ global = false }) end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
