local M = {
	"folke/which-key.nvim",
}

function M.config()
	local which_key = require("which-key")
	which_key.setup({
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20,
			},
			presets = {
				operators = false,
				motions = false,
				text_objects = false,
				windows = false,
				nav = false,
				z = false,
				g = false,
			},
		},
		win = {
			border = "rounded",
			padding = { 2, 2 },
		},
		layout = {
			align = "left",
		},
		show_help = false,
		show_keys = false,
		disable = {
			buftypes = {},
			filetypes = { "TelescopePrompt" },
		},
		icons = {
			mappings = false, -- Disable icons for mappings
		},
	})

	local opts = {
		mode = "n", -- NORMAL mode
	}

	local mappings = {
		{
			{ "<leader>c", group = "cph" },
			{ "<leader>f", group = "file" },
			{ "<leader>g", group = "git" },
			{ "<leader>l", group = "lsp" },
			{ "<leader>q", "<cmd>confirm q<CR>", desc = "quit" },
			{ "<leader>t", group = "terminal" },
			{ "<leader>v", "<cmd>vsplit<CR>", desc = "split" },
		},
	}
	which_key.add(mappings, opts)
end

return M
