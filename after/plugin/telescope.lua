require('telescope').setup({
	defaults = {
		path_display = {
			shorten = {
				len = 3, exclude = {1, -1}
			},
			truncate = true
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

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader><leader>', builtin.buffers)
vim.keymap.set('n', '<leader>fg', builtin.git_files)
vim.keymap.set('n', '<leader>fw', builtin.live_grep)
vim.keymap.set("n", "<C-p>", "<cmd>Telescope git_files<cr>", { desc = "Find git files" })
vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "Find help tags" })

-- symbols
vim.keymap.set("n", "<leader>tse", "<cmd>lua require'telescope.builtin'.symbols{ sources = {'emoji', 'gitmoji'} }<CR>")
vim.keymap.set("n", "<leader>tsn", "<cmd>lua require'telescope.builtin'.symbols{ sources = {'nerd'} }<CR>")
vim.keymap.set("n", "<leader>tsj", "<cmd>lua require'telescope.builtin'.symbols{ sources = {'julia'} }<CR>")

require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")
