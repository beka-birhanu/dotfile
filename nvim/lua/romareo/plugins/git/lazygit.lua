local M = {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = { "<leader>gl" },
}

function M.config()
  local keymap = Vim.keymap                                                     -- for conciseness

  keymap.set("n", "<leader>gl", "<cmd>LazyGit<CR>", { desc = "Toggle LazyGit" }) -- toggle lazy git
end

return M
