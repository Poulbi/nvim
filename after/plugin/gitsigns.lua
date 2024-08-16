require("gitsigns").setup({
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "▎" },
		topdelete = { text = "▎" },
		changedelete = { text = "▎" },
		untracked = { text = "▎" },
	},
	on_attach = function(buffer)
		local gs = package.loaded.gitsigns
		local map = vim.keymap.set

	        -- stylua: ignore start
	        map("n", "]g", gs.next_hunk, { desc = "Next git hunk" })
	        map("n", "[g", gs.prev_hunk, { desc = "Previous git hunk" })
	end,
})
