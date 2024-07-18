-- with lazy.nvim

return {
	"glepnir/template.nvim",
	cmd = { "Template", "TemProject" },
	config = function()
		require("template").setup({
			temp_dir = "~/.config/nvim/templates",
			author = "wwingyou",
			email = "winwing.you@gmail.com",
		})
	end,
}

-- lazy load you can use cmd or ft. if you are using cmd to lazyload when you edit the template file
-- you may see some diagnostics in template file. use ft to lazy load the diagnostic not display
-- when you edit the template file.
