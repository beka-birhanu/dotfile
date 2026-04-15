local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "folke/neodev.nvim",
    },
  },
  event = "BufReadPre",
}

LSP_SERVERS = {
  "lua_ls",
  "bashls",
  "ts_ls",
  "pylsp",
  "html",
  "cssls",
  "tailwindcss",
  "emmet_ls",
  "prismals",
  "dockerls",
  "docker_compose_language_service",
  "gopls",
  "buf_ls",
  "yamlls",
  "rust_analyzer",
  "clangd",
  "ltex",
  "postgres_lsp",
}

M.on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = Vim.api.nvim_buf_set_keymap

  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "gsd", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "gsi", "<cmd>vsplit | <cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
end

function M.common_capabilities()
  local capabilities = Vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

function M.config()
  local wk = require("which-key")
  local icons = require("romareo.plugins.ui.icons")
  local servers = LSP_SERVERS

  -- 1. Setup global diagnostic configuration
  local default_diagnostic_config = {
    signs = {
      active = true,
      text = {
        [Vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
        [Vim.diagnostic.severity.WARN]  = icons.diagnostics.Warning,
        [Vim.diagnostic.severity.HINT]  = icons.diagnostics.Hint,
        [Vim.diagnostic.severity.INFO]  = icons.diagnostics.Information,
      },
    },
    virtual_text = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  Vim.diagnostic.config(default_diagnostic_config)


  -- 2. Setup floating windows borders
  local border = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
  }

  local orig_util_open_floating_preview = Vim.lsp.util.open_floating_preview
  function Vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end

  Vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
    config = config or {}
    config.border = "rounded"
    return Vim.lsp.handlers.hover(err, result, ctx, config)
  end

  Vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
    config = config or {}
    config.border = "rounded"
    return Vim.lsp.handlers.signature_help(err, result, ctx, config)
  end
  require("lspconfig.ui.windows").default_options.border = "rounded"

  -- 3. Setup which-key keybindings
  wk.add({
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",         desc = "Code Action" },
    { "<leader>li", "<cmd>checkhealth lsp<cr>",                       desc = "LSP Health" },
    { "<leader>lj", "<cmd>lua vim.diagnostic.jump({count = 1})<cr>",  desc = "Next Diagnostic" },
    { "<leader>lk", "<cmd>lua vim.diagnostic.jump({count = -1})<cr>", desc = "Prev Diagnostic" },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",              desc = "Rename" },
  })

  -- 4. Setup each LSP server
  Vim.lsp.config("*", {
    on_attach = M.on_attach,
    capabilities = M.common_capabilities(),
  })

  for _, server in pairs(servers) do
    local require_ok, settings = pcall(require, "romareo.plugins.autohelpers.lspsettings." .. server)
    if require_ok then
      Vim.lsp.config(server, settings)
    end
  end

  Vim.lsp.enable(servers)
end

return M
