local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():append()
end, { desc = "Append file to harpoon starred list" })
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Check the list of files in harpoon" })

vim.keymap.set("n", "<C-j>", function()
	harpoon:list():select(1)
end, { desc = "Harpoon to 1st file in list" })
vim.keymap.set("n", "<C-k>", function()
	harpoon:list():select(2)
end, { desc = "Harpoon to 2nd file in list" })
vim.keymap.set("n", "<C-l>", function()
	harpoon:list():select(3)
end, { desc = "Harpoon to 3rd file in list" })
vim.keymap.set("n", "<C-;>", function()
	harpoon:list():select(4)
end, { desc = "Harpoon to 4th file in list" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-J>", function()
	harpoon:list():prev()
end, { desc = "Harpoon to previous file in list" })
vim.keymap.set("n", "<C-S-K>", function()
	harpoon:list():next()
end, { desc = "Harpoon to next file in list" })
