local M = {}

local HOME = os.getenv("HOME")
local CWD = vim.fn.getcwd()

M.Projects = {
	MetaC = {
		Path = HOME .. "/proj/metac",
		Options = function()
			vim.o.makeprg = M.Projects.MetaC.Path .. "/source/build.sh"
		end,
	},
}

M.InProject = false

for _, Project in pairs(M.Projects) do
	if string.find(CWD, Project.Path) then
		M.InProject = true
		Project.Options()
	end
end

return M
