return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
          files = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
    keys = {
      -- Switching the lazyvim default because I prefer leader-e for cwd instead of git root
      {
        "<leader>fE",
        function()
          Snacks.explorer({ cwd = LazyVim.root() })
        end,
        desc = "Explorer Snacks (root dir)",
      },
      {
        "<leader>fe",
        function()
          Snacks.explorer()
        end,
        desc = "Explorer Snacks (cwd)",
      },
      { "<leader>E", "<leader>fE", desc = "Explorer Snacks (root dir)", remap = true },
      { "<leader>e", "<leader>fe", desc = "Explorer Snacks (cwd)", remap = true },
    },
  },
}
