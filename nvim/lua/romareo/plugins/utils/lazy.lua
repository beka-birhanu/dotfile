local lazypath = Vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not Vim.loop.fs_stat(lazypath) then
  Vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
Vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = LAZY_PLUGIN_SPEC,
  install = {
    colorscheme = { "darkplus", "default" },
  },
  ui = {
    border = "rounded",
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
})
