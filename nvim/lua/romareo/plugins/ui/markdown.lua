local M = {
	"MeanderingProgrammer/markdown.nvim",
	name = "render-markdown", -- for some reason this is required
	ft = "markdown",
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- Mandatory
		"nvim-tree/nvim-web-devicons", -- Optional but recommended
		"catppuccin/nvim", -- For mocha palette
	},
}

local function set_highlights()
	local colors = require("catppuccin.palettes").get_palette("mocha")
	local hl = function(name, opts)
		Vim.api.nvim_set_hl(0, "RenderMarkdown" .. name, opts)
	end

	hl("H1", { fg = colors.lavender, bold = true })
	hl("H2", { fg = colors.mauve, bold = true })
	hl("H3", { fg = colors.pink, bold = true })
	hl("H4", { fg = colors.flamingo, bold = true })
	hl("H5", { fg = colors.peach, bold = true })
	hl("H6", { fg = colors.yellow, bold = true })
	hl("Code", { bg = colors.crust })
	hl("CodeBorder", { bg = colors.surface0 })
	hl("CodeInline", { fg = colors.text, bg = colors.crust })
	hl("Quote", { fg = colors.rosewater, italic = true })
	hl("Bullet", { fg = colors.sky })
	hl("Link", { fg = colors.teal, underline = true })
end

function M.config()
	require("render-markdown").setup({
		heading = {
			backgrounds = {},
		},
		code = {
			-- size code blocks to content instead of stretching to window edge
			width = "block",
			left_pad = 1,
			right_pad = 1,
		},
		pipe_table = {
			preset = "round",
		},
	})

	set_highlights()
	-- colorscheme changes clear custom highlights, so reapply them
	Vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })
end

return M
