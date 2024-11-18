local M = {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		-- Optional: Add any additional options you want to configure for toggleterm
	},
}

function M.config()
	local keymap = vim.keymap -- for conciseness

	keymap.set("n", "<C-t>", "<cmd>lua require('toggleterm').toggle()<cr>", { desc = "Toggle a terminal" })
	keymap.set("t", "<C-t>", "<cmd>lua require('toggleterm').toggle()<cr>", { desc = "Toggle a terminal" })
end

return M
