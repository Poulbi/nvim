local opt = vim.opt

-- Don't highlight on search
opt.hlsearch = false
opt.incsearch = true
opt.conceallevel = 2

-- Enable line numbers by default
opt.number = true
opt.relativenumber = true

-- Tab settings
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- Enable smart indenting
opt.smartindent = true

-- Enable break indent
opt.breakindent = true

local home = os.getenv("HOME")
-- History settings
opt.undofile = true
opt.swapfile = true
opt.backup = true
opt.writebackup = true
opt.undodir = home .. "/.local/state/nvim"
-- https://stackoverflow.com/a/1625850
opt.backupdir = home .. "/.local/share/Trash/nvim//,."
opt.directory = home .. "/.local/share/Trash/nvim//,."

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Decrease update time
opt.updatetime = 50
opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
opt.completeopt = "menuone,noselect"

-- Enable true color support
opt.termguicolors = true

-- Enable scroll off
opt.scrolloff = 8

-- Don't show mode I'm in, already have a nice status line for that
opt.showmode = false

-- Better split options
opt.splitbelow = true
opt.splitright = true

-- shared clipboard
opt.clipboard = "unnamed"
-- do not highlight matched bracket
opt.showmatch = false
-- highlight line at cursor
opt.cursorline = true
opt.textwidth = 100
opt.colorcolumn = "100"

-- status line
-- show ruler
opt.ruler = true
-- show command
opt.showcmd = true

opt.wildmenu = true

opt.mouse = ""

opt.backspace = "indent,eol,start"

opt.laststatus = 2
opt.history = 200
-- opt.encoding = "utf-8"
-- opt.fileencoding = "utf-8"

opt.smartindent = true
opt.scrolloff = 8

opt.spelllang = "en_us,nl"
opt.formatoptions = "tocqrnj"

-- Get the current working directory, replace the $HOME portion of the path with ~,
-- and extract the last three directories
local cwd = vim.fn.getcwd():gsub(os.getenv("HOME"), "~")
local last_dirs = string.match(cwd, "[^/]+/[^/]+/[^/]+/?$")
if last_dirs then
	opt.titlestring = last_dirs .. " -> %t"
else
	opt.titlestring = cwd .. " -> %t"
end

opt.title = true

-- Highlighting
vim.cmd("match Todo /\\(TODO\\|FIXME\\):/")

vim.cmd("match matchURL /" .. "\\(https\\?\\|ftp\\|magnet\\):\\/\\/[[:alnum:]%\\/_#.-~:]*" .. "/")
vim.cmd("hi matchURL guifg=" .. require("nord.colors").palette.aurora.yellow)

-- -- Custom highlight for markdown definitions
if vim.filetype.match({ buf = 0 }) == "markdown" then
	vim.cmd("match mdDefs /^[[:space:]]*-[^:]\\+:/")
	vim.cmd("hi mdDefs guifg=" .. require("nord.colors").palette.frost.ice)
end
