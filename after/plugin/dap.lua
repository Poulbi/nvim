local dap = require("dap")
local dapui = require("dapui")
local widgets = require("dap.ui.widgets")
local map = vim.keymap.set

dapui.setup()
-- stylua: ignore start
map("n", " bu", function() dapui.toggle() end, { desc = "Toggle dap-ui" })
map("n", " bb", function() dap.toggle_breakpoint() end, { desc = "Toggle breakpoint" })
map("n", " bc", function() dap.continue() end, {desc="Continue"})
map("n", " bs", function() dap.step_over() end, {desc="Step over"})
map("n", " bi", function() dap.step_into() end, {desc="Step into"})
map("n", " bo", function() dap.step_out() end, {desc="Step out"})
map({ "n", "v" }, " bh", function() widgets.hover() end, {desc="Show hover"})
map({ "n", "v" }, " bv", function() widgets.preview() end, {desc="Show preview"})
map("n", " bf", function() widgets.centered_float(widgets.frames) end, {desc="Show frames"})
map("n", " bp", function() widgets.centered_float(widgets.scopes) end, {desc="Show scopes"})
-- stylua: ignore end
map("n", " bl", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "Break point with log" })

dap.adapters.gdb = {
	id = "gdb",
	type = "executable",
	command = "gdb",
	args = { "--quiet", "--interpreter=dap" },
}

dap.configurations.c = {
	{
		name = "Run (GDB)",
		type = "gdb",
		request = "launch",
		-- This requires special handling of 'run_last', see
		-- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
		program = function()
			local path = vim.fn.input({
				prompt = "Path to executable: ",
				default = vim.fn.getcwd() .. "/",
				completion = "file",
			})

			return (path and path ~= "") and path or dap.ABORT
		end,
	},
	{
		name = "Run with arguments (GDB)",
		type = "gdb",
		request = "launch",
		-- This requires special handling of 'run_last', see
		-- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
		program = function()
			local path = vim.fn.input({
				prompt = "Path to executable: ",
				default = vim.fn.getcwd() .. "/",
				completion = "file",
			})

			return (path and path ~= "") and path or dap.ABORT
		end,
		args = function()
			local args_str = vim.fn.input({
				prompt = "Arguments: ",
			})
			return vim.split(args_str, " +")
		end,
	},
	{
		name = "Attach to process (GDB)",
		type = "gdb",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}
