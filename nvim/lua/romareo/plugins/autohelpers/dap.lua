local M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"leoluz/nvim-dap-go",
		"nvim-neotest/nvim-nio",
	},
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
	vim.keymap.set("n", "<Leader>dc", function()
		dap.continue()
	end)
	vim.keymap.set("n", "<Leader>do", function()
		dap.step_over()
	end)
	vim.keymap.set("n", "<Leader>di", function()
		dap.step_into()
	end)
	vim.keymap.set("n", "<Leader>da", function()
		dap.step_out()
	end)
	vim.keymap.set("n", "<Leader>db", function()
		dap.toggle_breakpoint()
	end)
	vim.keymap.set("n", "<Leader>dp", function()
		dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	end)
	vim.keymap.set("n", "<Leader>dr", function()
		dap.repl.open()
	end)
	vim.keymap.set("n", "<Leader>dl", function()
		dap.run_last()
	end)
	vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
		widgets.hover()
	end)
	vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
		widgets.preview()
	end)
	vim.keymap.set("n", "<Leader>df", function()
		widgets.centered_float(widgets.frames)
	end)
	vim.keymap.set("n", "<Leader>ds", function()
		widgets.centered_float(widgets.scopes)
	end)
end

return M
