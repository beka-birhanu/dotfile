local M = {
	"zbirenbaum/copilot.lua",
	lazy = true,
	event = "InsertEnter",
}

function M.config()
	require("copilot").setup({
		-- Possible configurable fields can be found on:
		-- https://github.com/zbirenbaum/copilot.lua#setup-and-configuration
		suggestion = {
			enable = true,
			auto_trigger = true,
			keymap = {
				accept = "<C-y>",
				next = "<C-]>",
				prev = "<C-[>",
				discard = "<C-n>",
			},
		},
		panel = {
			enable = false,
		},
		filetypes = {
			markdown = true,
		},
	})
end

return M
