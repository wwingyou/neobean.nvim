local map_key = require("utils.key-mapper").map_key
return {
	"folke/todo-comments.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("todo-comments").setup({})

		map_key("<leader>xt", ":TodoQuickFix<cr>")
		map_key("<leader>ft", ":TodoTelescope<cr>")
	end,
}
