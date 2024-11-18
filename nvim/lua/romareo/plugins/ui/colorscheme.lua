local M = {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
}

function M.config()
	require("catppuccin").setup({
		highlight_overrides = {
			all = function(colors)
				return {}
			end,
			latte = function(latte)
				return {}
			end,
			frappe = function(frappe)
				return {}
			end,
			macchiato = function(macchiato)
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
					FloatBorder = { fg = mocha.surface2 },
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
					TelescopeNormal = { fg = mocha.text, bg = mocha.mantle },
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
				}
			end,
		},
	})
	vim.cmd.colorscheme("catppuccin")
end

return M
