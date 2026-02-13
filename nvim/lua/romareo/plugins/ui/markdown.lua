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

function M.config()
	local colors = require("catppuccin.palettes").get_palette("mocha")

	require("render-markdown").setup({
		heading = {
			h1 = { fg = colors.lavender, bold = true },
			h2 = { fg = colors.mauve, bold = true },
			h3 = { fg = colors.pink, bold = true },
			h4 = { fg = colors.flamingo, bold = true },
			h5 = { fg = colors.peach, bold = true },
			h6 = { fg = colors.yellow, bold = true },
			backgrounds = {},
		},
		code = {
			bg = colors.crust,
			fg = colors.text,
			border = colors.surface0,
		},
		quote = {
			fg = colors.rosewater,
			italic = true,
		},
		list = {
			fg = colors.sky,
		},
		link = {
			fg = colors.teal,
			underline = true,
		},
	})
end

return M
