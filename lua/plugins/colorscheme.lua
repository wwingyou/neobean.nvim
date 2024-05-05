return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				custom_highlights = function(colors)
					return {
						WinSeparator = { fg = colors.overlay0 },
					}
				end,
				integrations = {
					treesitter = true,
				},
			})
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"shaunsingh/seoul256.nvim",
		lazy = true,
	},
	{
		"shaunsingh/seoul256.nvim",
		lazy = true,
	},
}
