local function mapcmd(command)
	return function()
		vim.cmd(command)
	end
end

local map = vim.keymap.set
map("n", ",p", [[<cmd>s/\(\s*\)\(.\+\)/\1printf("\2: %d\\n", \2);<cr>]], { desc = "Surround var with printf" })
map("n", ",i", function()
	local word = vim.fn.expand("<cword>")
	vim.cmd([[
	normal m'
	0
	normal O
	.!include.sh ]] .. word)
	vim.cmd("normal ''")
end, { desc = "Include header for word under cursor" })
map("n", ",f", mapcmd("CF"), { desc = "Toggle formatting" })
map("i", "<M-1>", "#if 1<cr>#endif<esc>O", { desc = "Insert `#if 1` block" })

vim.opt.commentstring = "// %s"
-- disable indent in switch statement
vim.opt.cinoptions = "l1"

vim.cmd("TSDisable indent")
