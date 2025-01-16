local gitsigns = require("gitsigns")
gitsigns.setup({
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "▎" },
		topdelete = { text = "▎" },
		changedelete = { text = "▎" },
		untracked = { text = "▎" },
	},
	numhl = false,
	attach_to_untracked = true,
	update_debounce = 0,
	on_attach = function()
		local map = vim.keymap.set
	        -- stylua: ignore start
	        map("n", "]g", gitsigns.next_hunk, { desc = "Next git hunk" })
	        map("n", "[g", gitsigns.prev_hunk, { desc = "Previous git hunk" })
            map("n", " gd", gitsigns.toggle_deleted, { desc="Toggle deleted"})
            map("n", " gr", gitsigns.reset_hunk, { desc="Reset hunk"})
            map("n", " gs", gitsigns.stage_hunk, { desc="Stage hunk"})
            map("n", " gu", gitsigns.undo_stage_hunk, { desc="Undo stage hunk"})
	    map("n", " gb", gitsigns.blame, { desc="Blame"})
	end,
})
