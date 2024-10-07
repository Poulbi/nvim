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

-- ID of autocmd for CFormat
vim.b.CFormatID = nil
-- Enable formatting on save for C only when using the :CFormat command
vim.api.nvim_create_user_command("CFormat", function()
	if vim.b.CFormatID == nil then
		vim.b.CFormatID = vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = 0,
			callback = function()
				conform.format({ formatters = { "clang-format" } })
			end,
		})
		conform.format({ formatters = { "clang-format" } })
		print("Auto formatting enabled.")
	else
		vim.api.nvim_del_autocmd(vim.b.CFormatID)
		print("Auto formatting disabled.")
		vim.b.CFormatID = nil
	end
end, {})
