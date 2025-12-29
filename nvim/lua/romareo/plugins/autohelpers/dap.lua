local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
    "nvim-neotest/nvim-nio",
  },
  lazy = true,
  event = "InsertEnter",
}

M.config = function()
  local dap = require("dap")
  local dapui = require("dapui")
  local widgets = require("dap.ui.widgets")
  dapui.setup()

  -- debuggers
  require("dap-go").setup()

  -- auto ui jobs
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end

  -- keymaps
  Vim.keymap.set("n", "<Leader>dc", function()
    dap.continue()
  end)
  Vim.keymap.set("n", "<Leader>do", function()
    dap.step_over()
  end)
  Vim.keymap.set("n", "<Leader>di", function()
    dap.step_into()
  end)
  Vim.keymap.set("n", "<Leader>da", function()
    dap.step_out()
  end)
  Vim.keymap.set("n", "<Leader>db", function()
    dap.toggle_breakpoint()
  end)
  Vim.keymap.set("n", "<Leader>dp", function()
    dap.set_breakpoint(nil, nil, Vim.fn.input("Log point message: "))
  end)
  Vim.keymap.set("n", "<Leader>dr", function()
    dap.repl.open()
  end)
  Vim.keymap.set("n", "<Leader>dl", function()
    dap.run_last()
  end)
  Vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
    widgets.hover()
  end)
  Vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
    widgets.preview()
  end)
  Vim.keymap.set("n", "<Leader>df", function()
    widgets.centered_float(widgets.frames)
  end)
  Vim.keymap.set("n", "<Leader>ds", function()
    widgets.centered_float(widgets.scopes)
  end)
end

return M
