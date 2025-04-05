-- bootstraping
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

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
				terminal_colors = true,
				diff = { mode = "bg" },
				borders = true,
				errors = { mode = "bg" },
				search = { theme = "vim" },
				styles = {
					comments = { italic = true },
					keywords = { bold = true },
					functions = { bold = true },
					variables = { bold = true },
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
})
