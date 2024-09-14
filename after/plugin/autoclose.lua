local filetypes = require("autoclose").setup({
	keys = {
		["("] = { escape = false, close = true, pair = "()" },
		[")"] = { escape = true, close = false, pair = "()" },
		["["] = { escape = false, close = true, pair = "[]" },
		["]"] = { escape = true, close = false, pair = "[]" },
		["{"] = { escape = false, close = true, pair = "{}" },
		["}"] = { escape = true, close = false, pair = "{}" },
		[">"] = { escape = true, close = false, pair = "<>" },
		['"'] = {
			escape = true,
			close = true,
			pair = '""',
			disabled_filetypes = { "text", "telekasten", "groff", "diff", "gitcommit", "fugitive", "markdown" },
		},
		["'"] = {
			escape = true,
			close = true,
			pair = "''",
			disabled_filetypes = { "text", "telekasten", "groff", "diff", "gitcommit", "fugitive", "markdown" },
		},
		["`"] = {
			escape = true,
			close = true,
			pair = "``",
			disabled_filetypes = { "text", "telekasten", "groff", "diff", "gitcommit", "fugitive" },
		},
		["*"] = { escape = true, close = true, pair = "**", enabled_filetypes = { "markdown" } },
		["_"] = { escape = true, close = true, pair = "__", enabled_filetypes = { "markdown" } },
	},
	options = {
		disable_when_touch = true,
	},
})
