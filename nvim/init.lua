Vim = vim
require("romareo.plugins.utils.launch")
require("romareo.core.options")
require("romareo.core.keymaps")
require("romareo.plugins.autohelpers.autocmds")

--UI
Spec("romareo.plugins.ui.colorscheme")
Spec("romareo.plugins.ui.devicons")
Spec("romareo.plugins.ui.breadcrumbs")
Spec("romareo.plugins.ui.illuminate")
Spec("romareo.plugins.ui.lualine")
Spec("romareo.plugins.ui.navic")
Spec("romareo.plugins.ui.dashboard")
Spec("romareo.plugins.ui.markdown")
Spec("romareo.plugins.ui.csv")

-- autohelpers
Spec("romareo.plugins.autohelpers.treesitter")
Spec("romareo.plugins.autohelpers.lspconfig")
Spec("romareo.plugins.autohelpers.cmp")
Spec("romareo.plugins.autohelpers.mason")
Spec("romareo.plugins.autohelpers.autoclose")
Spec("romareo.plugins.autohelpers.comment")
Spec("romareo.plugins.autohelpers.oil")
Spec("romareo.plugins.autohelpers.ufo")
Spec("romareo.plugins.autohelpers.lint")
Spec("romareo.plugins.autohelpers.conform")
Spec("romareo.plugins.autohelpers.luasnip")
Spec("romareo.plugins.autohelpers.dap")

-- movement
Spec("romareo.plugins.movement.whichkey")
Spec("romareo.plugins.movement.nvimtree")
Spec("romareo.plugins.movement.fterm")
Spec("romareo.plugins.movement.telescope")
Spec("romareo.plugins.movement.harpoon")
-- spec("romareo.plugins.movement.neoscroll")

-- CPH
Spec("romareo.plugins.cph.cph")

-- git
Spec("romareo.plugins.git.gitsign")
Spec("romareo.plugins.git.gitfugitive")
Spec("romareo.plugins.git.lazygit")

-- ai
Spec("romareo.plugins.ai.supermaven")
-- spec("romareo.plugins.ai.copilot")

require("romareo.plugins.utils.lazy")
