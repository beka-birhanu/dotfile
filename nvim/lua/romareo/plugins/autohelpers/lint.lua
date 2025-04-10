local M = {
	"mfussenegger/nvim-lint",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
}

LINTERS = {
	"eslint_d",
	"golangcilint",
	"ruff",
}

M.config = function()
	local lint = require("lint")

	lint.linters_by_ft = {
		javascript = { "eslint_d" },
		typescript = { "eslint_d" },
		javascriptreact = { "eslint_d" },
		typescriptreact = { "eslint_d" },
		go = { "golangcilint" },
		python = { "ruff" },
	}

	local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = lint_augroup,
		callback = function()
			lint.try_lint()
		end,
	})
end

return M
