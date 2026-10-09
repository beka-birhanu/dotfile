local M = {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
}

local langs = {
  "lua",
  "markdown",
  "markdown_inline",
  "bash",
  "python",
  "typescript",
  "go",
  "gomod",
  "gosum",
  "rust",
  "yaml",
  "javascript",
  "dockerfile",
  "sql",
}

function M.config()
  require("nvim-treesitter").install(langs)

  Vim.api.nvim_create_autocmd("FileType", {
    callback = function(event)
      pcall(Vim.treesitter.start, event.buf)
    end,
  })
end

return M
