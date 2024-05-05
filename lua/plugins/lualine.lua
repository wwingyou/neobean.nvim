return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin-mocha",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true, -- enable global statusline (have a single statusline
				-- at bottom of neovim instead of one for  every window).
				-- This feature is only available in neovim 0.7 and higher.
			},
		})
	end,
}
