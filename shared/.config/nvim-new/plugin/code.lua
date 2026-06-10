vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
	"https://folke/trouble.nvim",
	"https://folke/todo-comments.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/kdheepak/lazygit.nvim",
})

require("mini.ai").setup()
require("mini.pairs").setup()
require("todo-comments").setup()

------- Treesitter / LSP -------
require("nvim-treesitter").setup({
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
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"gopls",
		"lua_ls",
	},
})

vim.lsp.enable("gopls")
vim.lsp.enable("lua_ls")
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local buf = args.buf
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buf })
		vim.keymap.set("n", "<leader>cgd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = buf })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", buffer = buf })
	end,
})

------- Linting / Formatting -------
require("conform").setup({
	formatters_by_ft = {
		css = { "prettier" },
		go = { "goimports", "gofmt" },
		html = { "prettier" },
		javascript = { "prettier" },
		json = { "prettier" },
		lua = { "stylua" },
		markdown = { "prettier" },
		sh = { "shfmt" },
		yaml = { "prettier" },
	},
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 500,
	},
})

------- Git -------
------- Diagnostics -------
require("trouble").setup({
	modes = {
		lsp = {
			win = { position = "right" },
		},
	},
})

------- Keymaps --------
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle<cr>", { desc = "Symbols" })
vim.keymap.set("n", "<leader>cS", "<cmd>Trouble lsp toggle<cr>", { desc = "LSP references/definitions" })
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>gl", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
