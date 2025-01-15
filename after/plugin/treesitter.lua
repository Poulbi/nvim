require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "bash" },
	sync_install = false,
	auto_install = true,

	indent = {
		enable = true,
	},

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
		disable = { "c" },
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			node_incremental = "v",
			node_decremental = "V",
		},
	},
})
-- vim.api.nvim_buf_create_user_command
-- vim.keymap.set("n", "")
