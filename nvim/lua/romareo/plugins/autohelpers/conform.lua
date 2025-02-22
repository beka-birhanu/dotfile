return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
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
				c_sharp = { "csharpier" },
				go = { "goimports", "gofumpt" },
			},

			format_after_save = {
				lsp_fallback = true,
				async = true,
			},
		})
	end,
}
