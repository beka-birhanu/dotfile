local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
}

function M.config()
  local servers = {
    -- Lua
    "lua_ls",
    "stylua",

    -- Shell/Bash
    "bashls",

    -- TypeScript/JavaScript
    "ts_ls",
    "prettierd",
    "eslint_d",
    "tailwindcss",
    "html",
    "cssls",
    "emmet_ls",

    -- Python
    "pyright",
    "autopep8",
    "ruff",

    -- Go
    "gopls",
    "goimports",
    "golangcilint",

    -- Docker
    "dockerls",
    "docker_compose_language_service",

    -- Prisma
    "prismals",

    -- C#
    "csharpier",
    "Roslyn Analyzers",

    -- Miscellaneous
    "biome",
  }


  require("mason").setup({
    ui = {
      border = "rounded",
    },
  })

  require("mason-lspconfig").setup({
    ensure_installed = servers,
  })
end

return M
