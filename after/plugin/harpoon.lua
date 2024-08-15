local harpoon = require("harpoon")
local map = vim.keymap.set

-- REQUIRED
harpoon:setup()

map("n", "<C-h>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Check the list of files in harpoon" })

map("n", " ha", function()
	harpoon:list():add()
end, { desc = "Append file to harpoon starred list" })
map("n", " h1", function()
	harpoon:list():select(1)
end, { desc = "Harpoon to 1st file in list" })
map("n", " h2", function()
	harpoon:list():select(2)
end, { desc = "Harpoon to 2nd file in list" })
map("n", " h3", function()
	harpoon:list():select(3)
end, { desc = "Harpoon to 3rd file in list" })
map("n", " h4", function()
	harpoon:list():select(4)
end, { desc = "Harpoon to 4th file in list" })

-- Toggle previous & next buffers stored within Harpoon list
map("n", " hp", function()
	harpoon:list():prev()
end, { desc = "Harpoon to previous file in list" })
map("n", " hn", function()
	harpoon:list():next()
end, { desc = "Harpoon to next file in list" })
