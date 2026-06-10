vim.pack.add({
	{
		src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
		version = vim.version.range("3"),
	},
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-mini/nvim-web-devicons",
})

require("nvim-web-devicons").setup()
require("neo-tree").setup({
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
})

vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Explorer" })
