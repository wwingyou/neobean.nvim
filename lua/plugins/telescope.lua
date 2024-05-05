local map_key = require("utils.key-mapper").map_key

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			map_key("<leader>ff", builtin.find_files)
			map_key("<leader>fg", builtin.live_grep)
			map_key("<leader>fb", builtin.buffers)
			map_key("<leader>fh", builtin.help_tags)
			map_key("<leader>fr", builtin.oldfiles)
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
