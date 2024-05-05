local ext_path = vim.fn.glob("~/.config/nvim/ext/")

local bundles = {
	vim.fn.glob(
		ext_path
			.. "com/microsoft/java/com.microsoft.java.debug.plugin/0.52.0/com.microsoft.java.debug.plugin-0.52.0.jar",
		true
	),
}

vim.list_extend(bundles, vim.split(vim.fn.glob(ext_path .. "vscode-java-test/server/*.jar", true), "\n"))

local config = {
	cmd = { ext_path .. "jdtls/1.35.0/bin/jdtls" },
	root_dir = vim.fs.dirname(vim.fs.find({ "build.gradle", ".git", "pom.xml" }, { upward = true })[1]),
	init_options = {
		bundles = bundles,
	},
}
require("jdtls").start_or_attach(config)

local jdtls = require("jdtls")
vim.keymap.set("n", "<leader>tc", function()
	vim.cmd([[JdtUpdateDebugConfig]])
	jdtls.test_class()
end, { desc = "junit class test" })

vim.keymap.set("n", "<leader>tm", function()
	vim.cmd([[JdtUpdateDebugConfig]])
	jdtls.test_nearest_method()
end, { desc = "junit method test" })

vim.keymap.set("n", "<F5>", function()
	vim.cmd([[JdtUpdateDebugConfig]])
	require("dap").continue()
end, { desc = "debuger continue (overriden for java)" })

vim.opt.tabstop = 4 -- 탭 하나의 너비
vim.opt.shiftwidth = 4 -- 들여쓰기의 너비
vim.opt.softtabstop = 4 -- 에디팅 중 탭을 누르면 추가되는 공간의 개수
