local ls = require("luasnip")

local map = vim.keymap.set

map({ "i", "s" }, "<C-h>", function()
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
	-- Will update multiple nodes at the same time when in insert mode
	update_events = { "TextChanged", "TextChangedI" },
})

ls.add_snippets("go", {
	ls.parser.parse_snippet("main", "package main\n\nfunc main() {\n\t$0\n}"),
	ls.parser.parse_snippet("e", "if err != nil {\n\tpanic(err)$1\n}\n$0"),
	ls.parser.parse_snippet("ee", "if err != nil {\n\tfmt.Fprintln(os.Stderr, err)$1\n\tos.Exit(${2:1})\n}\n$0"),
	ls.parser.parse_snippet("eif", "if err := $1; err != nil {\n\tfmt.Println(err)$2\n}\n$0"),
	ls.parser.parse_snippet("pf", "fmt.Printf($0)"),
	ls.parser.parse_snippet("pl", "fmt.Println($0)"),
})
ls.add_snippets("sh", {
	ls.parser.parse_snippet("!", "#!/bin/sh\n$0"),
	ls.parser.parse_snippet("if", "if ${1:condition}; then\n\t$0\nfi"),
	ls.parser.parse_snippet("while", "while ${1:condition}; do\n\t$0\ndone"),
	ls.parser.parse_snippet("for", "for ${1:v} in ${2:list}; do\n\t$0\ndone"),
	ls.parser.parse_snippet("case", "case ${1:\\$var} in\n\t$0\nesac"),
})
ls.add_snippets("c", {
	ls.parser.parse_snippet("smain", "#include <stdio.h>\n\nint main(void) {\n\t$0\n\treturn 0;\n}"),
})
ls.add_snippets("typescript", {
	ls.parser.parse_snippet("cl", "console.log($0);"),
})
ls.add_snippets("html", {
	ls.parser.parse_snippet("t", [[<$1>$0</$1>]]),
})
