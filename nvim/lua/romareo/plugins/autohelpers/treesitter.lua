local M = {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
}

function M.config()
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python", "typescript" }, -- List of parsers to install
		highlight = { enable = true }, -- Enable highlighting
		indent = { enable = true }, -- Enable indentation
		modules = {}, -- This can be an empty table if no additional modules are needed
		sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
		ignore_install = {}, -- List of parsers to ignore installing
		auto_install = true, -- Automatically install missing parsers when entering buffer
	})
end

return M
