local M = {}

-- TODO: windows
local HOME = os.getenv("HOME")
local CWD = vim.fn.getcwd()

-- NOTE(luca): This must be global so that the path can be referenced in the Options function
M.Projects = {
	Metac = {
		Path = HOME .. "/proj/metac",
		Options = function()
			vim.o.makeprg = M.Projects.Metac.Path .. "/misc/build.sh"
		end,
	},
}

for _, Project in pairs(M.Projects) do
	if string.find(CWD, Project.Path) then
		M.IsInProject = true
		Project.Options()
	end
end

return M
