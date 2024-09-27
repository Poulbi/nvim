local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local map = vim.keymap.set

map("i", "<C-h>", function()
	if ls.expand_or_locally_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })
map({ "i", "s" }, "<C-l>", function()
	if ls.locally_jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })
map({ "i", "s" }, "<C-c>", function()
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
	ls.parser.parse_snippet("test", "$1->$2->$3->$0\n"),
})
ls.add_snippets("go", {
	ls.parser.parse_snippet("main", "package main\n\nfunc main() {\n\t$0\n}"),
	ls.parser.parse_snippet("e", "if err != nil {\n\t$1\n}\n$0"),
	ls.parser.parse_snippet("ep", "if err != nil {\n\tpanic(err)\n}\n$0"),
	ls.parser.parse_snippet("eif", "if err := $1; err != nil {\n\tpanic(err)\n}\n$0"),
	ls.parser.parse_snippet("pf", "fmt.Printf($0)"),
	ls.parser.parse_snippet("pl", "fmt.Println($0)"),
})
