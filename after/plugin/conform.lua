require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- html = { "prettier" },
		go = { "goimports", "gofmt" },
		c = { "clang-format" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

require("conform").formatters["clang-format"] = {
	prepend_args = {
		"--style",
		"{IndentWidth: 4, AlignAfterOpenBracket: BlockIndent, AlignConsecutiveAssignments: Consecutive, AlignArrayOfStructures: Right, BreakBeforeBraces: Linux}",
	},
}
