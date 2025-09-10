-- Automatically remove 'cro' from 'formatoptions' on BufWinEnter
Vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		-- Removes the 'cro' option from 'formatoptions'
		Vim.cmd("set formatoptions-=cro")
	end,
})

-- Automatically resize windows when the Vim window is resized
Vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		-- Equalize the sizes of all windows when Vim is resized
		Vim.cmd("tabdo wincmd =")
	end,
})

-- Check file timestamps when entering any buffer
Vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = { "*" },
	callback = function()
		-- Checks the file for changes since last load
		Vim.cmd("checktime")
	end,
})

-- Automatically enable wrapping and spellcheck for certain file types
Vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
	callback = function()
		-- Enable line wrapping and spell checking in these file types
		Vim.opt_local.wrap = true
		Vim.opt_local.spell = true
	end,
})

-- Automatically unlink current snippet on CursorHold if it is expandable
Vim.api.nvim_create_autocmd({ "CursorHold" }, {
	callback = function()
		-- Check if 'luasnip' is available and unlink the current snippet if expandable
		local status_ok, luasnip = pcall(require, "luasnip")
		if not status_ok then
			return
		end
		-- Unlink snippet if it's possible
		if luasnip.expand_or_jumpable() then
			-- Unlink the current snippet silently
			Vim.cmd([[silent! lua require("luasnip").unlink_current()]])
		end
	end,
})

-- Automatically set key mappings for Go file type
Vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		-- Add a custom keybinding for Go files
		Vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"<leader>ge",
			"oif err != nil {\n\treturn nil, err\n}",
			{ noremap = true, silent = true }
		)
	end,
})
