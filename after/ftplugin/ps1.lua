local map = vim.keymap.set
map("n", ",p", [[<cmd>s/^\(\s*\)\(.\+\)/\1Write-Host "\2: $\2"/<cr>]], { desc = "Surround var with Write-Host" })
