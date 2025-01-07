-- lower level in purple and red
vim.api.nvim_set_hl(0, "MDdepthTwo", { fg = require("nord.colors").palette.aurora.purple })
vim.fn.matchadd("MDdepthTwo", "^##")
vim.api.nvim_set_hl(0, "MDdepthThree", { fg = require("nord.colors").palette.aurora.red })
vim.fn.matchadd("MDdepthThree", "^###\\+")
-- definitions
vim.api.nvim_set_hl(0, "MDDefs", { fg = require("nord.colors").palette.frost.ice })
vim.fn.matchadd("MDDefs", "^[[:space:]]*\\([-*]\\|[0-9]\\+[.)]\\)[^:]\\+::")
