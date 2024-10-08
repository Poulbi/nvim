-- -- Custom highlight for markdown definitions
vim.cmd("hi mdDefs guifg=" .. require("nord.colors").palette.frost.ice)
vim.cmd("match mdDefs /^[[:space:]]*-[a-zA-Z ]\\+:/")
