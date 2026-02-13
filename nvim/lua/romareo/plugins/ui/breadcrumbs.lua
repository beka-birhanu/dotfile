local M = {
	"LunarVim/breadcrumbs.nvim",
	event = "BufReadPost",
}

function M.config()
	require("breadcrumbs").setup()
end

return M
