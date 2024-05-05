local map_key = require("utils.key-mapper").map_key
return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "tsserver", "gopls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("neodev").setup({})

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.tsserver.setup({})
			lspconfig.gopls.setup({})
			-- lspconfig.jdtls.setup({})

			map_key("K", vim.lsp.buf.hover)
			map_key("gd", vim.lsp.buf.definition)
			map_key("<leader>a", vim.lsp.buf.code_action)

			-- debuger keymaps
			vim.keymap.set("n", "<F5>", function()
				require("dap").continue()
			end, { desc = "debuger continue" })
			vim.keymap.set("n", "<F10>", function()
				require("dap").step_over()
			end, { desc = "debuger step over" })
			vim.keymap.set("n", "<F11>", function()
				require("dap").step_into()
			end, { desc = "debuger step into" })
			vim.keymap.set("n", "<F12>", function()
				require("dap").step_out()
			end, { desc = "debuger step out" })
			vim.keymap.set("n", "<Leader>b", function()
				require("dap").toggle_breakpoint()
			end, { desc = "toggle breakpoint" })
			vim.keymap.set("n", "<Leader>B", function()
				require("dap").set_breakpoint()
			end, { desc = "set breakpoint" })
			vim.keymap.set("n", "<Leader>lp", function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, { desc = "set log point message" })
			vim.keymap.set("n", "<Leader>dr", function()
				require("dap").repl.open()
			end, { desc = "open repl" })
			vim.keymap.set("n", "<Leader>dl", function()
				require("dap").run_last()
			end, { desc = "run last debugging" })
			vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
				require("dap.ui.widgets").hover()
			end, { desc = "debug ui widget hover" })
			vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
				require("dap.ui.widgets").preview()
			end, { desc = "debug ui widget preview" })
			vim.keymap.set("n", "<Leader>df", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end, { desc = "debug ui widget frame" })
			vim.keymap.set("n", "<Leader>ds", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end, { desc = "debug ui wdiget scope" })
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		dependencies = { "mfussenegger/nvim-dap" },
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("dapui").setup({})

			-- 디버그 ui 자동 오픈
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			-- dap.listeners.before.event_terminated.dapui_config = function()
			-- 	dapui.close()
			-- end
			-- dap.listeners.before.event_exited.dapui_config = function()
			-- 	dapui.close()
			-- end

			vim.keymap.set("n", "<leader>d;", function()
				dapui.toggle()
			end, { desc = "dapui toggle" })

			-- 브레이크포인트 변경
			vim.api.nvim_command("highlight SignRed guifg=#f38ba8")
			vim.api.nvim_command("highlight SignOrange guifg=#fab387")

			vim.api.nvim_command("sign define DapBreakpoint text=● texthl=SignRed")
			vim.api.nvim_command("sign define DapStopped text= texthl=SignOrange")
		end,
	},
}
