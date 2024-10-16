local map = vim.keymap.set
map("n", ",p", [[<cmd>s/\(\s*\)\(.\+\)/\1printf("\2: %d\\n", \2);<cr>]], { desc = "Surround var with printf" })
vim.o.commentstring = "// %s"
