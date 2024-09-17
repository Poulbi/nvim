local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local map = vim.keymap.set

map("i", "<C-k>", function()
	if ls.expand_or_locally_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })
map({ "i", "s" }, "<C-J>", function()
	ls.locally_jumpable(-1)
end, { silent = true })
map({ "i", "s" }, "<C-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

-- temporary keybind to play around
map("n", "  s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<cr>")

ls.config.set_config({
	history = true,
})

ls.add_snippets("all", {
	ls.parser.parse_snippet("expand", "-- this is $1 expanded $2 $3!"),
})
