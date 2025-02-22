local M = {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
}

FORMATTERS = {
	"prettierd",
	"biome",
	"stylua",
	"goimports",
	"gofumpt",
	"autopep8",
}

M.config = function()
	local conform = require("conform")

	conform.setup({
		formatters_by_ft = {
			javascript = { "prettierd" },
			typescript = { "biome" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "biome" },
			css = { "prettierd" },
			html = { "prettierd" },
			json = { "prettierd" },
			yaml = { "prettierd" },
			markdown = { "prettierd" },
			graphql = { "prettierd" },
			razor = { "prettierd" },
			lua = { "stylua" },
			python = { "autopep8" },
			go = { "goimports", "gofumpt" },
		},

		format_after_save = {
			lsp_fallback = true,
			async = true,
		},
	})
end

return M
