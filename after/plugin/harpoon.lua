local harpoon = require("harpoon")
local map = vim.keymap.set

-- REQUIRED
harpoon:setup()

map("n", "<C-h>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon pick menu" })

map("n", " ha", function()
	harpoon:list():add()
	print("Added to harpoon.")
end, { desc = "Harpoon add" })
map("n", " h1", function()
	harpoon:list():select(1)
end, { desc = "Harpoon 1" })
map("n", " h2", function()
	harpoon:list():select(2)
end, { desc = "Harpoon 2" })
map("n", " h3", function()
	harpoon:list():select(3)
end, { desc = "Harpoon 3" })
map("n", " h4", function()
	harpoon:list():select(4)
end, { desc = "Harpoon 4" })

-- Toggle previous & next buffers stored within Harpoon list
map("n", " hp", function()
	harpoon:list():prev()
end, { desc = "Harpoon previous" })
map("n", " hn", function()
	harpoon:list():next()
end, { desc = "Harpoon next" })
