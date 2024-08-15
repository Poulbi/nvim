local map = vim.keymap.set

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Move text easilly
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected text up" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected text down" })

-- better find next and previous
map("n", "n", "nzzzv", { desc = "Keep cursor in middle with search" })
map("n", "N", "Nzzzv", { desc = "Keep cursor in middle with search" })

map("n", "J", "mzJ`z", { desc = "Move up next line with space in between" })

-- greatest remap ever
map("x", "<leader>p", [["_dP]], { desc = "Paste while keeping the registry" })

-- moving
map("i", "<C-a>", "<C-o>I", { noremap = true })
map("i", "<C-e>", "<C-o>A", { noremap = true })
map("i", "<C-k>", "<C-o>D", { noremap = true })

-- buffers
map("n", "gb", "<cmd>buffers<cr>:buffer<Space>", { noremap = true })
map("n", "<Leader>q", "<cmd>q!<cr>", { noremap = true })
map("n", "<Leader>Q", "<cmd>qa!<cr>", { noremap = true })
-- close all except focused buffer
map("n", "<leader>1", "<cmd>%bd|e#<cr>", { noremap = true })
-- next tab
map("n", "+", "<cmd>tabe .<cr>", { noremap = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- allow for use of system clipboard fast
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])
map({ "n", "v" }, "<leader>P", [["+p]])

map({ "n", "v" }, "<leader>d", [["_d]])

-- templates
map("n", "<LocalLeader>rt", ":-1r " .. vim.fn.stdpath("config") .. "/templates", { noremap = true })

-- hide all
local s = { hidden_all = 0 }
map("n", "<C-h>", function()
	s.hidden_all = 1 - s.hidden_all
	local opt = s.hidden_all == 0
	vim.opt.showmode = opt
	vim.opt.ruler = opt
	vim.opt.nu = opt
	vim.opt.rnu = opt
	vim.opt.showcmd = opt
	vim.opt.laststatus = opt and 2 or 0
	vim.opt.signcolumn = opt and "yes" or "no"
end, { noremap = true })

-- write
map("n", "<Leader>w", "<cmd>write<cr>", { noremap = true })
map("n", "<Leader>W", "<cmd>write!<cr>", { noremap = true })
map("n", "<Leader>e", "<cmd>edit<cr>", { noremap = true })
map("n", "<LocalLeader>s", function()
	vim.cmd.source()
	print("sourced.")
end, { noremap = true })

-- Lazy
map("n", "<Leader>P", "<cmd>Lazy<cr>", { noremap = true })

-- spelling
map("n", "<C-s>s", "<cmd>setlocal spell!<cr>", { noremap = true })
map("n", "<C-s>g", "z=1<cr><cr>", { noremap = true })
