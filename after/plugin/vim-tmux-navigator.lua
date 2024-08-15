vim.g.tmux_navigator_no_mappings = true
vim.keymap.set("n", "<M-h>", ":<C-U>TmuxNavigateLeft<cr>", { silent = true })
vim.keymap.set("n", "<M-j>", ":<C-U>TmuxNavigateDown<cr>", { silent = true })
vim.keymap.set("n", "<M-k>", ":<C-U>TmuxNavigateUp<cr>", { silent = true })
vim.keymap.set("n", "<M-l>", ":<C-U>TmuxNavigateRight<cr>", { silent = true })
vim.keymap.set("n", "<M-/>", ":<C-U>TmuxNavigatePrevious<cr>", { silent = true })
