local M = {
  "numToStr/Comment.nvim",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  keys = {
    { "<leader>/", mode = { "n", "v" }, desc = "Comment" },
  },
}

function M.config()
  local comment = require("Comment")
  comment.setup({
    pre_hook = require(
      "ts_context_commentstring.integrations.comment_nvim"
    ).create_pre_hook(),
  })

  local wk = require("which-key")

  wk.add({
    {
      "<leader>/",
      "<Plug>(comment_toggle_linewise_current)",
      desc = "Comment",
    },
    {
      "<leader>/",
      "<Plug>(comment_toggle_linewise_visual)",
      mode = "v",
      desc = "Comment",
    },
  })
end

return M
