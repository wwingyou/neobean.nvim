local function get_data_path()
	local data_path = vim.fn.stdpath("data")
	if type(data_path) == "table" then
		data_path = data_path[0]
	end

	if data_path == nil then
		local home = os.getenv("HOME")
		if home == nil then
			data_path = "/usr/local/share" -- NOTE: This is a random path :)
		else
			data_path = vim.fs.joinpath(home, ".local", "share", "nvim")
		end
	end
	return data_path
end

local function get_cache_path()
	local cache_path = vim.fn.stdpath("cache")
	if type(cache_path) == "table" then
		cache_path = cache_path[0]
	end

	if cache_path == nil then
		local home = os.getenv("HOME")
		if home == nil then
			cache_path = "/usr/local/cache" -- NOTE: This one either :)
		else
			cache_path = vim.fs.joinpath(home, ".cache", "nvim")
		end
	end
	return cache_path
end


local plugins_root = vim.fs.joinpath(get_data_path(), "mason", "packages", "jdtls", "plugins")
local jdtls_jar = vim.fn.expand(vim.fs.joinpath(plugins_root, "org.eclipse.equinox.launcher_*.jar"))
local mason_share = vim.fs.joinpath(get_data_path(), "mason", "share", "jdtls")
local lombok_jar = vim.fs.joinpath(mason_share, "lombok.jar")
local config_dir = vim.fs.joinpath(mason_share, "/config")
local workspace_root = vim.fs.joinpath(get_cache_path(), "jdtls", "workspaces", "common-workspae")

local root_markers = { ".git", "mvmw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
	print("Could not find root dir")
	return
end

-- 워크스페이스 디렉토리 생성
-- 프로젝트 디렉토리에서 이름을 추출하여 워크스페이스마다 새로 생성한다.
local project_name = vim.fn.fnamemodify(root_dir, ":t")
local workspace_dir = vim.fs.joinpath(workspace_root, project_name)
os.execute("mkdir -p " .. workspace_dir)

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. lombok_jar,
		"-jar",
		jdtls_jar,
		"-configuration",
		config_dir,
		"-data",
		workspace_dir,
	},
	root_dir = root_dir,
}

require("jdtls").start_or_attach(config)

-- local jdtls = require("jdtls")
-- vim.keymap.set("n", "<leader>tc", function()
-- 	vim.cmd([[JdtUpdateDebugConfig]])
-- 	jdtls.test_class()
-- end, { desc = "junit class test" })
--
-- vim.keymap.set("n", "<leader>tm", function()
-- 	vim.cmd([[JdtUpdateDebugConfig]])
-- 	jdtls.test_nearest_method()
-- end, { desc = "junit method test" })
--
-- vim.keymap.set("n", "<F5>", function()
-- 	vim.cmd([[JdtUpdateDebugConfig]])
-- 	require("dap").continue()
-- end, { desc = "debuger continue (overriden for java)" })

vim.opt.tabstop = 4 -- 탭 하나의 너비
vim.opt.shiftwidth = 4 -- 들여쓰기의 너비
vim.opt.softtabstop = 4 -- 에디팅 중 탭을 누르면 추가되는 공간의 개수
