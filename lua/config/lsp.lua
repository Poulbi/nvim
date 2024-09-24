-- [[ Keybinds ]]
local map = vim.keymap.set
map("n", " la", vim.lsp.buf.code_action)
map("n", "gd", vim.lsp.buf.definition)
map("n", " r", vim.lsp.buf.rename)
map("n", " li", vim.lsp.buf.implementation)
map("n", " lh", vim.lsp.buf.signature_help)
map("n", " lt", vim.lsp.buf.typehierarchy)
map("n", " lr", vim.lsp.buf.references)
map("n", " ls", vim.lsp.buf.document_symbol)
map("n", " ld", vim.lsp.buf.type_definition)
map("n", " lq", vim.diagnostic.setqflist)

-- [[ LSP Setups ]]
local lspconfig = require("lspconfig")

lspconfig.gopls.setup({})
lspconfig.clangd.setup({})
lspconfig.emmet_ls.setup({})

-- lua
-- with neovim support
require("lspconfig").lua_ls.setup({
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			return
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
					-- "${3rd}/busted/library",
				},
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
				-- library = vim.api.nvim_get_runtime_file("", true)
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

-- [[ nvim cmp ]]
require("cmp_nvim_lsp").default_capabilities()
local cmp = require("cmp")
local context = require("cmp.config.context")
local lspkind = require("lspkind")
cmp.setup({
	enabled = function()
		if context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment") then
			return false
		else
			return true
		end
	end,
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-c>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() and cmp.get_active_entry() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				else
					fallback()
				end
			end,
			s = cmp.mapping.confirm({ select = true }),
			c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		}),
	}),
	sources = cmp.config.sources({
		{
			name = "nvim_lsp",
			keyword_length = 3,
		},
		{ name = "luasnip" },
	}, {
		-- { name = "buffer", max_item_count = 5 },
		{ name = "path", max_item_count = 5 },
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			menu = {
				buffer = "(Buffer)",
				nvim_lsp = "(LSP)",
				luasnip = "(LuaSnip)",
				nvim_lua = "(Lua)",
				latex_symbols = "(Latex)",
			},
		}),
	},
})

vim.api.nvim_set_hl(0, "CmpItemMenu", { italic = true })
