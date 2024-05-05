local map_key = require("utils.key-mapper").map_key

-- Neotree
map_key("<leader>e", ":Neotree toggle float<cr>")

-- window navigation
map_key("<C-h>", "<C-w>h") -- left
map_key("<C-j>", "<C-w>j") -- down
map_key("<C-k>", "<C-w>k") -- up
map_key("<C-l>", "<C-w>l") -- right

-- indent
map_key("<", "<gv", "v") -- 비주얼 모드에서 들여쓰기 후에도 여전히 비주얼 상태가 유지되도록 한다.
map_key(">", ">gv", "v")
