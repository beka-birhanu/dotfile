local M = {
	"ngtuonghy/live-server-nvim",
	event = "VeryLazy",
	build = ":LiveServerInstall",
}

function M.config()
	require("live-server-nvim").setup({
		custom = {
			"--port=8080",
			"--no-css-inject",
		},
		serverPath = vim.fn.stdpath("data") .. "/live-server/", --default
		open = "folder", -- folder|cwd     --default
	})
end

return M
