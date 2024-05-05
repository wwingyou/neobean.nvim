return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		local languages = {
			"lua",
			"ruby",
			"go",
			"javascript",
			"html",
			"css",
			"typescript",
			"java",
			"groovy",
			"kotlin",
			"json",
			"yaml",
			"xml",
		}

		configs.setup({
			ensure_installed = languages,
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
