local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- html = { "prettier" },
		go = { "goimports", "gofmt" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "never",
	},
})

conform.formatters["clang-format"] = {
	prepend_args = {
		"--style",
		"{"
			.. "IndentWidth: 4, "
			.. "AlignAfterOpenBracket: BlockIndent, "
			.. "AlignConsecutiveAssignments: Consecutive, "
			.. "AlignArrayOfStructures: Right, "
			.. "BreakBeforeBraces: Linux, "
			.. "ColumnLimit: "
			.. vim.o.tw
			.. "}",
	},
}

-- Enable formatting on save for C only when using the :CFormat command
vim.api.nvim_create_user_command("CFormat", function()
	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = 0,
		callback = function()
			conform.format({ formatters = { "clang-format" } })
		end,
	})
	conform.format({ formatters = { "clang-format" } })
	vim.cmd.write()
end, {})
