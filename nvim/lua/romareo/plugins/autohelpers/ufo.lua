local M = {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
		"luukvbaal/statuscol.nvim",
	},
}

function M.config()
	local builtin = require("statuscol.builtin")
	local cfg = {
		setopt = true,
		relculright = true,
		segments = {
			{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa", hl = "Comment" },
			{ text = { "%s" }, click = "v:lua.ScSa" },
			{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
		},
	}

	require("statuscol").setup(cfg)

	Vim.o.foldcolumn = "1" -- '0' is not bad
	Vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	Vim.o.foldlevelstart = 99
	Vim.o.foldenable = true
	Vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

	-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
	Vim.keymap.set("n", "zR", require("ufo").openAllFolds)
	Vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

	local handler = function(virtText, lnum, endLnum, width, truncate)
		local newVirtText = {}
		local suffix = (" 󰡏 %d "):format(endLnum - lnum)
		local sufWidth = Vim.fn.strdisplaywidth(suffix)
		local targetWidth = width - sufWidth
		local curWidth = 0
		for _, chunk in ipairs(virtText) do
			local chunkText = chunk[1]
			local chunkWidth = Vim.fn.strdisplaywidth(chunkText)
			if targetWidth > curWidth + chunkWidth then
				table.insert(newVirtText, chunk)
			else
				chunkText = truncate(chunkText, targetWidth - curWidth)
				local hlGroup = chunk[2]
				table.insert(newVirtText, { chunkText, hlGroup })
				chunkWidth = Vim.fn.strdisplaywidth(chunkText)
				-- str width returned from truncate() may less than 2nd argument, need padding
				if curWidth + chunkWidth < targetWidth then
					suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
				end
				break
			end
			curWidth = curWidth + chunkWidth
		end
		table.insert(newVirtText, { suffix, "MoreMsg" })
		return newVirtText
	end

	require("ufo").setup({
		fold_virt_text_handler = handler,
		close_fold_kinds = {},
		preview = {
			win_config = {
				border = { "", "─", "", "", "", "─", "", "" },
				winhighlight = "Normal:Folded",
				winblend = 0,
			},
			mappings = {
				scrollU = "<C-k>",
				scrollD = "<C-j>",
				jumpTop = "[",
				jumpBot = "]",
			},
		},
	})

	Vim.keymap.set("n", "zR", require("ufo").openAllFolds)
	Vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
	Vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
	Vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
	Vim.keymap.set("n", "K", function()
		local winid = require("ufo").peekFoldedLinesUnderCursor()
		if not winid then
			Vim.lsp.buf.hover()
		end
	end)
end

return M
