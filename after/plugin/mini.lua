require("mini.statusline").setup({
	set_vim_settings = false,
})

require("mini.surround").setup({
	silent = true,
	mappings = {
		add = "gsa",
		delete = "gsd",
		find = "gsf",
		find_left = "gsF",
		highlight = "gsh",
		replace = "gsr",
		update_n_lines = "gsn",
	},
})
