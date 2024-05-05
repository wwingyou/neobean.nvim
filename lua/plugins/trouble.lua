local map_key = require("utils.key-mapper").map_key

return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		map_key("<leader>xx", ":TroubleToggle<cr>")
		map_key("<leader>xw", ":TroubleToggle workspace_diagnostics<cr>")
		map_key("<leader>xd", ":TroubleToggle document_diagnostics<cr>")
		map_key("<leader>xq", ":TroubleToggle quickfix<cr>") -- 오류난 부분들 빠르게 찾기(?)
		map_key("<leader>xl", ":TroubleToggle loclist<cr>") -- 위치 리스트로 대신 보여주기(?)
		map_key("gR", ":TroubleToggle lsp_references<cr>") -- 커서 아래 키워드의 LSP ref 보여주기
	end,
}
