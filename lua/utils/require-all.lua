local require_all = function(directory)
	local files = vim.fn.glob(directory .. "/*.lua", false, true)
	local result = {}
	for i, file in ipairs(files) do
		result[i] = require(file)
	end
	return result
end

local require_all_cwd = function()
	return require_all(vim.fn.getcwd())
end

return { require_all = require_all, require_all_cwd = require_all_cwd }
