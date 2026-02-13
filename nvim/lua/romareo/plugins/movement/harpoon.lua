local M = {
  "ThePrimeagen/harpoon",
  keys = { "<leader>m", "<Tab>" },
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
}

function M.config()
  local keymap = Vim.keymap.set
  local opts = { noremap = true, silent = true }

  keymap("n", "<leader>m", "<cmd>lua require('romareo.plugins.movement.harpoon').mark_file()<cr>", opts)
  keymap("n", "<TAB>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)
end

function M.mark_file()
  require("harpoon.mark").add_file()
  Vim.notify("󱡅  marked file")
end

return M
