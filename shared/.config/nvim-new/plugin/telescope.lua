vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	"https://github.com/nvim-telescope/telescope.nvim",
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find files" })
vim.keymap.set("n", "<leader> ", builtin.find_files, { desc = "Find files" })
