local M = {
    "numToStr/FTerm.nvim",
    lazy = false,
}

function M.config()
    require("FTerm").setup({
        border = "rounded",
        dimensions = {
            height = 0.8,
            width = 0.8,
        },
    })

    local keymap = vim.keymap -- for conciseness
    keymap.set("n", "<A-f>", "<cmd>lua require('FTerm').toggle()<cr>", { desc = "Open a floating terminal" })
    keymap.set("t", "<A-f>", "<cmd>lua require('FTerm').toggle()<cr>", { desc = "Close a floating terminal" })
end

return M
