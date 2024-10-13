local map = vim.keymap.set

map("n", ",v", [[<cmd>s/\(\s*\)\(.\+\)/\1"$(\2)"/<cr>]], { desc = "Surround with variable" })
map("n", ",p", [[<cmd>s/\(\s*\)\(.\+\)/\1>\&2 printf '\2: %s\\n' "$\2"/<cr>]], { desc = "Surround var with printf" })
map("n", ",e", [[<cmd>s/\(\s*\)\(.\+\)/\1[ "$\2" ] || exit 1'/<cr>]], { desc = "Surround var with exit if empty" })
