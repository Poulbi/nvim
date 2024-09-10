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
	-- lsp setup
	{
		-- LSP Support
		"neovim/nvim-lspconfig",
		-- lsp download manager
		"williamboman/mason.nvim",
		-- automatic lsp setup
		"williamboman/mason-lspconfig.nvim",
		-- additional formater support
		"stevearc/conform.nvim",
		-- additional linter support
		"mfussenegger/nvim-lint",
		-- mason autoinstaller for formatter's and linter's
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- minimal snippet's support
		"dcampos/nvim-snippy",
		-- basic snippet's
		"honza/vim-snippets",
		-- cmp for autocompletion
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				-- cmp nvim-lsp plugin
				"hrsh7th/cmp-nvim-lsp",
				-- path comletion
				"hrsh7th/cmp-path",
				-- cmp snippy support
				"dcampos/cmp-snippy",
			},
		},
		-- kind icons
		"onsails/lspkind.nvim",
		-- Minimal neovim modules for a lot of things
		"echasnovski/mini.nvim",
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		-- better ntrw
		"tpope/vim-vinegar",
		-- integration with tmux keybinds
		"christoomey/vim-tmux-navigator",
		-- auto close brackets
		"m4xshen/autoclose.nvim",
	},

    "mg979/vim-visual-multi",

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

	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
	},

	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	{
		-- harpoon your way around code
		{
			"ThePrimeagen/harpoon",
			branch = "harpoon2",
			requires = { "nvim-lua/plenary.nvim", lazy = true },
		},
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
	install = {
		colorscheme = { "nord" },
	},
	checker = { enabled = false },
	-- defaults = {lazy = true},
})
