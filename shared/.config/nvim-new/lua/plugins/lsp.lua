local u = require("utils")
return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"gopls",
				"lua_ls",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		config = function()
			vim.lsp.enable({ "gopls", "lua_ls" })
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local buf = args.buf
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buf })
					vim.keymap.set("n", u.leader("gd"), vim.lsp.buf.definition, { buffer = buf })
					vim.keymap.set("n", u.leader("ca"), vim.lsp.buf.code_action, { buffer = buf })
				end,
			})
		end,
	},
}
