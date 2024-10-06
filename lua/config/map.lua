local map = vim.keymap.set

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- open config
map("n", " c", function()
	vim.cmd("cd ~/.config/nvim")
	vim.cmd("e " .. "init.lua")
end, { desc = "Open neovim config file" })
-- Move text easilly
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected text up" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected text down" })

-- better find next and previous
map("n", "n", "nzzzv", { desc = "Keep cursor in middle with search" })
map("n", "N", "Nzzzv", { desc = "Keep cursor in middle with search" })

map("n", "J", "mzJ`z", { desc = "Move up next line with space in between" })

-- greatest remap ever
map("x", " p", [["_dP]], { desc = "Paste while keeping the registry" })

-- moving
map("i", "<C-a>", "<C-o>I", { noremap = true })
map("i", "<C-e>", "<C-o>A", { noremap = true })

-- buffers
map("n", " sp", "<cmd>sp<cr>", { desc = "Open horizontal split" })
map("n", " vs", "<cmd>vs<cr>", { desc = "Open vertical split" })
map("n", " q", "<cmd>q!<cr>", { noremap = true })
map("n", " Q", "<cmd>qa!<cr>", { noremap = true })
-- close all except focused buffer
map("n", " 1", "<cmd>%bd|e#<cr>", { noremap = true })
-- next tab
map("n", "+", "<cmd>tabe .<cr>", { noremap = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- allow for use of system clipboard fast
map({ "n", "v" }, " y", [["+y]])
map("n", " Y", [["+Y]])
map({ "n", "v" }, " P", [["+p]])

-- templates
map("n", "<LocalLeader>rt", ":-1r " .. vim.fn.stdpath("config") .. "/templates", { noremap = true })

-- hide all
local hidden = true -- flag
vim.api.nvim_create_user_command("Hide", function()
	hidden = hidden == false
	vim.opt.showmode = hidden
	vim.opt.ruler = hidden
	vim.opt.nu = hidden
	vim.opt.rnu = hidden
	vim.opt.showcmd = hidden
	vim.opt.laststatus = hidden and 2 or 0
	vim.opt.signcolumn = hidden and "yes" or "no"
end, {})

-- write
map("n", " w", "<cmd>write<cr>", { noremap = true })
map("n", " W", "<cmd>write!<cr>", { noremap = true })
map("n", " e", "<cmd>edit<cr>", { noremap = true })
map("n", ",s", function()
	vim.cmd.source()
	print("sourced.")
end, { noremap = true })

-- Lazy
map("n", " P", "<cmd>Lazy<cr>", { noremap = true })

-- spelling
map("n", " ts", "<cmd>setlocal spell!<cr>", { noremap = true, desc = "Toggle spelling" })
map("n", "<C-s>g", "z=1<cr><cr>", { noremap = true })

map("n", " td", function()
	vim.diagnostic.enable(vim.diagnostic.is_enabled() == false)
end, { desc = "Toggle diagnostics" })
