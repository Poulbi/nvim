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
	0/^#include/
	normal O
	.!include.sh ]] .. word)
	vim.cmd("normal ''")
end, { desc = "Include header for word under cursor" })
map("n", ",f", mapcmd("CF"), { desc = "Toggle formatting" })
vim.o.commentstring = "// %s"
