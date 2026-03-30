local M = {
  "numToStr/Comment.nvim",
  keys = {
    { "<leader>/", mode = { "n", "v" }, desc = "Comment" },
  },
}

function M.config()
  local wk = require("which-key")
  wk.add({
    { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment" },
    { "<leader>/", "<Plug>(comment_toggle_linewise_visual)",  mode = "v",      desc = "Comment" },
  })
end

return M
