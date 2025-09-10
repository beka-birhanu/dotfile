local M = {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
}

function M.config()
	require("catppuccin").setup({
		transparent_background = true,
		float = {
			transparent = true, -- enable transparent floating windows
			solid = false, -- use solid styling for floating windows, see |winborder|
		},
		highlight_overrides = {
			all = function()
				return {}
			end,
			latte = function()
				return {}
			end,
			frappe = function()
				return {}
			end,
			macchiato = function()
				return {}
			end,
			mocha = function(mocha)
				return {
					-- Neovim Colours
					-- Tabline-
					TabLineFill = { fg = mocha.lavender, bg = mocha.base },
					TabLineSel = { fg = mocha.subtext1, bg = mocha.surface1 },
					TabLine = { fg = mocha.overlay, bg = mocha.surface0 },
					-- Editor
					Comment = { fg = mocha.overlay1 },
					CursorLineNR = { fg = mocha.purple },
					-- Other color definitions...
					String = { fg = mocha.text }, -- Set string color to white
					-- Floats
					FloatBorder = { fg = mocha.overlay1 },
					-- Mason Colours-
					MasonHeader = { fg = mocha.base, bg = mocha.peach },
					MasonHeaderSecondary = { fg = mocha.base, bg = mocha.teal },
					MasonHighlight = { fg = mocha.teal },
					MasonHighlightBlock = { bg = mocha.teal, fg = mocha.base },
					MasonHighlightBlockBold = { bg = mocha.teal, fg = mocha.base, bold = true },
					MasonHighlightSecondary = { fg = mocha.red },
					MasonHighlightBlockSecondary = { bg = mocha.red, fg = mocha.base },
					MasonHighlightBlockBoldSecondary = { bg = mocha.red, fg = mocha.base, bold = true },
					MasonLink = { fg = mocha.rosewater },
					MasonMuted = { fg = mocha.overlay1 },
					MasonMutedBlock = { bg = mocha.surface, fg = mocha.overlay1 },
					MasonMutedBlockBold = { bg = mocha.surface, fg = mocha.overlay1, bold = true },
					MasonError = { fg = mocha.red },
					MasonHeading = { bold = true },
					-- Alpha Colours
					AlphaHeader = { fg = mocha.surface0 },
					AlphaFooter = { fg = mocha.surface2 },
					AlphaSectionHeader = { fg = mocha.surface2, bold = true },
					AlphaShortcut = { fg = mocha.surface2 },
					--Telescope Colours
					TelescopeNormal = { fg = mocha.text },
					TelescopeBorder = { fg = mocha.surface2 },
					TelescopeTitle = { fg = mocha.subtext },
					--ToggleTerm Custom Colours
					LazygitBorder = { fg = mocha.surface2 },
					-- Class Highlighting
					Type = { fg = mocha.blue },
					-- Highlighting for Generics
					Boolean = { fg = mocha.purple }, -- Adjust color as needed
					Number = { fg = mocha.purple }, -- Adjust color as needed
					Generics = { fg = mocha.purple }, -- Adjust color as needed
					-- Highlighting for Constants
					Constant = { fg = mocha.green }, -- Adjust color as needed
					-- Cmp Colours
					CmpNormal = { fg = mocha.text },
					CmpBorder = { fg = mocha.surface2 },
					CmpTitle = { fg = mocha.subtext },
				}
			end,
		},
	})
	Vim.cmd.colorscheme("catppuccin")
end

return M
