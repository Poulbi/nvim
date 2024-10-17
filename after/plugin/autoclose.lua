local function in_comment()
	if
		require("cmp.config.context").in_treesitter_capture("comment") == true
		or require("cmp.config.context").in_syntax_group("Comment")
	then
		return true
	else
		return false
	end
end

local autoclose = require("autoclose")
autoclose.setup({
	keys = {
		["("] = { escape = false, close = true, pair = "()" },
		[")"] = { escape = true, close = false, pair = "()" },
		["["] = { escape = false, close = true, pair = "[]" },
		["]"] = { escape = true, close = false, pair = "[]" },
		["{"] = { escape = false, close = true, pair = "{}" },
		["}"] = { escape = true, close = false, pair = "{}" },
		[">"] = { escape = true, close = false, pair = "<>" },
		['"'] = { escape = true, close = true, pair = '""' },
		["'"] = {
			escape = true,
			close = true,
			pair = "''",
			disabled_filetypes = { "text", "telekasten", "groff", "diff", "gitcommit", "fugitive", "markdown" },
			disabled_when = in_comment,
		},
		["`"] = {
			escape = true,
			close = true,
			pair = "``",
			enabled_filetypes = { "markdown", "go", "javascript" },
		},
		["_"] = {
			escape = false,
			close = true,
			pair = "__",
			enabled_filetypes = { "markdown" },
			disabled_when = in_comment,
		},
		["*"] = {
			escape = false,
			close = true,
			pair = "**",
			enabled_filetypes = { "markdown" },
			disabled_when = in_comment,
		},
	},
	options = {
		disable_when_touch = true,
		disable_command_mode = true,
	},
})
