local M = {
	"rmagatti/goto-preview",
	event = "BufEnter",
}

function M.config()
	require("goto-preview").setup()
end

return M
