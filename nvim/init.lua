Vim = vim
require("romareo.plugins.utils.launch")
require("romareo.core.options")
require("romareo.core.keymaps")
require("romareo.plugins.autohelpers.autocmds")

--UI
spec("romareo.plugins.ui.colorscheme")
spec("romareo.plugins.ui.devicons")
spec("romareo.plugins.ui.breadcrumbs")
spec("romareo.plugins.ui.illuminate")
spec("romareo.plugins.ui.lualine")
spec("romareo.plugins.ui.navic")
spec("romareo.plugins.ui.dashboard")
spec("romareo.plugins.ui.markdown")
spec("romareo.plugins.ui.csv")

-- autohelpers
spec("romareo.plugins.autohelpers.treesitter")
spec("romareo.plugins.autohelpers.lspconfig")
spec("romareo.plugins.autohelpers.cmp")
spec("romareo.plugins.autohelpers.mason")
spec("romareo.plugins.autohelpers.autoclose")
spec("romareo.plugins.autohelpers.comment")
spec("romareo.plugins.autohelpers.oil")
spec("romareo.plugins.autohelpers.ufo")
spec("romareo.plugins.autohelpers.lint")
spec("romareo.plugins.autohelpers.conform")
spec("romareo.plugins.autohelpers.luasnip")
spec("romareo.plugins.autohelpers.dap")

-- movement
spec("romareo.plugins.movement.whichkey")
spec("romareo.plugins.movement.nvimtree")
spec("romareo.plugins.movement.fterm")
spec("romareo.plugins.movement.telescope")
spec("romareo.plugins.movement.harpoon")
spec("romareo.plugins.movement.neoscroll")

-- CPH
spec("romareo.plugins.cph.cph")

-- git
spec("romareo.plugins.git.gitsign")
spec("romareo.plugins.git.gitfugitive")
spec("romareo.plugins.git.lazygit")

-- ai
spec("romareo.plugins.ai.supermaven")
-- spec("romareo.plugins.ai.copilot")

require("romareo.plugins.utils.lazy")
