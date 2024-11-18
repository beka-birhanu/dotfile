local M = {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
}

function M.config()
	local icons = require("romareo.plugins.ui.icons")

	local keymap = vim.api.nvim_set_keymap
	keymap("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", { noremap = true, silent = true })
	keymap("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", { noremap = true, silent = true })

	require("gitsigns").setup({
		signs = {
			add = { text = icons.ui.BoldLineLeft },
			change = { text = icons.ui.LineLeft },
			delete = { text = icons.ui.Triangle },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = icons.ui.BoldLineDashedMiddle },
		},
		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
		linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
		watch_gitdir = {
			follow_files = true,
		},
		auto_attach = true,
		attach_to_untracked = true,
		current_line_blame = true, -- toggle with `:gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = true,
			virt_text_priority = 100,
		},
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- Use default
		max_file_length = 40000, -- Disable if file is longer than this (in lines)
		preview_config = {
			-- Options passed to nvim_open_win
			border = "single",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
	})
end

return M
