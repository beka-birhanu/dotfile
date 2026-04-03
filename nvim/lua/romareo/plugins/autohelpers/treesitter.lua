local M = {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
}

function M.config()
  require("nvim-treesitter").install({
    "lua",
    "markdown",
    "markdown_inline",
    "bash",
    "python",
    "typescript",
    "go",
    "rust",
    "yaml",
    "javascript",
    "dockerfile",
  })
end

return M
