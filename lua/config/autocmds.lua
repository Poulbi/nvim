local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- [[ Highlight on yank ]]
autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- [[ Auto create parent directory if it doesn't exist ]]
autocmd("BufWritePre", {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Run gofmt + goimports on save
local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").goimports()
	end,
	group = format_sync_grp,
})

autocmd("TermOpen", {
	callback = function()
		local o = vim.opt_local
		o.signcolumn = "no"
		o.number = false
		o.relativenumber = false
		vim.cmd("startinsert")
		vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
	end,
})
-- -- close automatically when shell process exits
-- -- TODO: does not work
-- autocmd("TermClose", {
-- 	callback = function()
-- 		vim.cmd("bdelete")
-- 	end,
-- })
vim.keymap.set("n", "!", "<cmd>sp<CR><cmd>term<CR>", { desc = "Open terminal" })

-- [[ preserve last position ]]
autocmd("BufReadPost", {
	pattern = "*",
	command = 'silent! normal! g`"zv',
})

-- [[ no cursorline in insert mode ]]
local cursorGrp = augroup("CursorLine")
autocmd({ "InsertLeave", "WinEnter" }, {
	pattern = "*",
	command = "set cursorline",
	group = cursorGrp,
	desc = "show cursor line only in active window",
})
autocmd({ "InsertEnter", "WinLeave" }, { pattern = "*", command = "set nocursorline", group = cursorGrp })

-- [[ spellchecker activated in txt files ]]
autocmd(
	{ "BufRead", "BufNewFile" },
	-- { pattern = { "*.txt", "*.md", "*.tex" }, command = [[setlocal spell<cr> setlocal spelllang=en,de<cr>]] }
	{
		pattern = { "*.txt" },
		callback = function()
			vim.opt.spell = true
			vim.opt.spelllang = "en"
		end,
		desc = "Enable spell checking for certain file types",
	}
)
