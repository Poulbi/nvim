local map = vim.keymap.set

map("n", ",v", [[<cmd>s/\(\s*\)\(.\+\)/\1"$(\2)"/<cr>]])
