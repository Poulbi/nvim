local M = {}

local HOME = os.getenv("HOME")
local CWD = vim.fn.getcwd()

M.Projects = {
	MetaC = {
		Path = HOME .. "/proj/metac",
		Options = function(self)
			vim.o.makeprg = self.Path .. "/source/build.sh"
		end,
	},
	Wasmpoc = {
		Path = HOME .. "/proj/probe/wasmpoc",
		Options = function(self)
			vim.o.makeprg = self.Path .. "/code/build.sh"
		end,
	},
}

M.InProject = false

for _, Project in pairs(M.Projects) do
	if string.find(CWD, Project.Path) then
		M.InProject = true
		Project.Options(Project)
	end
end

return M
