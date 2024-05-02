-- Setup my mini.nvim settings
-- mini.nvim is amazing because it add's a lot of functionality while keeping itself as minimal as possible
-- because of it's modular nature and fact it has a lot of functionality it lower the amount of needed plugins even for advanced features

-- mini.nvim statusline module
require("mini.statusline").setup({
	set_vim_settings = false,
})

-- mini.nvim commeting module
require("mini.comment").setup({})

-- mini.nvim surround module
-- require("mini.surround").setup({})
