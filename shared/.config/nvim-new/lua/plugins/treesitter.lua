return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	opts = {
		indent = { enable = true },
		highlight = { enable = true },
		folds = { enable = true },
		ensure_installed = {
			"bash",
			"go",
			"html",
			"javascript",
			"json",
			"lua",
			"luadoc",
			"markdown",
			"python",
			"toml",
			"xml",
			"yaml",
		},
	},
}
