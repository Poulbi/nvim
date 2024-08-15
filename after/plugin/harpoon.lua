local harpoon = require("harpoon")
local map = vim.keymap.set

-- REQUIRED
harpoon:setup()

map("n", "<C-h>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

map("n", " ha", function() harpoon:list():add() end)
map("n", " h1", function() harpoon:list():select(1) end)
map("n", " h2", function() harpoon:list():select(2) end)
map("n", " h3", function() harpoon:list():select(3) end)
map("n", " h4", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
map("n", " hp", function() harpoon:list():prev() end)
map("n", " hn", function() harpoon:list():next() end)
