return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        gopls = {
          init_options = {
            semanticTokens = true,
          },
          settings = {
            gopls = {
              usePlaceholders = false,
              analyses = {
                -- disables package comment warning
                ST1000 = false,
              },
            },
          },
        },
      },
    },
  },
}
