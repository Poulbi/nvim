-- [[ Keybinds ]]
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local cmp = require("cmp")
local context = require("cmp.config.context")
local diagnostic = vim.diagnostic
local lbuf = vim.lsp.buf
local map = vim.keymap.set
local lspconfig = require("lspconfig")
local lspkind = require("lspkind")
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
lspconfig.powershell_es.setup({
	cmd = {
		"pwsh",
		"-NoLog",
		"-NoProfile",
		"-Command",
		"/home/aluc/.local/share/nvim/mason/packages/powershell-editor-services/PowerShellEditorServices/Start-EditorServices.ps1",
	},
})
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
