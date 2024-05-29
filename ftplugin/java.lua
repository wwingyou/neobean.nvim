local home = os.getenv("HOME")
local jdtls_dir = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local plugins_dir = jdtls_dir .. "/plugins/"
local jar_name = vim.fn.system("ls " .. plugins_dir .. " | grep launcher_"):gsub("\n", "")
local path_to_jar = plugins_dir .. jar_name
local config_dir = jdtls_dir .. "/config_mac"
local path_to_lombok = jdtls_dir .. "/lombok.jar"

local root_markers = { ".git", "mvmw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
	print("Could not find root dir")
	return
end

local project_name = vim.fn.fnamemodify(root_dir, ":t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
os.execute("mkdir -p " .. workspace_dir)

local sdkman_candidates_dir = os.getenv("SDKMAN_CANDIDATES_DIR")
local jdtls_java_home = sdkman_candidates_dir .. "/java/21.0.2-tem"
local runtime_home = sdkman_candidates_dir .. "/java/current"
local java_version = vim.fn.system([[java --version]])
if java_version == "" or java_version == nil then
	print("Failed to get java version")
	return
end

local sdk_version = string.match(java_version, "(%d+).%d+.%d+")
local sdk_name = "JavaSE-" .. sdk_version

local bundles = {
	vim.fn.glob(
		home .. "/.local/share/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
		true
	),
}

vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/share/vscode-java-test/server/*.jar", true), "\n"))

local config = {
	cmd = {
		jdtls_java_home .. "/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.level=ALL",
		"-javaagent:" .. path_to_lombok,
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		path_to_jar,
		"-configuration",
		config_dir,
		"-data",
		workspace_dir,
	},
	root_dir = root_dir,
	settings = {
		java = {
			home = jdtls_java_home,
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
				runtimes = {
					{
						name = sdk_name,
						path = runtime_home,
					},
				},
			},
			maven = {
				downloadSources = true,
			},
			implementationCodeLens = {
				enabled = true,
			},
			referenceCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			format = {
				settings = {
					url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
		},
		signatureHelp = {
			enabled = true,
		},
		completion = {
			favoriteStaticMembers = {
				"org.hamcrest.MatcherAssert.assertThat",
				"org.hamcrest.Matchers.*",
				"org.junit.jupiter.api.Assertions.*",
				"java.util.Objects.requireNonNull",
				"java.util.Objects.requireNonNullElse",
				"org.mockito.Mockito.*",
			},
		},
		importOrder = {
			"java",
			"jakarta",
			"org",
			"com",
			"javax",
			"",
		},
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		codeGeneration = {
			generateComments = true,
			generateFinalModifierForParameters = true,
			generateFinalModifierForFields = true,
			generateFinalModifierForLocalVariables = true,
		},
		flags = {
			allow_incremental_sync = true,
		},
	},
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
