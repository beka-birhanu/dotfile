local M = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
	},
	cmd = "Mason",
	event = "VimEnter",
}

function M.config()
	require("mason").setup({
		ui = {
			border = "rounded",
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})

	require("mason-lspconfig").setup({
		ensure_installed = LSP_SERVERS,
		automatic_installation = true,
		automatic_enable = false,
	})
end

return M
