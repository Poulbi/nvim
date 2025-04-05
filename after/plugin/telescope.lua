local telescope = require("telescope")
local builtin = require("telescope.builtin")
local map = vim.keymap.set

telescope.setup({
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

map("n", " ff", builtin.find_files)
map("n", " fb", builtin.buffers)
map("n", " fp", builtin.git_files)
map("n", " fw", builtin.live_grep)
map("n", " fh", builtin.help_tags)
map("n", " fk", builtin.keymaps)
map("n", " fs", builtin.spell_suggest)

-- symbols
map("n", " fe", "<cmd>lua require'telescope.builtin'.symbols{ sources = {'emoji', 'gitmoji'} }<CR>")
map("n", " fn", "<cmd>lua require'telescope.builtin'.symbols{ sources = {'nerd'} }<CR>")
map("n", " fj", "<cmd>lua require'telescope.builtin'.symbols{ sources = {'julia'} }<CR>")
map("n", " ft", "<cmd>lua require'telescope.builtin'.treesitter{ symbols = {'function'} }<CR>")

telescope.load_extension("fzf")
