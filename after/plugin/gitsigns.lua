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

		local function map(mode, l, r, desc)
			vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
		end

        -- stylua: ignore start
        map("n", "]g", gs.next_hunk, "Next git hunk")
        map("n", "[g", gs.prev_hunk, "Previous git hunk")
	end,
})
