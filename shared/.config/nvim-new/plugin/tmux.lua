vim.pack.add({ "https://github.com/christoomey/vim-tmux-navigator" })

vim.keymap.set("n", "<a-h>", "<cmd>TmuxNavigateLeft<cr>")
vim.keymap.set("n", "<a-j>", "<cmd>TmuxNavigateDown<cr>")
vim.keymap.set("n", "<a-k>", "<cmd>TmuxNavigateUp<cr>")
vim.keymap.set("n", "<a-l>", "<cmd>TmuxNavigateRight<cr>")
vim.keymap.set("n", "<a-\\>", "<cmd>TmuxNavigatePrevious<cr>")
