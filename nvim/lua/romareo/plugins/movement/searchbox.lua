local M =  {

  "VonHeikemen/searchbox.nvim",
  dependencies = {
    { "MunifTanjim/nui.nvim" },
  },
}

function M.config()
    require("searchbox").setup({
        defaults = {
            reverse = false,
            exact = false,
            prompt = " ",
            modifier = "disabled",
            confirm = "off",
            clear_matches = true,
            show_matches = false,
        },
        popup = {
            relative = "win",
            position = {
                row = "5%",
                col = "95%",
            },
            size = 25,
            border = {
                style = "rounded",
                text = {
                    top = " Search ",
                    top_align = "left",
                },
            },
            win_options = {
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
            },
        },
    })

    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>fr", "<cmd>lua require('searchbox').replace()<CR>", { desc = "Open find and replace" })
    keymap.set("n", "<leader>fs", "<cmd>lua require('searchbox').match_all()<CR>", { desc = "Open find all" })
end

return M
