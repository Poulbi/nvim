local map = vim.keymap.set

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local function verbose_toggle(value, name)
	local toggle = value == false
	if toggle == true then
		print("Enabled " .. name .. ".")
	else
		print("Disabled " .. name .. ".")
	end
	return toggle
end

-- open config
map("n", " c", function()
	vim.cmd("cd ~/.config/nvim")
	vim.cmd("e " .. "init.lua")
end, { desc = "Open neovim config file" })

-- insert navigation
map("i", "<C-a>", "<C-o>I", { noremap = true })
map("i", "<C-e>", "<C-o>A", { noremap = true })

-- buffers
map("n", " q", "<cmd>q!<cr>", { noremap = true })
map("n", " Q", "<cmd>qa!<cr>", { noremap = true })
map("n", "!", "<cmd>sp<CR><cmd>term<CR>", { desc = "Open terminal" })
map("n", "<M-b>", "<cmd>write<cr><cmd>make<cr>", { desc = "Make" })
map("n", "<M-|>", "<cmd>bn<cr>", { noremap = true })
map("n", "<M-\\>", "<cmd>bp<cr>", { noremap = true })
map("n", " bd", "<cmd>bd<cr>", { noremap = true })
map("n", " bl", "<cmd>buffers<cr>", { noremap = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected text up" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected text down" })
map("x", " p", [["_dP]], { desc = "Paste while keeping the registry" })
map("n", "n", "nzzzv", { desc = "Keep cursor in middle with search" })
map("n", "N", "Nzzzv", { desc = "Keep cursor in middle with search" })
map("n", "J", "mzJ`z", { desc = "Move up next line with space in between" })

-- allow for use of system clipboard fast
map({ "n", "v" }, " y", [["+y]])
map("n", " Y", [["+Y]])
map({ "n", "v" }, " P", [["+p]])

-- hide all
local hidden = true -- flag
vim.api.nvim_create_user_command("Hide", function()
	hidden = hidden == false
	vim.opt.showmode = false
	vim.opt.ruler = false
	vim.opt.showcmd = false
	vim.opt.laststatus = false and 2 or 0
	vim.cmd("normal :<CR>")
end, {})
vim.cmd("Hide")

vim.api.nvim_create_user_command("ScriptDirectory", function()
	vim.api.nvim_paste(
		[[
ScriptDirectory="$(dirname "$(readlink -f "$0")")"
cd "$ScriptDirectory"
  ]],
		false,
		-1
	)
end, {})

map("n", " x", "!cx %", { desc = "Toggle file as executable" })
map("n", " w", "<cmd>write<cr>", { noremap = true })
map("n", ",s", function()
	vim.cmd.source()
	print("Sourced.")
end, { noremap = true })

-- spelling
map("n", " ts", function()
	vim.o.spell = verbose_toggle(vim.o.spell, "spelling")
end, { noremap = true, desc = "Toggle spelling" })
map("n", "<c-s>g", "z=1<cr><cr>", { noremap = true, desc = "Correct word" })

map("n", " td", function()
	vim.diagnostic.enable(verbose_toggle(vim.diagnostic.is_enabled(), "diagnostics"))
end, { desc = "Toggle diagnostics" })

-- editing
map("n", " sf", ":%s/\\<<C-R><C-W>\\>//gc<Left><Left><Left>", { desc = "Replace word under cursor in file" })
map("n", " sl", ":s/\\<<C-R><C-W>\\>//g<Left><Left>", { desc = "Replace word under cursor on current line" })

-- From https://github.com/neovim/neovim/discussions/35081
map("v", " sf", function()
	local s_start = vim.fn.getpos(".")
	local s_end = vim.fn.getpos("v")
	local lines = vim.fn.getregion(s_start, s_end)
	local selection = lines
	local text = vim.fn.escape(selection[1], [[\/]])
	for i = 2, #selection do
		text = text .. "\\n" .. vim.fn.escape(selection[i], [[\/]])
	end
	local clear_selection = vim.api.nvim_replace_termcodes("<C-u>", true, false, true)
	local double_left = vim.api.nvim_replace_termcodes("<Left><Left>", true, false, true)
	local keys_to_feed = ":" .. clear_selection .. "%s/" .. text .. "//gc" .. double_left
	vim.fn.feedkeys(keys_to_feed)
end, { desc = "Replace selected text through file" })

map("n", "]q", "<cmd>cn<cr>", { desc = "Next item in quickfix", silent = true })
map("n", "[q", "<cmd>cp<cr>", { desc = "Next item in quickfix", silent = true })

vim.api.nvim_create_user_command("Scratch", function()
	vim.cmd([[
    e scratch
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    ]])
end, {})
