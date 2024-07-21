vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- find package for java file
_G.get_package = function()
	local path = vim.fn.expand("%:p:h")
	local _, last_index = string.find(path, "java/")
	if last_index then
		return string.gsub(string.sub(path, last_index + 1, -1), "/", ".")
	end
	return "package_not_found"
end
