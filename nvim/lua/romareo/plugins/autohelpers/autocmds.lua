-- Automatically remove 'cro' from 'formatoptions' on BufWinEnter
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		-- Removes the 'cro' option from 'formatoptions'
		vim.cmd("set formatoptions-=cro")
	end,
})

-- Automatically apply key mappings and set buffer-specific options for certain file types
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = {
		"netrw",
		"Jaq",
		"qf",
		"git",
		"help",
		"man",
		"lspinfo",
		"oil",
		"spectre_panel",
		"lir",
		"DressingSelect",
		"tsplayground",
		"",
	},
	callback = function()
		-- Map 'q' to ':close' and set buffer to not be listed in buffers
		vim.cmd([[
			nnoremap <silent> <buffer> q :close<CR>
			set nobuflisted
		]])
	end,
})

-- Automatically quit when entering the command window
vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
	callback = function()
		-- Quits when entering the command window
		vim.cmd("quit")
	end,
})

-- Automatically resize windows when the Vim window is resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		-- Equalize the sizes of all windows when Vim is resized
		vim.cmd("tabdo wincmd =")
	end,
})

-- Check file timestamps when entering any buffer
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = { "*" },
	callback = function()
		-- Checks the file for changes since last load
		vim.cmd("checktime")
	end,
})

-- Highlight yanked text with a visual highlight
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		-- Highlight yanked text for 40ms with 'Visual' highlight group
		vim.highlight.on_yank({ higroup = "Visual", timeout = 40 })
	end,
})

-- Automatically enable wrapping and spellcheck for certain file types
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
	callback = function()
		-- Enable line wrapping and spell checking in these file types
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Automatically unlink current snippet on CursorHold if it is expandable
vim.api.nvim_create_autocmd({ "CursorHold" }, {
	callback = function()
		-- Check if 'luasnip' is available and unlink the current snippet if expandable
		local status_ok, luasnip = pcall(require, "luasnip")
		if not status_ok then
			return
		end
		-- Unlink snippet if it's possible
		if luasnip.expand_or_jumpable() then
			-- Unlink the current snippet silently
			vim.cmd([[silent! lua require("luasnip").unlink_current()]])
		end
	end,
})

-- Automatically set key mappings for Go file type
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		-- Add a custom keybinding for Go files
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"<leader>ge",
			"oif err != nil {\n\treturn nil, err\n}",
			{ noremap = true, silent = true }
		)
	end,
})
