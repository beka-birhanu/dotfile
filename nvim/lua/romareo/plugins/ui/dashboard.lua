return {
  "beka-birhanu/dashboard-nvim",
  lazy = true,
  event = "UIEnter",
  config = function()
    require("dashboard").setup({
      config = {
        week_header = {
          enable = true,
        },
        project = { 
          enable = false
        },
        mru = {
          enable = false,
        },
      },
    })
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
