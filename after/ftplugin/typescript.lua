local map = vim.keymap.set

map("n", ",p", [[<cmd>s/\(\s*\)\(.\+\)/\1console.log("\2:", \2);<cr>]], { desc = "Surround var with console.log" })
