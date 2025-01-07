-- [[ Keybinds ]]
local diagnostic = vim.diagnostic
local lbuf = vim.lsp.buf
local map = vim.keymap.set
local lspconfig = require("lspconfig")
local builtin = require("telescope.builtin")

map("n", " <cr>", lbuf.code_action, { desc = "Code actions" })
map("n", "gd", lbuf.definition, { desc = "Definition" })
map("i", "<C-k>", lbuf.hover)
map("n", " lr", lbuf.rename, { desc = "Rename" })
map("n", " li", builtin.lsp_implementations, { desc = "Implementation" })
map("n", " ls", lbuf.signature_help, { desc = "Signature help" })
map("n", " lh", lbuf.typehierarchy, { desc = "Type hierarchy" })
map("n", " lf", lbuf.references, { desc = "References" })
map("n", " ll", lbuf.document_symbol, { desc = "List symbols" })
map("n", " lt", lbuf.type_definition, { desc = "Type definition" })
-- map("n", " lls", vim.lsp.handlers["workspace/symbol"])
map("n", " lq", diagnostic.setqflist, { desc = "Diagnostic quickfix" })
map("n", " >>", diagnostic.goto_next, { desc = "Diagnostic next" })
map("n", " <<", diagnostic.goto_prev, { desc = "Diagnostic prev" })
map("n", " <,", function()
	diagnostic.goto_next({ severity = diagnostic.ERROR })
end, { desc = "Diagnostic next error" })
map("n", " >.", function()
	diagnostic.goto_prev({ severity = diagnostic.ERROR })
end, { desc = "Diagnostic prev error" })
map("n", " vf", diagnostic.open_float, { desc = "Diagnostics open floating window" })
-- map("n", " ")

-- vim.lsp.inlay_hint(0, false)

-- [[ LSP Setups ]]

lspconfig.gopls.setup({
	-- 	settings = {
	-- 		gopls = {
	-- 			hints = {
	-- 				assignVariableTypes = true,
	-- 				compositeLiteralFields = true,
	-- 				compositeLiteralTypes = true,
	-- 				constantValues = true,
	-- 				functionTypeParameters = true,
	-- 				parameterNames = true,
	-- 				rangeVariableTypes = true,
	-- 			},
	-- 		},
	-- 	},
})
lspconfig.clangd.setup({})
lspconfig.emmet_ls.setup({})
lspconfig.ts_ls.setup({})
-- lspconfig.powershell_es.setup({
-- 	cmd = {
-- 		"pwsh",
-- 		"-NoLog",
-- 		"-NoProfile",
-- 		"-Command",
-- 		"/home/aluc/.local/share/nvim/mason/packages/powershell-editor-services/PowerShellEditorServices/Start-EditorServices.ps1",
-- 	},
-- })
lspconfig.lua_ls.setup({
	-- with neovim support
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			return
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

-- rounded border around floating windows
local _border = "rounded"
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = _border,
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = _border,
})
vim.diagnostic.config({
	float = { border = _border },
})

local autocmd = vim.api.nvim_create_autocmd
autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end
		if vim.tbl_contains({ "null-ls" }, client.name) then -- blacklist lsp
			return
		end
	end,
})

local ls = require("luasnip")

local map = vim.keymap.set
local parse_snippet = ls.parser.parse_snippet

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

ls.config.set_config({
	history = true,
	-- Will update multiple nodes at the same time when in insert mode
	update_events = { "TextChanged", "TextChangedI" },
})

ls.add_snippets("go", {
	parse_snippet("main", "package main\n\nfunc main() {\n\t$0\n}"),
	parse_snippet("e", "if err != nil {\n\tpanic(err)$1\n}$0"),
	parse_snippet("ee", "if err != nil {\n\tfmt.Fprintln(os.Stderr, err)$1\n\tos.Exit(${2:1})\n}\n$0"),
	parse_snippet("eif", "if err := $1; err != nil {\n\tfmt.Println(err)$2\n}\n$0"),
	parse_snippet("pf", "fmt.Printf($0)"),
	parse_snippet("pl", "fmt.Println($0)"),
})
ls.add_snippets("sh", {
	parse_snippet("!", "#!/bin/sh\n$0"),
	parse_snippet("if", "if ${1:condition}; then\n\t$0\nfi"),
	parse_snippet("while", "while ${1:condition}; do\n\t$0\ndone"),
	parse_snippet("for", "for ${1:v} in ${2:list}; do\n\t$0\ndone"),
	parse_snippet("case", "case ${1:\\$var} in\n\t$0\nesac"),
})
ls.add_snippets("c", {
	parse_snippet("main", "int\nmain(int Argc, char *Args[])\n{\n\t$0\n\treturn 0;\n}"),
	parse_snippet(
		"uints",
		[[#include <stdint.h>
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
typedef int8_t s8;
typedef int16_t s16;
typedef int32_t s32;
typedef int64_t s64;
]]
	),
})
ls.add_snippets("typescript", { parse_snippet("cl", "console.log($0);") })
ls.add_snippets("html", { parse_snippet("t", [[<$1>$0</$1>]]) })
