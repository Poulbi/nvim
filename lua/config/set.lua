local opt = vim.opt
-- TODO: Check if HOME directory exists
local home = os.getenv("HOME")

-- remove start screen
opt.shortmess:append("I")

opt.hlsearch = false
opt.incsearch = true
opt.conceallevel = 2
opt.signcolumn = "no"
opt.tabstop = 1
opt.softtabstop = 1
opt.shiftwidth = 1
opt.expandtab = false
opt.smartindent = true
opt.breakindent = true
opt.backspace = "indent,eol,start"

opt.undofile = true
opt.swapfile = true
opt.backup = true
opt.writebackup = true
opt.undodir = home .. "/.local/state/nvim"
opt.backupdir = home .. "/.local/share/Trash/nvim//,."
opt.directory = home .. "/.local/share/Trash/nvim//,."

opt.ignorecase = true
opt.smartcase = true

opt.updatetime = 50
opt.timeoutlen = 300
opt.completeopt = ""
opt.scrolloff = 8
opt.splitbelow = true
opt.splitright = true
opt.clipboard = "unnamed"

-- opt.laststatus = 2
-- opt.showmode = false
-- opt.showmatch = false
-- opt.showcmd = true
opt.cursorline = true
opt.textwidth = 0
-- opt.colorcolumn = "102"
opt.termguicolors = true
opt.ruler = true
opt.wildmenu = true
opt.mouse = ""
opt.history = 200

-- opt.encoding = "utf-8"
-- opt.fileencoding = "utf-8"
opt.smartindent = true
opt.scrolloff = 8
-- opt.spelllang = "en_us,nl"
opt.formatoptions = "tocqrnj"

opt.title = true

-- vim.opt.fillchars = { fold = " " }
-- vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.g.markdown_folding = 1

local cwd = vim.fn.getcwd():gsub(home, "~")
local IsInCWD = string.match(cwd, "[^/]+/[^/]+/[^/]+/?$")
if IsInCWD then
	opt.titlestring = IsInCWD .. " -> %t"
else
	opt.titlestring = cwd .. " -> %t"
end

opt.makeprg = "./build.sh"

-- Highlighting
vim.api.nvim_set_hl(0, "matchNotes", { fg = require("nord.colors").palette.frost.ice })
vim.fn.matchadd("matchNotes", "NOTE\\((.*)\\)\\?:")
vim.api.nvim_set_hl(0, "matchTodos", { fg = require("nord.colors").palette.aurora.yellow })
vim.fn.matchadd("matchTodos", "\\(TODO\\|FIXME\\)\\((.*)\\)\\?:")
vim.api.nvim_set_hl(0, "matchErrors", { fg = require("nord.colors").palette.aurora.red })
vim.fn.matchadd("matchErrors", "\\(BUG\\|ERROR\\)\\((.*)\\)\\?:")
vim.api.nvim_set_hl(0, "matchImportant", { fg = require("nord.colors").palette.aurora.yellow })
vim.fn.matchadd("matchImportant", "IMPORTANT\\((.*)\\)\\?:")
