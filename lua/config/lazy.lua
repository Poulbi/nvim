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
	"tpope/vim-vinegar",
	"norcalli/nvim-colorizer.lua",
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
