-- bootstraping
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- plugins installation and configuration
require("lazy").setup({
	"echasnovski/mini.nvim",
	"tpope/vim-fugitive",
	"lewis6991/gitsigns.nvim",
	"tpope/vim-vinegar",
	"tpope/vim-eunuch",
	"mg979/vim-visual-multi",
	"jghauser/follow-md-links.nvim",
	"m4xshen/autoclose.nvim",
	"stevearc/conform.nvim",
	-- "mfussenegger/nvim-lint",
	-- "neovim/nvim-lspconfig",
	-- {
	-- 	"norcalli/nvim-colorizer.lua",
	-- 	config = function()
	-- 		-- require("colorizer").setup()
	-- 	end,
	-- },
	--
	-- {
	-- 	"williamboman/mason.nvim",
	-- 	dependencies = {
	-- 		"williamboman/mason-lspconfig.nvim",
	-- 		-- for formatters and linters
	-- 		"WhoIsSethDaniel/mason-tool-installer.nvim",
	-- 	},
	-- 	config = function()
	-- 		require("mason").setup({
	-- 			ui = {
	-- 				border = "rounded",
	-- 			},
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"ray-x/lsp_signature.nvim",
	-- 	event = "LspAttach",
	-- },
	-- {
	-- 	--snippets
	-- 	"L3MON4D3/LuaSnip",
	-- 	version = "v2.*",
	-- 	build = "make install_jsregexp",
	-- },
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	dependencies = {
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 		"hrsh7th/cmp-path",
	-- 		"hrsh7th/cmp-buffer",
	-- 		"saadparwaiz1/cmp_luasnip",
	-- 		"onsails/lspkind.nvim",
	-- 	},
	-- 	event = { "InsertEnter", "CmdlineEnter" },
	-- },

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			win = {
				border = "rounded",
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<M-h>", "<cmd>TmuxNavigateLeft<cr>" },
			{ "<M-j>", "<cmd>TmuxNavigateDown<cr>" },
			{ "<M-k>", "<cmd>TmuxNavigateUp<cr>" },
			{ "<M-l>", "<cmd>TmuxNavigateRight<cr>" },
			{ "<M-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
		},
	},

	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},

	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		init = function()
			vim.g.startuptime_tries = 10
		end,
	},

	{
		"gbprod/nord.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nord").setup({
				transparent = false,
				terminal_colors = true, -- `:terminal`
				diff = { mode = "bg" },
				borders = true,
				-- values : [bg|fg|none]
				errors = { mode = "bg" },
				-- values : [vim|vscode]
				search = { theme = "vim" },
				styles = {
					-- `:help nvim_set_hl`
					comments = { italic = true },
					keywords = { bold = true },
					functions = { bold = true },
					variables = { bold = true },
					-- To customize lualine/bufferline
					bufferline = {
						current = {},
						modified = { italic = true },
					},
				},
			})
			vim.cmd.colorscheme("nord")
		end,
	},
	{
		-- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { "nvim-lua/plenary.nvim", lazy = true },
	},

	-- DAP
	{
		{
			"mfussenegger/nvim-dap",
		},
		{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	},
}, {

	-- lazy options
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	-- install = {
	-- 	colorscheme = { "nord" },
	-- 	missing = false,
	-- },
	-- change_detection = {
	-- 	enabled = true,
	-- 	notify = true,
	-- },
	-- checker = { enabled = true, notify = false },
})
