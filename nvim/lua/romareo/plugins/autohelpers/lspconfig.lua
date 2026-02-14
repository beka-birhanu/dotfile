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

  Vim.lsp.handlers["textDocument/hover"] = Vim.lsp.with(Vim.lsp.handlers.hover, { border = "rounded" })
  Vim.lsp.handlers["textDocument/signatureHelp"] =
      Vim.lsp.with(Vim.lsp.handlers.signature_help, { border = "rounded" })
  require("lspconfig.ui.windows").default_options.border = "rounded"

  -- 3. Setup which-key keybindings
  wk.add({
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",  desc = "Code Action" },
    { "<leader>li", "<cmd>LspInfo<cr>",                        desc = "Info" },
    { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
    { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",       desc = "Rename" },
  })

  -- 4. Setup each LSP server
  for _, server in pairs(servers) do
    local opts = {
      on_attach = M.on_attach,
      capabilities = M.common_capabilities(),
    }

    local require_ok, settings = pcall(require, "romareo.plugins.autohelpers.lspsettings." .. server)
    if require_ok then
      opts = Vim.tbl_deep_extend("force", settings, opts)
    end

    Vim.lsp.config(server, opts)
    Vim.lsp.enable(server)
  end
end

return M
