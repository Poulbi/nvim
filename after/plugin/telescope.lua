local map = vim.keymap.set
require("telescope").setup({
	defaults = {
		path_display = {
			shorten = {
				len = 3,
				exclude = { 1, -1 },
			},
			truncate = true,
		},
		dynamic_preview_title = true,
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
		["fzf"] = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

local builtin = require("telescope.builtin")
map("n", " ff", builtin.find_files)
map("n", " bl", builtin.buffers)
map("n", " fp", builtin.git_files)
map("n", " fw", builtin.live_grep)
map("n", " fh", builtin.help_tags)

-- symbols
map("n", " fe", "<cmd>lua require'telescope.builtin'.symbols{ sources = {'emoji', 'gitmoji'} }<CR>")
map("n", " fn", "<cmd>lua require'telescope.builtin'.symbols{ sources = {'nerd'} }<CR>")
map("n", " fj", "<cmd>lua require'telescope.builtin'.symbols{ sources = {'julia'} }<CR>")

require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")
