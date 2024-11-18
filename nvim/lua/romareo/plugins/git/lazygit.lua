local M=
{
 "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

function M.config()
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>gl", "<cmd>LazyGit<CR>", { desc = "Toggle LazyGit" }) -- toggle lazy git
end

return M
