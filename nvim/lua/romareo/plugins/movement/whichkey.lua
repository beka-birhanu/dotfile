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
			{ "<leader>t", group = "telescope" },
			{ "<leader>g", group = "git" },
			{ "<leader>l", group = "lsp" },
			{ "<leader>q", "<cmd>confirm q<CR>", desc = "quit" },
			{ "<leader>v", "<cmd>vsplit<CR>", desc = "vertical split" },
			{ "<leader>b", "<cmd>split<CR>", desc = "horizontal split" },
			{
				"<leader>f",
				function()
					local cur_width = vim.api.nvim_win_get_width(0)
					local cur_height = vim.api.nvim_win_get_height(0)
					local total_width = vim.o.columns
					local total_height = vim.o.lines - vim.o.cmdheight

					-- If already maximized in both dimensions → equalize
					if cur_width >= total_width - 5 and cur_height >= total_height - 5 then
						vim.cmd("wincmd =") -- equalize all windows
					else
						vim.cmd("wincmd |") -- maximize width
						vim.cmd("wincmd _") -- maximize height
					end
				end,
				desc = "Toggle maximize/equalize split (width & height)",
			},
		},
	}
	which_key.add(mappings, opts)
end

return M
